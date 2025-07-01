<?php

// Meng-include file koneksi
include 'koneksi.php';

// Mengatur header agar output berupa JSON
header('Content-Type: application/json');

// Membuat array untuk response
$response = array();

// Cek apakah data email dan password dikirim melalui metode POST
if (isset($_POST['email']) && isset($_POST['password'])) {
    
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Query untuk mencari user berdasarkan email (Gunakan prepared statements untuk keamanan)
    $stmt = $koneksi->prepare("SELECT id, password FROM tabel_pengguna WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    // Cek apakah user ditemukan
    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        
        // Verifikasi password yang diinput dengan hash di database
        if (password_verify($password, $user['password'])) {
            // Jika password cocok
            $response['status'] = 'success';
            $response['message'] = 'Login berhasil';
            $response['user_id'] = $user['id']; // <-- TAMBAHKAN BARIS INI
        } else {
            // Jika password tidak cocok
            $response['status'] = 'error';
            $response['message'] = 'Email atau password salah';
        }
    } else {
        // Jika email tidak ditemukan
        $response['status'] = 'error';
        $response['message'] = 'Email atau password salah';
    }
    
    $stmt->close();

} else {
    // Jika data tidak lengkap
    $response['status'] = 'error';
    $response['message'] = 'Data tidak lengkap';
}

// Meng-encode array response menjadi JSON dan menampilkannya
echo json_encode($response);

// Menutup koneksi
$koneksi->close();

?>