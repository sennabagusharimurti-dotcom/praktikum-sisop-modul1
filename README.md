# PRAKTIKUM MODUL 1 SISTEM OPERASI

## SOAL_1

### Pejelasan 
### passenger.csv

Untuk langkah awal saya menginstal data yang dibutuhkan dengan menggunakan command

### kode
``` wget -O passenger.csv "https://docs.google.com/spreadsheets/d/1NHmyS6wRO7To7ta-NLOOLHkPS6valvNaX7tawsv1zfE/export?format=csv" ```

### KANJ.sh
File utama yang digunakan adalah `KANJ.sh` yang berisi script AWK untuk mengolah data `passenger.csv`

### KODE
```
BEGIN {
    FS = ","
    sub_soal = ARGV[2]
    delete ARGV[2]
}

NR > 1 {
    if (sub_soal == "a") nama[$1]++
    if (sub_soal == "b") gerbong[$4]++
    if (sub_soal == "c") { if ($2 > max_age) { max_age = $2; oldest = $1 } }
    if (sub_soal == "d") { total += $2; count++ }
    if (sub_soal == "e") { if ($3 == "Business") count++ }
}

END {
    if (sub_soal == "a") print "Jumlah seluruh penumpang KANJ adalah " length(nama) " orang"
    if (sub_soal == "b") print "Jumlah gerbong KANJ adalah " length(gerbong) " gerbong"
    if (sub_soal == "c") print oldest " adalah penumpang kereta tertua dengan usia " max_age " tahun"
    if (sub_soal == "d") printf "Rata-rata usia penumpang adalah %d tahun\n", int(total/count + 0.5)
    if (sub_soal == "e") print "Jumlah penumpang business class ada " count " orang"
}
```

### PENJELASAN SCRIPT

Script AWK digunakan untuk mengeksekusi sub-soal(`a` hingga `e`) unutk menjawab pertanyaan yang berbeda dari data `passenger.csv`.

| Sub-soal | Fungsi |
|----------|--------|
| `a` | Menghitung jumlah seluruh penumpang unik (berdasarkan nama) |
| `b` | Menghitung jumlah gerbong yang berbeda |
| `c` | Mencari penumpang tertua beserta usianya |
| `d` | Menghitung rata-rata usia seluruh penumpang |
| `e` | Menghitung jumlah penumpang kelas Business |

### Cara Menjalankan

```
# Sub-soal a: Jumlah penumpang
awk -f KANJ.sh passenger.csv a
 
# Sub-soal b: Jumlah gerbong
awk -f KANJ.sh passenger.csv b
 
# Sub-soal c: Penumpang tertua
awk -f KANJ.sh passenger.csv c
 
# Sub-soal d: Rata-rata usia
awk -f KANJ.sh passenger.csv d
 
# Sub-soal e: Penumpang Business class
awk -f KANJ.sh passenger.csv e
```

### Output

```
a) Jumlah seluruh penumpang KANJ adalah X orang
b) Jumlah gerbong KANJ adalah X gerbong
c) [Nama] adalah penumpang kereta tertua dengan usia X tahun
d) Rata-rata usia penumpang adalah X tahun
e) Jumlah penumpang business class ada X orang
```

## SOAL_2

### Penjelasan

### peta-ekspedisi-amba.pdf
untuk langkah awal menginstal `gdown` dan mendownload file PDF dari link yang ada pada soal dengan menggunakan command
```
pip install gdown
gdown "https://drive.google.com/uc?id=1q10pHSC3KFfvEiCN3V6PTroPR7YGHF6Q"
```
Setelah PDF diinstall, dilakukan concatenate pada file PDF untuk menemukan link repository Git yang tersembunyi di dalamnya
```
strings peta-ekspedisi-amba.pdf | grep -i "http\|github\|git"
```
Dari command di atas mendapatkan hasil link repository
```
https://github.com/pocongcyber77/peta-gunung-kawi
```
Kemudian melakukan clone untuk menginstall repository
```
git clone https://github.com/pocongcyber77/peta-gunung-kawi
```
### gsxtrack.json
`gsxtrack.json` ini berisi data koordinat titik-titik ekspedisi Mas Amba di sekitar Gunung Kawi. Terdapat 4 titik koordinat yang membentuk pola persegi.
```
{
"type": "FeatureCollection",
"name": "gunung_kawi_spatial_nodes",
"dataset_info": {
"crs": "EPSG:4326",
"datum": "WGS84",
"region": "Gunung Kawi, East Java, Indonesia",
"edge_distance_m": 2000,
"generated_at": "2026-03-13T10:02:00Z"
},
"features": [
{
"type": "Feature",
"id": "node_001",
"properties": {
"site_name": "Titik Berak Paman Mas Mba",
"node_class": "primary_reference_point",
"latitude": -7.920000,
"longitude": 112.450000,
"elevation_m": 254,
"status": "active"
},
"geometry": {
"type": "Point",
"coordinates": [112.450000, -7.920000]
}
},
{
"type": "Feature",
"id": "node_002",
"properties": {
"site_name": "Basecamp Mas Fuad",
"node_class": "field_operations_base",
"latitude": -7.920000,
"longitude": 112.468100,
"elevation_m": 261,
"status": "active"
},
"geometry": {
"type": "Point",
"coordinates": [112.468100, -7.920000]
}
},
{
"type": "Feature",
"id": "node_003",
"properties": {
"site_name": "Gerbang Dimensi Keputih",
"node_class": "anomaly_site",
"latitude": -7.937960,
"longitude": 112.468100,
"elevation_m": 248,
"status": "restricted"
},
"geometry": {
"type": "Point",
"coordinates": [112.468100, -7.937960]
}
},
{
"type": "Feature",
"id": "node_004",
"properties": {
"site_name": "Tembok Ratapan Keputih",
"node_class": "boundary_marker",
"latitude": -7.937960,
"longitude": 112.450000,
"elevation_m": 246,
"status": "inactive"
},
"geometry": {
"type": "Point",
"coordinates": [112.450000, -7.937960]
}
}
]
}
```

#### parserkoordinat.sh
Script shell yang menggunakan `grep`, `sed`, dan `awk` untuk mengekstrak data `id`, `site_name`, `latitude`, dan `longitude` dari `gsxtrack.json`, lalu menyimpan hasilnya ke `titik-penting.txt`.
** KODE **
```
#!/bin/bash
echo "Parsing koordinat dari gsxtrack.json..."
 
grep -E '"id"|"site_name"|"latitude"|"longitude"' gsxtrack.json | \
awk -F': ' '
/"id"/ {id=$2; gsub(/[", ]/, "", id)}
/"site_name"/ {site=$2; gsub(/^"|",?$/, "", site)}
/"latitude"/ {lat=$2; gsub(/,/, "", lat)}
/"longitude"/ {lon=$2; gsub(/,/, "", lon); print id","site","lat","lon}
' > titik-penting.txt
 
echo "=== Hasil titik-penting.txt ==="
cat titik-penting.txt
```

#### nemupusaka.sh
Script shell yang menghitung titik tengah diagonal dari keempat titik di `titik-penting.txt` menggunakan metode titik simetri diagonal, lalu menyimpan hasilnya ke `posisipusaka.txt`.
 
**Kode**
```bash
#!/bin/bash
echo "Menghitung titik tengah diagonal..."
 
lat1=$(awk -F',' 'NR==1{print $3}' titik-penting.txt)
lon1=$(awk -F',' 'NR==1{print $4}' titik-penting.txt)
lat2=$(awk -F',' 'NR==3{print $3}' titik-penting.txt)
lon2=$(awk -F',' 'NR==3{print $4}' titik-penting.txt)
 
lat_tengah=$(echo "scale=6; ($lat1 + $lat2) / 2" | bc)
lon_tengah=$(echo "scale=6; ($lon1 + $lon2) / 2" | bc)
 
echo "$lat_tengah,$lon_tengah" > posisipusaka.txt
 
echo "FYI: hasil koordinat pusatnya bisa anda cek via maps sebagai berikut:"
cat posisipusaka.txt
```

### Cara Menjalankan
 
```bash
# Jalankan parser koordinat
chmod +x parserkoordinat.sh
./parserkoordinat.sh
 
# Jalankan pencari lokasi pusaka
chmod +x nemupusaka.sh
./nemupusaka.sh
```
 
### Output
 
```
# parserkoordinat.sh
Parsing koordinat dari gsxtrack.json...
=== Hasil titik-penting.txt ===
node_001,Titik Berak Paman Mas Mba,-7.920000,112.450000
node_002,Basecamp Mas Fuad,-7.920000,112.468100
node_003,Gerbang Dimensi Keputih,-7.937960,112.468100
node_004,Tembok Ratapan Keputih,-7.937960,112.450000
 
# nemupusaka.sh
Menghitung titik tengah diagonal...
FYI: hasil koordinat pusatnya bisa anda cek via maps sebagai berikut:
-7.928980,112.459050
```




