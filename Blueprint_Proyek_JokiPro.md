# Blueprint Proyek: JokiPro Dashboard

## 1. Visi & Misi
**JokiPro** adalah platform solusi coding premium yang membantu siswa dan mahasiswa dari berbagai jenjang pendidikan — mulai SD hingga Perguruan Tinggi — dalam menyelesaikan tugas pemrograman dengan standar kualitas tinggi, kode bersih, dan waktu pengerjaan yang cepat.

---

## 2. Target Pengguna
- **Siswa SD**: Tugas pengenalan komputer dan logika dasar.
- **Siswa SMP**: Tugas TIK/Informatika tingkat dasar (Scratch, HTML dasar, dll.).
- **Siswa SMK**: Tugas praktik jurusan (Web, Jaringan, Rekayasa Perangkat Lunak).
- **Mahasiswa**: Tugas pemrograman lanjutan, Data Science, Mobile App, Skripsi/TA.
- **Profesional**: Butuh bantuan automasi, bug fixing, atau pembuatan aplikasi.

---

## 3. Arsitektur Aplikasi
Aplikasi dibangun menggunakan **Flutter Web** dengan fokus pada responsivitas dan estetika.

### Teknologi Utama:
| Komponen | Teknologi |
|---|---|
| Framework | Flutter (Stable) |
| State Management | Provider |
| Animasi | Lottie & Flutter Animate |
| Integrasi | Direct WhatsApp API |
| Navigasi | Named Routes / AnimatedSwitcher |

---

## 4. Struktur Folder Proyek

```
joki/                                   ← Root Proyek
├── lib/                                ← Source code Flutter
│   ├── main.dart                       ← Entry point, konfigurasi MaterialApp & tema
│   │
│   ├── controllers/                    ← State Management (Provider)
│   │   └── dashboard_provider.dart     ← Mengelola index halaman, kalkulator, jenjang aktif
│   │
│   ├── models/                         ← Data Model
│   │   ├── service_model.dart          ← Model untuk satu item layanan/tugas
│   │   └── education_level_model.dart  ← [V1.3] Model jenjang pendidikan & daftar tugasnya
│   │
│   ├── pages/                          ← Halaman-halaman aplikasi
│   │   ├── splash_screen.dart          ← Animasi pembuka (Lottie + Flying Documents)
│   │   ├── dashboard_page.dart         ← Layout utama, Sidebar, Header, sub-halaman dashboard
│   │   ├── status_checker_page.dart    ← Halaman Cek Progres (tracking ID tugas)
│   │   └── review_page.dart            ← Halaman Beri Ulasan (form rating + WA)
│   │
│   ├── widgets/                        ← [V1.3] Komponen UI yang dapat digunakan ulang
│   │   ├── role_selector_widget.dart   ← [V1.3] Tombol pilih jenjang (SD/SMP/SMK/Kuliah)
│   │   └── service_card_widget.dart    ← [V1.3] Kartu layanan yang difilter per jenjang
│   │
│   └── utils/                          ← Utilitas & Konstanta Global
│       └── constants.dart              ← Nomor WA, fungsi launchWA(), AppColors
│
├── web/                                ← Konfigurasi Flutter Web
│   └── index.html                      ← HTML entry point
│
├── web-dashboard/                      ← Versi HTML/CSS/JS statis (referensi desain)
│   ├── index.html
│   ├── style.css
│   └── main.js
│
├── pubspec.yaml                        ← Dependensi proyek
├── README.md                           ← Dokumentasi proyek
└── Blueprint_Proyek_JokiPro.md         ← Dokumen blueprint ini
```

### Deskripsi Singkat Per File (Saat Ini):
| File | Fungsi |
|---|---|
| `main.dart` | Konfigurasi tema & set `SplashScreen` sebagai halaman awal |
| `dashboard_provider.dart` | Menyimpan state aktif (tab dipilih, nilai kalkulator) |
| `service_model.dart` | Struktur data untuk satu item layanan (icon, title, description) |
| `splash_screen.dart` | Animasi Lottie + partikel dokumen, auto-redirect setelah 4 detik |
| `dashboard_page.dart` | Berisi `DashboardLayout`, `Sidebar`, `TopHeader`, dan semua halaman konten |
| `status_checker_page.dart` | Form input ID Tugas + tampilan status (mockup) |
| `review_page.dart` | Form rating bintang + komentar + kirim via WhatsApp |
| `constants.dart` | Konstanta warna (`AppColors`), nomor WA, dan fungsi `launchWA()` |

---

## 5. Fitur: Pemilihan Jenjang Pendidikan (Role Selector)

### 5.1 Konsep
Pengguna memilih **jenjang pendidikan (role)** mereka saat pertama kali masuk ke halaman Layanan atau melalui panel khusus. Pemilihan ini akan **memfilter dan menampilkan katalog tugas** yang relevan sesuai tingkatan.

### 5.2 Jenjang yang Tersedia
| Jenjang | Ikon | Warna Aksen |
|---|---|---|
| 🎒 SD | `school` | Kuning Emas |
| 📘 SMP | `menu_book` | Hijau Tosca |
| 🖥️ SMK | `laptop` | Biru |
| 🎓 Kuliah | `school_outlined` | Ungu (Primary) |

### 5.3 Alur Kerja (User Flow)
```
[Masuk ke Halaman Layanan]
       ↓
[Tampil 4 tombol pilihan jenjang: SD | SMP | SMK | Kuliah]
       ↓
[User klik salah satu, misal: SMK]
       ↓
[Katalog layanan berubah menampilkan tugas khusus SMK:
  - Web Development (HTML/CSS/JS/PHP)
  - Basis Data (MySQL)
  - Jaringan Komputer
  - Rekayasa Perangkat Lunak]
       ↓
[User klik "Konsultasi" → diarahkan ke WA dengan pesan kontekstual]
```

### 5.4 Daftar Tugas Per Jenjang

#### 🎒 SD
- Pengenalan Komputer & Internet
- Membuat Presentasi (PowerPoint)
- Logika Dasar & Algoritma Sederhana

#### 📘 SMP
- Tugas TIK (Word, Excel, PowerPoint)
- HTML & CSS Dasar
- Scratch / Coding Visual Dasar

#### 🖥️ SMK
- Web Development (HTML/CSS/JavaScript/PHP)
- Basis Data & MySQL
- Jaringan Komputer
- Rekayasa Perangkat Lunak (RPL)
- Pemrograman Desktop (Java / C++)

#### 🎓 Kuliah
- Algoritma & Struktur Data
- Web Fullstack (React, Laravel, Next.js)
- Mobile App (Flutter, Android Native)
- Data Science & Machine Learning
- Skripsi / Tugas Akhir berbasis IT
- Bug Fixing & Code Review

### 5.5 Desain Komponen
- **Role Selector**: 4 tombol besar bergaya *card chip* dengan ikon dan warna masing-masing.
- **State**: Tombol yang dipilih akan aktif (warna terang + border highlight).
- **Transisi**: Daftar layanan muncul dengan animasi `fadeIn` setiap kali jenjang berganti.
- **Persistent**: Pilihan jenjang disimpan di memori sesi (`Provider`) sehingga tidak hilang saat navigasi antar halaman.

---

## 6. Struktur Navigasi (Sitemap)
1.  **Splash Screen**: Animasi pembuka (Working Person + Flying Documents).
2.  **Dashboard**: Statistik utama (Tugas Selesai, Klien Puas, Rating, FAQ).
3.  **Layanan**: Katalog tugas berdasarkan **jenjang pendidikan yang dipilih**.
4.  **Cek Harga**: Kalkulator interaktif berdasarkan tingkat kesulitan dan deadline.
5.  **Cek Progres**: Tracking status pengerjaan menggunakan ID Tugas.
6.  **Portofolio**: Galeri hasil kerja sebelumnya.
7.  **Beri Ulasan**: Form feedback klien.
8.  **Hubungi Kami**: Akses langsung ke support/admin.

---

## 7. Konsep Visual & UI/UX
- **Tema**: *Deep Ocean Dark Mode* (`#0F172A`).
- **Aksen**: Indigo (`#6366F1`) & Pink (`#EC4899`).
- **Tipografi**: *Outfit* (Modern & Techy).
- **Interaksi**:
    - Role Selector dengan highlight animasi saat dipilih.
    - Hover effects pada semua kartu layanan.
    - Transisi halaman halus menggunakan `AnimatedSwitcher`.
    - Splash screen interaktif yang merepresentasikan proses "input dokumen ke sistem".

---

## 8. Strategi Integrasi WhatsApp
Sistem tidak menggunakan database backend untuk meminimalkan biaya operasional dan menjaga privasi klien. Semua input diteruskan langsung ke WhatsApp Admin dengan format pesan terstruktur dan **menyertakan informasi jenjang yang dipilih**:
> *Contoh: "Halo Admin JokiPro, saya siswa SMK ingin konsultasi mengenai tugas Web Development (PHP & MySQL). Estimasi deadline: 3 hari."*

---

## 9. Roadmap Pengembangan
| Versi | Fitur | Status |
|---|---|---|
| V1.0 | Dashboard dasar, Katalog Layanan, Kalkulator Harga, WhatsApp Integration | ✅ Selesai |
| V1.1 | Animated Splash Screen & Refinement UI | ✅ Selesai |
| V1.2 | Refactoring struktur kode (modular per file) | ✅ Selesai |
| **V1.3** | **Role Selector Jenjang Pendidikan (SD/SMP/SMK/Kuliah)** | 🔜 Planned |
| V1.4 | Sistem Tracking ID Tugas yang dinamis (bukan mockup) | 🔜 Planned |
| V2.0 | Integrasi Payment Gateway (Opsional) | 💡 Ide |
