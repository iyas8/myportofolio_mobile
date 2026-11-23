# MyPortofolio Mobile

## Deskripsi Proyek

Proyek ini adalah aplikasi portofolio pribadi sederhana yang dibuat menggunakan Flutter. Aplikasi menampilkan informasi NPM, nama, dan kelas pemilik portofolio. Halaman utama juga menyediakan kartu aksi untuk bagian Education dan formulir Education serta Experience. Kedua formulir memvalidasi isian dan menampilkan ringkasan data melalui dialog. Data dari formulir belum disimpan ke database atau API

## Cara Menjalankan Proyek (Setup)

1. Pastikan Flutter SDK dan IDE sudah terinstal di komputer.
2. Clone repository ini, lalu masuk ke folder proyek dengan perintah: `git clone https://github.com/iyas8/myportofolio_mobile.git` dan `cd myportofolio_mobile`.
3. Instal semua dependensi dengan menjalankan: `flutter pub get`.
4. Periksa kode dengan menjalankan: `flutter analyze`.
5. Jalankan aplikasi dengan perintah: `flutter run`. Pilih perangkat atau emulator yang tersedia.

---

### Tugas 8

1. `Navigator.push()` menambahkan halaman baru ke dalam stack dan digunakan saat kartu Tambah Experience ditekan, sehingga pengguna dapat kembali dengan tombol Back. `Navigator.pushReplacement()` mengganti halaman yang sedang dibuka, misalnya saat berpindah dari formulir Experience ke Education melalui drawer. Sementara itu, `Navigator.pop()` menutup drawer atau halaman aktif. Pada halaman formulir, opsi Home menutup drawer lalu kembali ke halaman utama

2. `Scaffold` menjadi kerangka halaman, `AppBar` menampilkan judul, dan `Drawer` menyediakan navigasi yang sama pada halaman Home, Education, dan Experience. Warna utama diambil dari `Theme.of(context).colorScheme.primary`, sehingga AppBar dan header drawer menggunakan warna tema yang konsisten

3. Formulir menggunakan `Column` agar input tersusun dari atas ke bawah. `Padding` memberi jarak antarfield, sedangkan `SingleChildScrollView` membuat seluruh input dan tombol Simpan tetap dapat dijangkau saat layar sempit atau keyboard tampil

4. `GlobalKey<FormState>` digunakan untuk mengakses state dari Form. Setiap `validator` memeriksa input, lalu `validate()` menjalankan seluruh validasi saat tombol Simpan ditekan. Contohnya, judul yang kosong atau hanya berisi spasi akan ditolak. Memilih jenis keyboard saja tidak cukup karena keyboard hanya membantu cara memasukkan teks, bukan memastikan isian wajib sudah benar

### AI Disclosure

Tool yang digunakan: ChatGPT

Konteks Penggunaan: Saya menggunakan ChatGPT untuk membantu menyusun rancangan awal halaman Experience Form, navigasi, validasi dan widget test

---

### Tugas 7

1. Widget tree adalah susunan widget yang membentuk tampilan aplikasi Flutter. Widget dapat memiliki widget lain sebagai child. Widget yang berada di luar disebut parent, sedangkan widget di dalamnya disebut child. Contohnya, `MaterialApp` menjadi pembungkus utama `MyHomePage`, kemudian `Scaffold` menyusun bagian halaman seperti `AppBar` dan `body`. Di dalam `body`, terdapat widget lain untuk menampilkan kartu informasi dan kartu aksi

2. Widget yang digunakan dalam proyek ini terdiri dari widget bawaan Flutter dan widget yang dibuat sendiri. `MaterialApp` mengatur dasar aplikasi, `Scaffold` menjadi kerangka halaman, dan `AppBar` menampilkan bagian atas halaman. `Padding` mengatur jarak, `Column` dan `Row` menyusun widget secara vertikal dan horizontal, sedangkan `Center` menempatkan widget di tengah. `Card` dan `Container` digunakan untuk membuat kartu, `Text` menampilkan tulisan, dan `SizedBox` memberi jarak. `GridView` menyusun kartu aksi dalam bentuk grid. `Material` mengatur tampilan kartu aksi, `InkWell` mendeteksi sentuhan, `Icon` menampilkan ikon, dan `SnackBar` menampilkan notifikasi. Selain itu, `MyHomePage`, `InfoCard`, dan `ItemCard` merupakan widget yang dibuat sendiri untuk menyusun halaman, kartu informasi, dan kartu aksi

3. `MaterialApp` digunakan untuk mengatur dasar aplikasi, seperti judul, tema, warna dan halaman utama. Widget ini biasanya menjadi root widget karena menjadi pembungkus utama bagi halaman aplikasi, sehingga pengaturan tersebut dapat digunakan oleh widget di bawahnya

4. `StatelessWidget` digunakan ketika widget tidak perlu menyimpan data yang berubah selama interaksi. Sementara itu, `StatefulWidget` digunakan ketika tampilan perlu berubah mengikuti perubahan data atau keadaan. Pada proyek ini, `MyHomePage`, `InfoCard` dan `ItemCard` menggunakan `StatelessWidget` karena tampilannya tidak membutuhkan perubahan state internal. Jika nantinya aplikasi memiliki fitur seperti penghitung atau form yang memperbarui tampilan, `StatefulWidget` dapat digunakan

5. `BuildContext` adalah informasi mengenai posisi sebuah widget di dalam widget tree. Context digunakan untuk mengakses informasi dari widget lain yang berada di atasnya. Contohnya, `Theme.of(context)` digunakan untuk mengambil warna tema, `MediaQuery.of(context)` untuk mengetahui ukuran layar dan `ScaffoldMessenger.of(context)` untuk menampilkan SnackBar

6. Hot reload digunakan untuk menerapkan perubahan kode dengan cepat tanpa menjalankan ulang seluruh aplikasi, serta mempertahankan state yang sedang berjalan. Hot restart menjalankan ulang aplikasi dari awal sehingga state kembali seperti semula. Full restart diperlukan ketika perubahan tidak dapat diterapkan melalui hot reload atau hot restart, misalnya perubahan pada konfigurasi native atau plugin aplikasi

### AI Disclosure

Tool yang digunakan: ChatGPT

Konteks Penggunaan: Saya menggunakan ChatGPT untuk membantu memahami dan menyesuaikan implementasi widget pada `menu.dart`, serta memahami konsep widget tree, `StatelessWidget`, `StatefulWidget` dan `BuildContext`