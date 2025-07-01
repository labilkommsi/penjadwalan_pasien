<?php

// Konfigurasi koneksi database
$db_host = 'localhost'; // Host database
$db_user = 'root';      // User database (default XAMPP)
$db_pass = '';          // Password database (default XAMPP kosong)
$db_name = 'db_pasien_cerdas'; // Nama database

// Membuat koneksi
$koneksi = mysqli_connect($db_host, $db_user, $db_pass, $db_name);

// Cek koneksi
if (!$koneksi) {
    die("Koneksi ke database gagal: " . mysqli_connect_error());
}

?>