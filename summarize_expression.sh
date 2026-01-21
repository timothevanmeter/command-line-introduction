#!/usr/bin/env bash

# summarize_expression.sh

# ---- No arguments ----
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 file1.tsv [file2.tsv ...]" >&2
    exit 1
fi

files=()
for f in "$@"; do
    if [ -r "$f" ]; then
        files+=("$f")
    else
        echo "Warning: cannot read file '$f'" >&2
    fi
done

[ "${#files[@]}" -eq 0 ] && exit 2

# ---- Process data ----
result=$(
awk -F '\t' '
FNR == 1 { next }                 # skip header
NF != 2 { next }                  # malformed
$1 == "" { next }
$2 !~ /^[0-9]+(\.[0-9]+)?$/ { next }

{
    sum[$1] += $2
    cnt[$1]++
    total++
}
END {
    if (total == 0) exit 2
    for (g in cnt) {
        printf "%s\t%.2f\n", g, sum[g] / cnt[g]
    }
}
' "${files[@]}"
)

status=$?
[ "$status" -eq 2 ] && exit 2

genes=$(printf "%s\n" "$result" | wc -l | tr -d ' ')
measurements=$(awk -F '\t' '
FNR==1{next}
NF==2 && $1!="" && $2~/^[0-9]+(\.[0-9]+)?$/ {c++}
END{print c}
' "${files[@]}")

echo "Total genes observed: $genes"
echo "Total measurements: $measurements"
echo
echo "Average expression per gene:"
printf "%s\n" "$result" | sort

exit 0
