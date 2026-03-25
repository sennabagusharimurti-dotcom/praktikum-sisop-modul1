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
