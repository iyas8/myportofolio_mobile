# MyPortofolio Mobile

## Deskripsi Proyek

Proyek ini adalah aplikasi portofolio pribadi sederhana yang dibuat menggunakan Flutter. Aplikasi menampilkan informasi NPM, nama, dan kelas pemilik portofolio dalam tiga kartu informasi. Terdapat juga tiga kartu aksi, yaitu Lihat Education, Tambah Item, dan Logout. Setiap kartu aksi memiliki warna berbeda dan menampilkan SnackBar ketika ditekan

## Cara Menjalankan Proyek (Setup)

1. Pastikan Flutter SDK dan IDE sudah terinstal di komputer.
2. Clone repository ini, lalu masuk ke folder proyek dengan perintah: `git clone https://github.com/iyas8/myportofolio_mobile.git` dan `cd myportofolio_mobile`.
3. Instal semua dependensi dengan menjalankan: `flutter pub get`.
4. Periksa kode dengan menjalankan: `flutter analyze`.
5. Jalankan aplikasi dengan perintah: `flutter run`. Pilih perangkat atau emulator yang tersedia.

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