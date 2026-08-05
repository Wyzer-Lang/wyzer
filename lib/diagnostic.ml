open Ast

(** Severity level of a diagnostic. *)
type severity =
  | Error
  | Warning
  | Note
  | Help

(** A labelled annotation on a source span. *)
type label = {
  span    : span;
  message : string;
}

(** An actionable patch/diff suggestion. *)
type patch = {
  span        : span;
  replacement : string;
}

(** A full diagnostic record. *)
type diagnostic = {
  code             : string;            (** e.g. "E001" *)
  severity         : severity;
  message          : string;            (** primary headline *)
  primary_label    : label;
  secondary_labels : label list;
  notes            : string list;       (** "note:" lines *)
  hints            : string list;       (** "help:" lines *)
  patches          : patch list;        (** inline diff suggestions *)
}

(** Raised by the typechecker / parser when a span-aware error occurs.
    Caught by bin/main.ml and rendered via [emit]. *)
exception LocatedError of diagnostic

(* ANSI colour helpers *)

let use_color =
  (* Check for NO_COLOR env var (https://no-color.org) and TTY *)
  (not (Sys.getenv_opt "NO_COLOR" |> Option.is_some)) &&
  (try Unix.isatty Unix.stderr with Unix.Unix_error _ -> false)

let ansi codes =
  if use_color then "\027[" ^ codes ^ "m" else ""

let reset       = ansi "0"
let bold        = ansi "1"
let fg_red      = ansi "1;31"
let fg_green    = ansi "1;32"
let fg_yellow   = ansi "1;33"
let fg_cyan     = ansi "1;36"
let fg_blue     = ansi "1;34"

let sev_color = function
  | Error   -> fg_red
  | Warning -> fg_yellow
  | Note    -> fg_cyan
  | Help    -> fg_blue

let sev_label = function
  | Error   -> "error"
  | Warning -> "warning"
  | Note    -> "note"
  | Help    -> "help"

(* Source file cache *)

let _file_cache : (string, string array) Hashtbl.t = Hashtbl.create 16

let get_source_lines filename =
  match Hashtbl.find_opt _file_cache filename with
  | Some arr -> arr
  | None ->
    let arr =
      if filename = "" then [||]
      else
        try
          let ic = open_in filename in
          let buf = Buffer.create 4096 in
          (try while true do
              Buffer.add_channel buf ic 1
            done
          with End_of_file -> ());
          close_in ic;
          let content = Buffer.contents buf in
          Array.of_list (String.split_on_char '\n' content)
        with Sys_error _ -> [||]
    in
    Hashtbl.add _file_cache filename arr;
    arr

(* Rendering *)

let use_utf8 = not (Sys.getenv_opt "NO_UTF8" |> Option.is_some)

let c_top_left = if use_utf8 then "╭─▶" else "+->"
let c_pipe     = if use_utf8 then "│"   else "|"
let c_bottom   = if use_utf8 then "╰"   else "\\"
let c_dash     = if use_utf8 then "─"   else "-"
let c_note     = if use_utf8 then "├─▶" else "|->"
let c_bottom_border = if use_utf8 then "╰─────────────────────────────────────────────────" else "\\-------------------------------------------------"

let extract_span_text (span : span) =
  let lines = get_source_lines span.file in
  let li = span.start_line - 1 in
  if li >= 0 && li < Array.length lines && span.start_line = span.end_line then
    let line = lines.(li) in
    let c0 = max 0 (span.start_col - 1) in
    let c1 = min (String.length line) (max c0 (span.end_col - 1)) in
    String.sub line c0 (c1 - c0)
  else ""

let gutter_width_for line_no = String.length (string_of_int (line_no + 1))

(** Render a single diagnostic to stderr. *)
let emit (d : diagnostic) =
  let sc = sev_color d.severity in
  let sl = sev_label d.severity in
  let capitalize s = if s = "" then "" else String.capitalize_ascii s in

  (* Headline *)
  Printf.eprintf "%s%s%s [%s]%s: %s%s%s\n"
    sc bold (capitalize sl) d.code reset
    bold d.message reset;

  (* File / line reference *)
  let sp = d.primary_label.span in
  if sp.file <> "" && sp.start_line > 0 then begin
    Printf.eprintf "%s%s%s %s:%d:%d\n"
      fg_blue c_top_left reset
      sp.file sp.start_line sp.start_col;

    let lines = get_source_lines sp.file in
    let gw = max 2 (gutter_width_for sp.end_line) in

    let print_gutter_line num_str =
      let pad = gw - String.length num_str in
      Printf.eprintf "%s%s%s %s%s %s%s%s "
        fg_blue c_pipe reset (String.make pad ' ') num_str fg_blue c_pipe reset
    in

    Printf.eprintf "%s%s%s\n" fg_blue c_pipe reset;

    (* Context before *)
    if sp.start_line > 1 && (sp.start_line - 2) < Array.length lines then begin
      print_gutter_line (string_of_int (sp.start_line - 1));
      Printf.eprintf "%s%s%s\n" reset lines.(sp.start_line - 2) reset;
    end;

    (* The error line *)
    let line_idx = sp.start_line - 1 in
    if line_idx >= 0 && line_idx < Array.length lines then begin
      let source_line = lines.(line_idx) in
      print_gutter_line (string_of_int sp.start_line);
      Printf.eprintf "%s%s%s\n" reset source_line reset;

      (* pointer *)
      let col0 = max 0 (sp.start_col - 1) in
      let col1 =
        if sp.end_line = sp.start_line && sp.end_col > sp.start_col
        then sp.end_col - 1 else col0 + 1
      in
      let col1 = max col1 (col0 + 1) in
      let spaces = String.make col0 ' ' in
      let dashes_len = max 0 (col1 - col0 - 1) in
      
      (* we can repeat '─' efficiently with String.make, but OCaml strings are bytes, and '─' is multi-byte. *)
      (* So we use a buffer or a simple loop for unicode character repetition *)
      let buf = Buffer.create (dashes_len * 3) in
      for _i = 1 to dashes_len do Buffer.add_string buf c_dash done;
      let dashes = Buffer.contents buf in

      print_gutter_line "";
      Printf.eprintf "%s%s%s%s%s %s%s\n"
        reset spaces sc c_bottom dashes
        (if d.primary_label.message <> "" then d.primary_label.message else "") reset;

      (* Secondary labels *)
      List.iter (fun (sl2 : label) ->
        if sl2.span.file = sp.file &&
           sl2.span.start_line > 0 &&
           sl2.span.start_line < Array.length lines + 1 then begin
          let li2 = sl2.span.start_line - 1 in
          if li2 <> line_idx then begin
            Printf.eprintf "%s%s%s\n" fg_blue c_pipe reset;
            print_gutter_line (string_of_int sl2.span.start_line);
            Printf.eprintf "%s%s%s\n" reset lines.(li2) reset;
          end;
          let c0_2 = max 0 (sl2.span.start_col - 1) in
          let c1_2 = max (c0_2 + 1)
              (if sl2.span.end_line = sl2.span.start_line
               then sl2.span.end_col - 1 else c0_2 + 1) in
          let dashes_len2 = max 0 (c1_2 - c0_2 - 1) in
          
          let buf2 = Buffer.create (dashes_len2 * 3) in
          for _i = 1 to dashes_len2 do Buffer.add_string buf2 c_dash done;
          let dashes2 = Buffer.contents buf2 in

          print_gutter_line "";
          Printf.eprintf "%s%s%s%s%s %s%s\n"
            reset (String.make c0_2 ' ')
            fg_blue c_bottom dashes2
            sl2.message reset;
        end
      ) d.secondary_labels;
    end;

    (* Context after *)
    if sp.end_line < Array.length lines then begin
      print_gutter_line (string_of_int (sp.end_line + 1));
      Printf.eprintf "%s%s%s\n" reset lines.(sp.end_line) reset;
    end;

    Printf.eprintf "%s%s%s\n" fg_blue c_pipe reset;
  end;

  (* Notes *)
  List.iter (fun note ->
    Printf.eprintf "%s%s%s %snote%s: %s\n"
      fg_blue c_note reset bold reset note
  ) d.notes;

  List.iter (fun hint ->
    Printf.eprintf "%s%s%s %shelp%s: %s%s%s\n"
      fg_blue c_note reset fg_green reset fg_green hint reset
  ) d.hints;

  (* Patches *)
  List.iter (fun p ->
    let lines = get_source_lines p.span.file in
    let li = p.span.start_line - 1 in
    if li >= 0 && li < Array.length lines && p.span.start_line = p.span.end_line then begin
      let original_line = lines.(li) in
      let c0 = max 0 (p.span.start_col - 1) in
      let c1 = max c0 (p.span.end_col - 1) in
      let c1 = min c1 (String.length original_line) in
      let prefix = String.sub original_line 0 c0 in
      let suffix = String.sub original_line c1 (String.length original_line - c1) in
      let new_line = prefix ^ p.replacement ^ suffix in
      
      Printf.eprintf "%s%s%s\n" fg_blue c_pipe reset;
      Printf.eprintf "%s%s%s %s-%s %s%s%s\n" fg_blue c_pipe reset fg_red reset fg_red original_line reset;
      Printf.eprintf "%s%s%s %s+%s %s%s%s\n" fg_blue c_pipe reset fg_green reset fg_green new_line reset;
    end
  ) d.patches;

  Printf.eprintf "%s%s%s\n\n" fg_blue c_bottom_border reset

(* Convenience constructors *)

let make_error ?(code="E000") ?(label="") ?(secondary_labels=[]) ?(notes=[]) ?(hints=[]) ?(patches=[]) message span =
  { code;
    severity = Error;
    message;
    primary_label    = { span; message = label };
    secondary_labels;
    notes;
    hints;
    patches }

let make_warning ?(code="W000") ?(label="") ?(secondary_labels=[]) ?(notes=[]) ?(hints=[]) ?(patches=[]) message span =
  { code;
    severity = Warning;
    message;
    primary_label    = { span; message = label };
    secondary_labels;
    notes;
    hints;
    patches }

let raise_error ?(code="E000") ?(label="") ?(secondary_labels=[]) ?(notes=[]) ?(hints=[]) ?(patches=[]) message span =
  raise (LocatedError (make_error ~code ~label ~secondary_labels ~notes ~hints ~patches message span))

(** Fallback: emit a plain string error with no location. *)
let emit_plain_error msg =
  Printf.eprintf "%serror%s%s: %s%s\n\n"
    fg_red reset bold msg reset

(** Construct a [label] record; use this to avoid OCaml record disambiguation
    issues when [Diagnostic] is not opened in the calling module. *)
let make_label span message : label = { span; message }
