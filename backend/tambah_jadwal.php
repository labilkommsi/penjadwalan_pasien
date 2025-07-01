<?php
include 'koneksi.php';
header('Content-Type: application/json');

$response = array();

// Menerima data dari body request (metode POST)
if (isset($_POST['id_pengguna']) && isset($_POST['nama_kegiatan']) && isset($_POST['waktu_jadwal'])) {
    
    $id_pengguna = $_POST['id_pengguna'];
    $nama_kegiatan = $_POST['nama_kegiatan'];
    $waktu_jadwal = $_POST['waktu_jadwal'];

    // Validasi sederhana
    if (empty($id_pengguna) || empty($nama_kegiatan) || empty($waktu_jadwal)) {
        $response['status'] = 'error';
        $response['message'] = 'Semua data harus diisi';
    } else {
        // Query INSERT menggunakan prepared statement untuk keamanan
        $stmt = $koneksi->prepare("INSERT INTO tabel_jadwal (id_pengguna, nama_kegiatan, waktu_jadwal) VALUES (?, ?, ?)");
        $stmt->bind_param("iss", $id_pengguna, $nama_kegiatan, $waktu_jadwal);

        if ($stmt->execute()) {
            $response['status'] = 'success';
            $response['message'] = 'Jadwal berhasil ditambahkan';
        } else {
            $response['status'] = 'error';
            $response['message'] = 'Gagal menambahkan jadwal: ' . $stmt->error;
        }
        $stmt->close();
    }
} else {
    $response['status'] = 'error';
    $response['message'] = 'Data yang diperlukan tidak ada';
}

echo json_encode($response);
$koneksi->close();
?>