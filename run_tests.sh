cargo build -q || exit 1
BIN=./target/debug/wyzer
pass=0
fail=0
for f in $(find wyz_tests -name '*.wyz' | sort -V); do
    if $BIN "$f" > /dev/null 2>&1; then
        pass=$((pass + 1))
    else
        fail=$((fail + 1))
        echo "FAIL  $f"
    fi
done
echo "$pass parsed, $fail failed"
[ "$fail" -eq 0 ]
