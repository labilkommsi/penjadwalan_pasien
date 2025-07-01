<?php
include 'koneksi.php';
header('Content-Type: application/json');

$response = array();

// Menerima id_pengguna dari parameter URL (metode GET)
if (isset($_GET['id_pengguna'])) {
    $id_pengguna = $_GET['id_pengguna'];

    // Query SELECT menggunakan prepared statement
    $stmt = $koneksi->prepare("SELECT id_jadwal, nama_kegiatan, TIME_FORMAT(waktu_jadwal, '%H:%i') AS waktu_jadwal, status FROM tabel_jadwal WHERE id_pengguna = ? ORDER BY waktu_jadwal ASC");
    $stmt->bind_param("i", $id_pengguna);
    $stmt->execute();
    $result = $stmt->get_result();

    $jadwal = array();
    while ($row = $result->fetch_assoc()) {
        $jadwal[] = $row;
    }

    $response['status'] = 'success';
    $response['data'] = $jadwal;
    
    $stmt->close();

} else {
    $response['status'] = 'error';
    $response['message'] = 'ID Pengguna diperlukan';
}

echo json_encode($response);
$koneksi->close();
?>