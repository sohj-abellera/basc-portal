<?php
// Prevent direct access
if (basename($_SERVER['PHP_SELF']) == basename(__FILE__)) {
    exit('Direct access not allowed.');
}

// DB connection settings
$host = 'localhost';
$user = 'root';
$password = '';
$database = 'basc-portal_db';

// Create connection
$conn = new mysqli($host, $user, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
