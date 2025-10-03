<?php
/**
 * 🗄️ CHATSY USER DATABASE ADMIN DASHBOARD
 * 
 * This dashboard gives you full access to your user database
 * without needing your developers!
 * 
 * Instructions:
 * 1. Upload this file to your website root (aichatsy.com/admin_dashboard.php)
 * 2. Update database credentials below
 * 3. Access via https://aichatsy.com/admin_dashboard.php
 */

// 🔐 SECURITY: Change this password!
$admin_password = 'chatsy_admin_2024'; // CHANGE THIS PASSWORD!

// 🗄️ DATABASE CONFIGURATION
// Update these with your actual database credentials from cPanel
$host = 'localhost';           // Usually localhost
$database = 'aichatsy_5';      // Your database name (check cPanel)
$username = 'aichatsy_user';   // Your database username (check cPanel)
$password = 'your_password';   // Your database password (check cPanel)

// Start session for authentication
session_start();

// Handle login
if (isset($_POST['login'])) {
    if ($_POST['password'] === $admin_password) {
        $_SESSION['admin_logged_in'] = true;
        $_SESSION['login_time'] = time();
    } else {
        $login_error = "Incorrect password!";
    }
}

// Handle logout
if (isset($_GET['logout'])) {
    session_destroy();
    header('Location: admin_dashboard.php');
    exit;
}

// Check if logged in
$is_logged_in = isset($_SESSION['admin_logged_in']) && $_SESSION['admin_logged_in'];
$session_timeout = 3600; // 1 hour
if ($is_logged_in && (time() - $_SESSION['login_time']) > $session_timeout) {
    session_destroy();
    $is_logged_in = false;
}

// If not logged in, show login form
if (!$is_logged_in) {
    ?>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chatsy Admin Login</title>
        <style>
            body { font-family: Arial, sans-serif; background: #f5f5f5; margin: 0; padding: 20px; }
            .login-container { max-width: 400px; margin: 100px auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            .login-container h1 { text-align: center; color: #333; margin-bottom: 30px; }
            .form-group { margin-bottom: 20px; }
            .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
            .form-group input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
            .btn { width: 100%; padding: 12px; background: #007cba; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
            .btn:hover { background: #005a87; }
            .error { color: red; text-align: center; margin-top: 10px; }
            .info { background: #e7f3ff; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        </style>
    </head>
    <body>
        <div class="login-container">
            <h1>🔐 Chatsy Admin Login</h1>
            <div class="info">
                <strong>Note:</strong> This is your user database admin panel. 
                Make sure to change the default password in the code!
            </div>
            <?php if (isset($login_error)): ?>
                <div class="error"><?php echo $login_error; ?></div>
            <?php endif; ?>
            <form method="POST">
                <div class="form-group">
                    <label for="password">Admin Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" name="login" class="btn">Login</button>
            </form>
        </div>
    </body>
    </html>
    <?php
    exit;
}

// Database connection
try {
    $pdo = new PDO("mysql:host=$host;dbname=$database", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("❌ Database connection failed: " . $e->getMessage() . "<br><br>Please check your database credentials in the code.");
}

// Get statistics
$stats = [];
try {
    $stmt = $pdo->query("SELECT COUNT(*) as total_users FROM users");
    $stats['total_users'] = $stmt->fetch()['total_users'];
    
    $stmt = $pdo->query("SELECT COUNT(*) as google_users FROM users WHERE is_google = 1");
    $stats['google_users'] = $stmt->fetch()['google_users'];
    
    $stmt = $pdo->query("SELECT COUNT(*) as apple_users FROM users WHERE is_apple = 1");
    $stats['apple_users'] = $stmt->fetch()['apple_users'];
    
    $stmt = $pdo->query("SELECT COUNT(*) as email_users FROM users WHERE is_google = 0 AND is_apple = 0");
    $stats['email_users'] = $stmt->fetch()['email_users'];
    
    $stmt = $pdo->query("SELECT COUNT(*) as today_users FROM users WHERE DATE(created_at) = CURDATE()");
    $stats['today_users'] = $stmt->fetch()['today_users'];
    
    $stmt = $pdo->query("SELECT COUNT(*) as this_month FROM users WHERE MONTH(created_at) = MONTH(CURDATE()) AND YEAR(created_at) = YEAR(CURDATE())");
    $stats['this_month'] = $stmt->fetch()['this_month'];
    
} catch(PDOException $e) {
    $stats['error'] = "Error getting statistics: " . $e->getMessage();
}

// Get users (with pagination)
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$limit = 50;
$offset = ($page - 1) * $limit;

try {
    $stmt = $pdo->prepare("SELECT * FROM users ORDER BY created_at DESC LIMIT $limit OFFSET $offset");
    $stmt->execute();
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Get total count for pagination
    $stmt = $pdo->query("SELECT COUNT(*) as total FROM users");
    $total_users = $stmt->fetch()['total'];
    $total_pages = ceil($total_users / $limit);
    
} catch(PDOException $e) {
    $users = [];
    $error = "Error getting users: " . $e->getMessage();
}

// Handle CSV export
if (isset($_GET['export'])) {
    header('Content-Type: text/csv');
    header('Content-Disposition: attachment; filename="chatsy_users_' . date('Y-m-d') . '.csv"');
    
    $output = fopen('php://output', 'w');
    fputcsv($output, ['ID', 'Name', 'Email', 'Provider', 'Created At', 'Last Login']);
    
    try {
        $stmt = $pdo->query("SELECT * FROM users ORDER BY created_at DESC");
        while ($user = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $provider = "Email";
            if ($user['is_google']) $provider = "Google";
            if ($user['is_apple']) $provider = "Apple";
            
            fputcsv($output, [
                $user['id'],
                $user['name'],
                $user['email'],
                $provider,
                $user['created_at'],
                $user['updated_at']
            ]);
        }
    } catch(PDOException $e) {
        fputcsv($output, ['Error', $e->getMessage()]);
    }
    
    fclose($output);
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chatsy User Database Admin</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { background: white; padding: 20px; border-radius: 10px; margin-bottom: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .header h1 { margin: 0; color: #333; }
        .header .subtitle { color: #666; margin-top: 5px; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 20px; }
        .stat-card { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); text-align: center; }
        .stat-card h3 { margin: 0 0 10px 0; color: #333; }
        .stat-card .number { font-size: 2em; font-weight: bold; color: #007cba; }
        .actions { background: white; padding: 20px; border-radius: 10px; margin-bottom: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .btn { display: inline-block; padding: 10px 20px; background: #007cba; color: white; text-decoration: none; border-radius: 5px; margin-right: 10px; }
        .btn:hover { background: #005a87; }
        .btn-danger { background: #dc3545; }
        .btn-danger:hover { background: #c82333; }
        .btn-success { background: #28a745; }
        .btn-success:hover { background: #218838; }
        .users-table { background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; font-weight: bold; }
        tr:hover { background: #f8f9fa; }
        .pagination { text-align: center; margin-top: 20px; }
        .pagination a { display: inline-block; padding: 8px 12px; margin: 0 2px; background: #007cba; color: white; text-decoration: none; border-radius: 3px; }
        .pagination a:hover { background: #005a87; }
        .pagination .current { background: #6c757d; }
        .provider-badge { padding: 3px 8px; border-radius: 12px; font-size: 12px; font-weight: bold; }
        .provider-google { background: #4285f4; color: white; }
        .provider-apple { background: #000; color: white; }
        .provider-email { background: #6c757d; color: white; }
        .logout { float: right; }
        .error { background: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🗄️ Chatsy User Database Admin</h1>
            <div class="subtitle">Full access to your user database - No developers needed!</div>
            <div class="logout">
                <a href="?logout=1" class="btn btn-danger">Logout</a>
            </div>
        </div>

        <?php if (isset($error)): ?>
            <div class="error"><?php echo $error; ?></div>
        <?php endif; ?>

        <!-- Statistics -->
        <div class="stats">
            <div class="stat-card">
                <h3>Total Users</h3>
                <div class="number"><?php echo number_format($stats['total_users'] ?? 0); ?></div>
            </div>
            <div class="stat-card">
                <h3>Google Users</h3>
                <div class="number"><?php echo number_format($stats['google_users'] ?? 0); ?></div>
            </div>
            <div class="stat-card">
                <h3>Apple Users</h3>
                <div class="number"><?php echo number_format($stats['apple_users'] ?? 0); ?></div>
            </div>
            <div class="stat-card">
                <h3>Email Users</h3>
                <div class="number"><?php echo number_format($stats['email_users'] ?? 0); ?></div>
            </div>
            <div class="stat-card">
                <h3>Today's Signups</h3>
                <div class="number"><?php echo number_format($stats['today_users'] ?? 0); ?></div>
            </div>
            <div class="stat-card">
                <h3>This Month</h3>
                <div class="number"><?php echo number_format($stats['this_month'] ?? 0); ?></div>
            </div>
        </div>

        <!-- Actions -->
        <div class="actions">
            <h3>Quick Actions</h3>
            <a href="?export=1" class="btn btn-success">📊 Export Users to CSV</a>
            <a href="admin_dashboard.php" class="btn">🔄 Refresh Data</a>
            <a href="https://aichatsy.com/aichatsy_5/api/" class="btn" target="_blank">🔗 Backend API</a>
        </div>

        <!-- Users Table -->
        <div class="users-table">
            <h3 style="margin: 0; padding: 20px; background: #f8f9fa;">👥 All Users (Page <?php echo $page; ?> of <?php echo $total_pages; ?>)</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Provider</th>
                        <th>Created</th>
                        <th>Last Updated</th>
                        <th>Device ID</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($users as $user): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($user['id']); ?></td>
                            <td><?php echo htmlspecialchars($user['name'] ?? 'N/A'); ?></td>
                            <td><?php echo htmlspecialchars($user['email'] ?? 'N/A'); ?></td>
                            <td>
                                <?php
                                $provider = "Email";
                                $class = "provider-email";
                                if ($user['is_google']) {
                                    $provider = "Google";
                                    $class = "provider-google";
                                } elseif ($user['is_apple']) {
                                    $provider = "Apple";
                                    $class = "provider-apple";
                                }
                                echo "<span class='provider-badge $class'>$provider</span>";
                                ?>
                            </td>
                            <td><?php echo date('Y-m-d H:i', strtotime($user['created_at'])); ?></td>
                            <td><?php echo date('Y-m-d H:i', strtotime($user['updated_at'])); ?></td>
                            <td><?php echo htmlspecialchars(substr($user['device_id'] ?? 'N/A', 0, 20)); ?>...</td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <?php if ($total_pages > 1): ?>
            <div class="pagination">
                <?php for ($i = 1; $i <= $total_pages; $i++): ?>
                    <a href="?page=<?php echo $i; ?>" <?php echo $i == $page ? 'class="current"' : ''; ?>>
                        <?php echo $i; ?>
                    </a>
                <?php endfor; ?>
            </div>
        <?php endif; ?>

        <!-- Instructions -->
        <div style="background: white; padding: 20px; border-radius: 10px; margin-top: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
            <h3>📝 Instructions</h3>
            <p><strong>To update database credentials:</strong></p>
            <ol>
                <li>Edit this file (admin_dashboard.php)</li>
                <li>Update the database variables at the top</li>
                <li>Save and refresh this page</li>
            </ol>
            <p><strong>To get your database credentials:</strong></p>
            <ol>
                <li>Login to your Namecheap cPanel</li>
                <li>Go to "MySQL Databases"</li>
                <li>Find your database name and user credentials</li>
                <li>Update the variables in this file</li>
            </ol>
            <p><strong>Security:</strong> Change the admin password in the code!</p>
        </div>
    </div>
</body>
</html>


