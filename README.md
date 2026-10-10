# SafeReturn

## 1. Target User
Bagian ini menjawab "siapa yang memakai aplikasi ini". Sebutkan peran dan kebutuhan masing-masing:
- **Mahasiswa (User):** melaporkan barang temuan atau hilang, mencari barang di katalog, mengajukan klaim, dan mengambil barang dengan tiket QR.
- **Satpam (Guard):** menerima barang dari penemu, memotret dan menentukan rak, meninjau klaim, memverifikasi KTM, dan menyerahkan barang.
- **Supervisor:** melihat audit log secara read-only.
- **Guest:** hanya bisa melaporkan barang temuan tanpa masuk SSO.

## 2. Problem
Jelaskan masalah nyata di kampus dalam 3–4 kalimat, misalnya:
- Barang hilang dan temuan tidak tercatat terpusat, sehingga pemilik sulit melacaknya.
- Pengembalian tanpa verifikasi berisiko jatuh ke orang yang salah.
- Tidak ada jejak bukti serah terima yang bisa diaudit.

Lalu sebutkan prinsip solusinya: klaim diverifikasi lewat pertanyaan kepemilikan, detail pengenal tidak dibagikan ke pengklaim, dan keputusan akhir ada di satpam.

## 3. Workflow
Cara paling mudah adalah membuat daftar bernomor per peran, lalu menambahkan diagram alur jika sempat:
1. **Penemu:** Report Found Item → foto → QR kasus → serahkan ke pos.
2. **Satpam:** scan QR kasus → konfirmasi barang → foto ulang dan tentukan rak → status *Stored*.
3. **Pemilik:** lihat Found Items → Submit a Claim → jawab verifikasi kepemilikan.
4. **Satpam:** tinjau klaim (opsional lihat AI Match) → Approve atau Reject.
5. **Pemilik:** Collection Ticket (QR berlaku 24 jam) → ambil di pos dengan KTM.
6. **Satpam:** scan tiket → verifikasi KTM → foto bukti → handover selesai.
7. **Supervisor:** semua tahap tercatat di Chain of Custody Log.

## 4. Data Sources
Jujur saja soal asal data:
- Semua data (barang, nama, kode kasus seperti `SR-20261009-1024`, log) adalah **data dummy statis** di dalam `safe_return_runner.html`.
- Tidak ada database, API, atau penyimpanan permanen. Refresh halaman akan mengembalikan semuanya ke awal.
- Desain berasal dari file SVG Figma (Home, Lost Report, Submit a Claim, Collection Ticket, Security Profile).
- Kalau ke depan dipakai nyata, sebutkan sumber yang direncanakan, misalnya SSO kampus untuk identitas dan database kasus.

## 5. Architecture
Untuk kondisi sekarang cukup deskripsikan:
- **Single-file web app:** HTML + CSS + JavaScript vanilla, tanpa framework dan tanpa build step.
- **Navigasi:** semua layar adalah `<div class="screen">`, dan fungsi `showScreen(id)` mengatur layar mana yang aktif.
- **Role switching:** toolbar atas (Guest/User/Guard/Supervisor) memanggil `switchRole()` untuk berpindah alur.
- **Komponen:** bottom sheet (penolakan dan filter), stepper, dan QR berupa SVG inline.
- **Font:** Plus Jakarta Sans dari Google Fonts.

Tambahkan juga satu paragraf "arsitektur target" jika tim berencana membuat backend (API, database, SSO, penyimpanan foto), dan tandai jelas bahwa itu rencana.

## 6. Setup Instructions
Karena tanpa dependensi, cukup:
1. Unduh atau clone repositori.
2. Buka `safe_return_runner.html` di browser modern (Chrome, Edge, Firefox).
3. Gunakan toolbar atas untuk berganti peran.

Tulis juga bahwa koneksi internet hanya dibutuhkan untuk memuat font. Tanpa internet aplikasi tetap jalan dengan font cadangan.

## 7. Test Cases and Results
Gunakan tabel: **ID, skenario, langkah, hasil yang diharapkan, hasil aktual, status.** Contoh dari yang sudah saya uji dengan Playwright:

| ID | Skenario | Hasil |
|---|---|---|
| TC-01 | Home → Report a Lost Item → Continue to Submit → Submit Report | Pass, kembali ke Home |
| TC-02 | Found Items → Item Details → Submit a Claim → Submit Claim | Pass, membuka Collection Ticket |
| TC-03 | Guard → tab Account → Sign Out | Pass, kembali ke Sign In dan role Guest aktif |
| TC-04 | Tiga layar baru dirender dibandingkan desain SVG | Pass secara visual, tanpa error JS |

Skenario lain (guard approve/reject klaim, handover, supervisor log) belum saya uji secara otomatis. Jalankan sendiri lalu isi hasilnya, dan jangan menulis "Pass" kalau belum dicoba.

## 8. Token Usage
Bagian ini hanya relevan jika kamu memakai AI saat mengembangkan atau di dalam aplikasi. Karena aplikasi tidak memanggil model AI, tulis saja: *"Runtime: 0 token (tidak ada pemanggilan LLM)."* Untuk proses pengembangan, catat sendiri dari akun atau dasbor yang kamu pakai, dengan format seperti ini:

| Tahap | Alat/Model | Perkiraan token | Catatan |
|---|---|---|---|
| Konversi desain ke HTML | (isi) | (isi) | (isi) |

Jangan mengarang angkanya.

## 9. Limitations
Tulis apa adanya, ini justru menambah kredibilitas:
- Data statis dan tidak tersimpan, tanpa backend, autentikasi, atau SSO sungguhan.
- "AI Match" adalah mockup skor, bukan model nyata, dan di layarnya sendiri sudah dilabeli bukan probabilitas kepemilikan.
- QR code statis dan belum bisa dipindai fungsional.
- Unggah dan pengambilan foto hanya tampilan.
- Persetujuan klaim disimulasikan: tombol Submit Claim langsung membuka tiket.
- Kode kasus tidak seragam (`SR-20261008-…` di layar baru, `SR-20261009-…` di layar lain).
- Desain ukuran tetap 402×874 (iPhone 17), belum responsif.

## 10. Team Responsibilities
Isi dengan nama dan peran nyata anggota tim, misalnya:

| Nama | Peran | Tanggung jawab |
|---|---|---|
| (isi) | UI/UX | Desain Figma semua layar |
| (isi) | Front-end | Implementasi HTML/CSS/JS, navigasi |
| (isi) | QA | Test case dan pelaporan hasil |
| (isi) | Dokumentasi | README dan demo |

Kalau mau, saya bisa langsung menyusun semuanya jadi file `README.md` yang rapi. Tinggal kirim nama anggota tim, angka token, dan hasil uji yang sudah kamu jalankan, nanti saya masukkan.