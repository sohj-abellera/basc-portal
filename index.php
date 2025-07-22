<?php
// ✅ Start session
session_start();

// ✅ Include DB connection
require_once 'db/db_connection.php';

// ✅ Check if user is already logged in
if (isset($_SESSION['user_id'])) {
    // ✅ User is logged in — redirect to dashboard
    header("Location: dashboard.php");
    exit;
}

// ✅ Not logged in — send to login page
header("Location: login-interface/login.php");
exit;
?>
