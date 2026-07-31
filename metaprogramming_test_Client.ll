; ModuleID = 'wyzer_module'
source_filename = "wyzer_module"

@strtmp = private unnamed_addr constant [9 x i8] c"i32@Poly\00", align 1
@strtmp.1 = private unnamed_addr constant [16 x i8] c"Type of my_var:\00", align 1
@fmt = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@fmt.2 = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1

declare i32 @printf(ptr, ...)

declare void @wyzer_ipc_send(ptr, i32)

declare i32 @wyzer_ipc_recv(ptr)

define void @wyzer_main() {
entry:
  %type_name = alloca ptr, align 8
  %my_var = alloca i32, align 4
  store i32 42, ptr %my_var, align 4
  store ptr @strtmp, ptr %type_name, align 8
  %printf_call = call i32 (ptr, ...) @printf(ptr @fmt, ptr @strtmp.1)
  %type_name1 = load ptr, ptr %type_name, align 8
  %printf_call2 = call i32 (ptr, ...) @printf(ptr @fmt.2, ptr %type_name1)
  ret void
}

define i32 @main() {
entry:
  call void @wyzer_main()
  ret i32 0
}
