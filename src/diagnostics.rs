use std::collections::BTreeMap;
use std::env;
use std::fs;
use std::time::{SystemTime, UNIX_EPOCH};

pub struct Issue {
    pub line: usize,
    pub col: usize,
    pub code: String,
    pub msg: String,
}

type Pool = &'static [(&'static str, &'static str)];

const SYNTAX: Pool = &[
    ("The limits of my language mean the limits of my world.", "Ludwig Wittgenstein"),
    ("Ever tried. Ever failed. No matter. Try again. Fail again. Fail better.", "Samuel Beckett"),
    ("Speak only if it improves upon silence.", "Zen Proverb"),
    ("Words are, of course, the most powerful drug used by mankind.", "Rudyard Kipling"),
    ("To understand is to perceive patterns.", "Isaiah Berlin"),
];

const SHARING: Pool = &[
    ("Good fences make good neighbors.", "Robert Frost"),
    ("You cannot step into the same river twice, for other waters are continually flowing in.", "Heraclitus"),
    ("Love consists in this: that two solitudes protect, border, and salute each other.", "Rainer Maria Rilke"),
    ("No man is an island, entire of itself.", "John Donne"),
    ("Freedom is not the absence of commitments, but the ability to choose.", "Paulo Coelho"),
    ("In dividing the cake, two people must be happy: the one who cuts, and the one who chooses.", "Persian Proverb"),
];

const NAMES: Pool = &[
    ("Knowing others is intelligence; knowing yourself is true wisdom.", "Lao Tzu"),
    ("The unexamined life is not worth living.", "Socrates"),
    ("Who looks outside, dreams; who looks inside, awakes.", "Carl Jung"),
    ("Names are powerful things. They tell you what something is and what it is not.", "Ursula K. Le Guin"),
    ("Give things their right names, and half the battle is won.", "Confucius"),
];

const DUPLICATES: Pool = &[
    ("Be yourself; everyone else is already taken.", "Oscar Wilde"),
    ("Comparison is the thief of joy.", "Theodore Roosevelt"),
    ("Imitation is suicide.", "Ralph Waldo Emerson"),
    ("Originality is nothing but judicious imitation.", "Voltaire"),
    ("Two minds with but a single thought, two hearts that beat as one.", "Friedrich Halm"),
];

const DANGLING: Pool = &[
    ("Some of us think holding on makes us strong, but sometimes it is letting go.", "Hermann Hesse"),
    ("You can only lose what you cling to.", "Buddha"),
    ("We suffer more often in imagination than in reality.", "Seneca"),
    ("Attachment is the great fabricator of illusions.", "Simone Weil"),
    ("The root of suffering is attachment.", "Patañjali"),
];

const REDO: Pool = &[
    ("Life can only be understood backwards; but it must be lived forwards.", "Søren Kierkegaard"),
    ("If you find yourself in a hole, stop digging.", "Will Rogers"),
    ("Nothing lasts, nothing is finished, nothing is perfect.", "Richard Powell"),
    ("Insanity is doing the same thing over and over again and expecting different results.", "Rita Mae Brown"),
    ("Time is a created thing. To say 'I don't have time' is like saying 'I don't want to.'", "Mencius"),
];

const CONCURRENCY: Pool = &[
    ("There is more to life than simply increasing its speed.", "Mahatma Gandhi"),
    ("Patience is bitter, but its fruit is sweet.", "Jean-Jacques Rousseau"),
    ("The two most powerful warriors are patience and time.", "Leo Tolstoy"),
    ("Adopt the pace of nature: her secret is patience.", "Henry David Thoreau"),
];

const DEFAULT: Pool = &[
    ("Simplicity is not the absence of power. It is power without pretense.", "Atiksh Sharma"),
    ("The obstacle in the path becomes the path.", "Marcus Aurelius"),
    ("Not all those who wander are lost.", "J.R.R. Tolkien"),
    ("He who has a why to live can bear almost any how.", "Friedrich Nietzsche"),
    ("Out of difficulties grow miracles.", "Jean de La Bruyère"),
];

fn pool(code: &str) -> (Pool, &'static str) {
    match code {
        "syntax" | "lexer" => (SYNTAX, "syntax"),
        "needs-tilde" | "shared-write" | "alias-conflict" => (SHARING, "sharing"),
        "unknown-type" => (NAMES, "names"),
        "duplicate-struct" => (DUPLICATES, "duplicates"),
        "dangling-ref" => (DANGLING, "dangling"),
        "stale-ref" | "infinite-size" => (REDO, "redo"),
        "data-race" => (CONCURRENCY, "concurrency"),
        _ => (DEFAULT, "default"),
    }
}

fn next_quote_index(category: &str, pool_len: usize) -> usize {
    if pool_len <= 1 {
        return 0;
    }

    let state_file = env::temp_dir().join(".wyzer_quote_state");
    let mut map: BTreeMap<String, usize> = BTreeMap::new();

    if let Ok(contents) = fs::read_to_string(&state_file) {
        for line in contents.lines() {
            if let Some((k, v)) = line.split_once('=') {
                if let Ok(idx) = v.trim().parse::<usize>() {
                    map.insert(k.trim().to_string(), idx);
                }
            }
        }
    }

    let next_idx = match map.get(category) {
        Some(&last_idx) => (last_idx + 1) % pool_len,
        None => {
            let nanos = SystemTime::now()
                .duration_since(UNIX_EPOCH)
                .map(|d| d.as_nanos() as usize)
                .unwrap_or(0);
            nanos % pool_len
        }
    };

    map.insert(category.to_string(), next_idx);

    let mut out = String::new();
    for (k, v) in &map {
        out.push_str(&format!("{}={}\n", k, v));
    }
    let _ = fs::write(&state_file, out);

    next_idx
}

pub fn print(path: &str, issues: &[Issue]) {
    if issues.is_empty() {
        return;
    }
    if env::var_os("NO_QUOTES").is_none() {
        let (p, category) = pool(&issues[0].code);
        let idx = next_quote_index(category, p.len());
        let (text, author) = p[idx];
        eprintln!("\"{}\"", text);
        eprintln!("~ {}", author);
        eprintln!();
    }
    for i in issues {
        eprintln!("{}:{}:{}: error[{}]: {}", path, i.line, i.col, i.code, i.msg);
    }
}
