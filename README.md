# PRAKTIKUM MODUL 1 SISTRM OPERASI

## SOAL1

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




