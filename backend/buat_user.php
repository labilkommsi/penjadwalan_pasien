<?php

include 'koneksi.php';

// Data user yang ingin kita buat
$nama_lengkap = 'Admin Utama';
$email = 'admin@gmail.com';
$password_asli = '123456'; // Password yang mudah diingat

// Hashing password dengan fungsi bawaan PHP yang aman
$hashed_password = password_hash($password_asli, PASSWORD_DEFAULT);

// Query untuk memasukkan user baru ke database
// Kita gunakan prepared statement untuk keamanan
$stmt = $koneksi->prepare("INSERT INTO tabel_pengguna (nama_lengkap, email, password) VALUES (?, ?, ?)");
$stmt->bind_param("sss", $nama_lengkap, $email, $hashed_password);

// Eksekusi query
if ($stmt->execute()) {
    echo "<h1>Sukses!</h1>";
    echo "User dengan email <strong>" . $email . "</strong> dan password <strong>" . $password_asli . "</strong> berhasil dibuat.";
    echo "<p>Hash yang disimpan di database: " . $hashed_password . "</p>";
} else {
    echo "<h1>Error!</h1>";
    echo "Gagal membuat user: " . $stmt->error;
}

$stmt->close();
$koneksi->close();

?>