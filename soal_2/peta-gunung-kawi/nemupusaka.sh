#!/bin/bash
echo "Menghitung titik tengah diagonal..."

lat1=$(awk -F',' 'NR==1{print $3}' titik-penting.txt)
lon1=$(awk -F',' 'NR==1{print $4}' titik-penting.txt)
lat2=$(awk -F',' 'NR==3{print $3}' titik-penting.txt)
lon2=$(awk -F',' 'NR==3{print $4}' titik-penting.txt)

lat_tengah=$(echo "scale=6; ($lat1 + $lat2) / 2" | bc)
lon_tengah=$(echo "scale=6; ($lon1 + $lon2) / 2" | bc)

echo "$lat_tengah,$lon_tengah" > posisipusaka.txt
echo "FYI: hasil koordinat pusatnya bisa anda cek via maps:"
cat posisipusaka.txt
