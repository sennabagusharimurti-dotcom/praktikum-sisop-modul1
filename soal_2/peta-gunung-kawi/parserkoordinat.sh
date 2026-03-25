#!/bin/bash
echo "Parsing koordinat dari gsxtrack.json"

grep -E '"id"|"site_name"|"latitude"|"longitude"' gsxtrack.json | \
awk -F': ' '
/"id"/ {id=$2; gsub(/[", ]/, "", id)}
/"site_name"/ {site=$2; gsub(/^"|",?$/, "", site)}
/"latitude"/ {lat=$2; gsub(/,/, "", lat)}
/"longitude"/ {lon=$2; gsub(/,/, "", lon); print id","site","lat","lon}
' > titik-penting.txt

echo "=== Hasil titik-penting.txt ==="
cat titik-penting.txt
