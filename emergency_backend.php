<?php
// Emergency backend for Chatsy app
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization, key, token, VERSIONCODE, lang, DEVICETYPE');

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

$request_uri = $_SERVER['REQUEST_URI'];
$method = $_SERVER['REQUEST_METHOD'];

// Simple routing
if (strpos($request_uri, '/user/login') !== false && $method == 'POST') {
    // Mock login response
    echo json_encode([
        'status' => true,
        'message' => 'Login successful',
        'data' => [
            'user' => [
                'id' => 1,
                'name' => 'Test User',
                'email' => 'test@example.com'
            ],
            'token' => 'mock_token_123'
        ]
    ]);
} elseif (strpos($request_uri, '/user/register') !== false && $method == 'POST') {
    // Mock register response
    echo json_encode([
        'status' => true,
        'message' => 'Registration successful',
        'data' => [
            'user' => [
                'id' => 2,
                'name' => 'New User',
                'email' => 'new@example.com'
            ],
            'token' => 'mock_token_456'
        ]
    ]);
} else {
    // Default response
    echo json_encode([
        'status' => true,
        'message' => 'Emergency backend is running',
        'data' => [
            'server' => 'Emergency Backend',
            'status' => 'Online',
            'timestamp' => date('Y-m-d H:i:s')
        ]
    ]);
}
?>

