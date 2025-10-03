<?php
session_start();

// Database credentials (UPDATE THESE!)
$servername = "localhost"; // Usually 'localhost'
$username = "your_db_username"; // Your database username
$password = "your_db_password"; // Your database password
$dbname = "aichocka_aichatsy_5"; // Your database name

// Admin password for this dashboard (CHANGE THIS!)
$admin_password = "chatsy_admin_2024"; 

// Check if already logged in
if (isset($_SESSION['admin_logged_in']) && $_SESSION['admin_logged_in'] === true) {
    // User is logged in, proceed to dashboard
} else {
    // Handle login
    if (isset($_POST['dashboard_password'])) {
        if ($_POST['dashboard_password'] === $admin_password) {
            $_SESSION['admin_logged_in'] = true;
        } else {
            $login_error = "Invalid password.";
        }
    }

    // If not logged in, show login form
    if (!isset($_SESSION['admin_logged_in']) || $_SESSION['admin_logged_in'] !== true) {
        ?>
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Chatsy Admin Login</title>
            <style>
                body { 
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    display: flex; 
                    justify-content: center; 
                    align-items: center; 
                    height: 100vh; 
                    margin: 0; 
                }
                .login-container { 
                    background-color: #fff; 
                    padding: 40px; 
                    border-radius: 15px; 
                    box-shadow: 0 15px 35px rgba(0,0,0,0.1);
                    text-align: center; 
                    width: 400px;
                }
                .login-container h2 { 
                    color: #333; 
                    margin-bottom: 30px; 
                    font-size: 28px;
                }
                .login-container input[type="password"] { 
                    width: 100%; 
                    padding: 15px; 
                    margin-bottom: 20px; 
                    border: 2px solid #ddd; 
                    border-radius: 8px; 
                    box-sizing: border-box;
                    font-size: 16px;
                }
                .login-container button { 
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white; 
                    padding: 15px 30px; 
                    border: none; 
                    border-radius: 8px; 
                    cursor: pointer; 
                    font-size: 16px;
                    width: 100%;
                }
                .login-container button:hover { 
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
                }
                .error { 
                    color: #e74c3c; 
                    margin-top: 15px; 
                    font-weight: bold;
                }
            </style>
        </head>
        <body>
            <div class="login-container">
                <h2>🚀 Chatsy Admin Dashboard</h2>
                <form method="POST">
                    <input type="password" name="dashboard_password" placeholder="Enter Admin Password" required>
                    <button type="submit">Login to Dashboard</button>
                </form>
                <?php if (isset($login_error)) { echo '<p class="error">' . $login_error . '</p>'; } ?>
            </div>
        </body>
        </html>
        <?php
        exit(); // Stop execution if not logged in
    }
}

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// --- Fetch Statistics ---
$total_users = $conn->query("SELECT COUNT(*) FROM user_master")->fetch_row()[0];
$subscribed_users = $conn->query("SELECT COUNT(*) FROM user_master WHERE is_subscription = 1")->fetch_row()[0];
$first_time_users = $conn->query("SELECT COUNT(*) FROM user_master WHERE is_first_time = 1")->fetch_row()[0];
$google_users = $conn->query("SELECT COUNT(*) FROM user_master WHERE is_google = 1")->fetch_row()[0];
$apple_users = $conn->query("SELECT COUNT(*) FROM user_master WHERE is_apple = 1")->fetch_row()[0];

$today = date('Y-m-d');
$today_signups = $conn->query("SELECT COUNT(*) FROM user_master WHERE DATE(created_at) = '$today'")->fetch_row()[0];

$this_month = date('Y-m');
$this_month_signups = $conn->query("SELECT COUNT(*) FROM user_master WHERE DATE_FORMAT(created_at, '%Y-%m') = '$this_month'")->fetch_row()[0];

// --- Fetch Users with Pagination ---
$limit = 50; // Number of entries per page
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$offset = ($page - 1) * $limit;

$search_query = "";
if (isset($_GET['search']) && !empty($_GET['search'])) {
    $search = $conn->real_escape_string($_GET['search']);
    $search_query = "WHERE name LIKE '%$search%' OR email LIKE '%$search%' OR google_id LIKE '%$search%' OR apple_id LIKE '%$search%'";
}

$users_result = $conn->query("SELECT * FROM user_master $search_query ORDER BY created_at DESC LIMIT $limit OFFSET $offset");
$total_users_filtered = $conn->query("SELECT COUNT(*) FROM user_master $search_query")->fetch_row()[0];
$total_pages = ceil($total_users_filtered / $limit);

// --- Export to CSV ---
if (isset($_GET['export']) && $_GET['export'] == 'csv') {
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename=chatsy_users_complete.csv');
    $output = fopen('php://output', 'w');
    fputcsv($output, array('User ID', 'Name', 'Email', 'Google ID', 'Apple ID', 'Subscription', 'First Time', 'Purchase Date', 'Plan Expiry', 'Product ID', 'Created At', 'Updated At')); // Headers

    $all_users_result = $conn->query("SELECT user_id, name, email, google_id, apple_id, is_subscription, is_first_time, purchase_date, plan_expiry, product_id, created_at, updated_at FROM user_master ORDER BY created_at DESC");
    while ($row = $all_users_result->fetch_assoc()) {
        fputcsv($output, $row);
    }
    fclose($output);
    exit();
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chatsy Admin Dashboard - Complete User Management</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: #f8f9fa; 
        }
        .wrapper { 
            display: flex; 
        }
        .sidebar { 
            width: 280px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; 
            height: 100vh; 
            padding-top: 20px; 
            position: fixed; 
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        .sidebar a { 
            color: white; 
            padding: 15px 25px; 
            text-decoration: none; 
            display: block; 
            transition: all 0.3s ease;
            border-radius: 8px;
            margin: 5px 15px;
        }
        .sidebar a:hover { 
            background-color: rgba(255,255,255,0.2); 
            text-decoration: none; 
            transform: translateX(5px);
        }
        .content { 
            margin-left: 280px; 
            padding: 30px; 
            width: calc(100% - 280px); 
        }
        .card { 
            margin-bottom: 25px; 
            border-radius: 15px; 
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            border: none;
        }
        .card-header { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; 
            border-bottom: none; 
            border-radius: 15px 15px 0 0; 
            padding: 20px;
        }
        .table-responsive { 
            margin-top: 20px; 
        }
        .pagination .page-link { 
            color: #667eea; 
            border-color: #dee2e6;
        }
        .pagination .page-item.active .page-link { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-color: #667eea; 
        }
        .badge-subscribed { 
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white; 
        }
        .badge-free { 
            background: linear-gradient(135deg, #6c757d, #495057);
            color: white; 
        }
        .badge-google { 
            background: linear-gradient(135deg, #db4437, #ea4335);
            color: white; 
        }
        .badge-apple { 
            background: linear-gradient(135deg, #000000, #333333);
            color: white; 
        }
        .logout-btn { 
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white; 
            border: none; 
            padding: 12px 20px; 
            border-radius: 8px; 
            cursor: pointer; 
            width: 100%;
            margin: 10px 15px;
        }
        .logout-btn:hover { 
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        .stats-card h3 {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .stats-card p {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        .search-container {
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 25px;
        }
        .table th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 15px;
        }
        .table td {
            padding: 12px 15px;
            vertical-align: middle;
        }
        .table tbody tr:hover {
            background-color: #f8f9fa;
            transform: scale(1.01);
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <div class="sidebar">
            <h3 class="text-center mb-4">🚀 Chatsy Admin</h3>
            <a href="?page=1"><i class="fas fa-users"></i> All Users</a>
            <a href="?subscription=1"><i class="fas fa-crown"></i> Subscribed Users</a>
            <a href="?first_time=1"><i class="fas fa-star"></i> First Time Users</a>
            <a href="?google=1"><i class="fab fa-google"></i> Google Users</a>
            <a href="?apple=1"><i class="fab fa-apple"></i> Apple Users</a>
            <a href="?export=csv"><i class="fas fa-file-csv"></i> Export All Users</a>
            <a href="?analytics=1"><i class="fas fa-chart-line"></i> Analytics</a>
            <form method="POST" action="" class="mt-4">
                <button type="submit" name="logout" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>
        
        <div class="content">
            <h1 class="mb-4">📊 Complete User Management Dashboard</h1>

            <!-- Statistics Cards -->
            <div class="row">
                <div class="col-md-3">
                    <div class="stats-card text-center">
                        <h3><i class="fas fa-users"></i> <?php echo number_format($total_users); ?></h3>
                        <p>Total Users</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card text-center">
                        <h3><i class="fas fa-crown"></i> <?php echo number_format($subscribed_users); ?></h3>
                        <p>Subscribed Users</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card text-center">
                        <h3><i class="fas fa-star"></i> <?php echo number_format($first_time_users); ?></h3>
                        <p>First Time Users</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card text-center">
                        <h3><i class="fas fa-calendar-day"></i> <?php echo number_format($today_signups); ?></h3>
                        <p>Today's Signups</p>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <div class="stats-card text-center">
                        <h3><i class="fab fa-google"></i> <?php echo number_format($google_users); ?></h3>
                        <p>Google Users</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card text-center">
                        <h3><i class="fab fa-apple"></i> <?php echo number_format($apple_users); ?></h3>
                        <p>Apple Users</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card text-center">
                        <h3><i class="fas fa-calendar-alt"></i> <?php echo number_format($this_month_signups); ?></h3>
                        <p>This Month</p>
                    </div>
                </div>
            </div>

            <!-- Search and Filter -->
            <div class="search-container">
                <form method="GET" class="form-inline">
                    <div class="form-group mr-3">
                        <input type="text" name="search" class="form-control" placeholder="Search users by name, email, Google ID, Apple ID..." value="<?php echo isset($_GET['search']) ? htmlspecialchars($_GET['search']) : ''; ?>" style="width: 400px;">
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search"></i> Search
                    </button>
                    <?php if (isset($_GET['search']) && !empty($_GET['search'])): ?>
                        <a href="?" class="btn btn-secondary ml-2">
                            <i class="fas fa-times"></i> Clear
                        </a>
                    <?php endif; ?>
                </form>
            </div>

            <!-- User List -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">
                        <i class="fas fa-users"></i> User Management 
                        <span class="badge badge-light"><?php echo number_format($total_users_filtered); ?> users</span>
                    </h4>
                    <div>
                        <a href="?export=csv" class="btn btn-light">
                            <i class="fas fa-download"></i> Export CSV
                        </a>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>User ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Google ID</th>
                                    <th>Apple ID</th>
                                    <th>Subscription</th>
                                    <th>First Time</th>
                                    <th>Purchase Date</th>
                                    <th>Plan Expiry</th>
                                    <th>Product ID</th>
                                    <th>Created At</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if ($users_result->num_rows > 0): ?>
                                    <?php while($row = $users_result->fetch_assoc()): ?>
                                        <tr>
                                            <td><strong><?php echo $row['user_id']; ?></strong></td>
                                            <td><?php echo $row['name'] ?: '<span class="text-muted">N/A</span>'; ?></td>
                                            <td><?php echo $row['email'] ?: '<span class="text-muted">N/A</span>'; ?></td>
                                            <td>
                                                <?php if ($row['google_id']): ?>
                                                    <span class="badge badge-google"><?php echo substr($row['google_id'], 0, 10) . '...'; ?></span>
                                                <?php else: ?>
                                                    <span class="text-muted">N/A</span>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <?php if ($row['apple_id']): ?>
                                                    <span class="badge badge-apple"><?php echo substr($row['apple_id'], 0, 10) . '...'; ?></span>
                                                <?php else: ?>
                                                    <span class="text-muted">N/A</span>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <?php if ($row['is_subscription'] == 1): ?>
                                                    <span class="badge badge-subscribed">Subscribed</span>
                                                <?php else: ?>
                                                    <span class="badge badge-free">Free</span>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <?php if ($row['is_first_time'] == 1): ?>
                                                    <span class="badge badge-warning">First Time</span>
                                                <?php else: ?>
                                                    <span class="badge badge-secondary">Returning</span>
                                                <?php endif; ?>
                                            </td>
                                            <td><?php echo $row['purchase_date'] ?: '<span class="text-muted">N/A</span>'; ?></td>
                                            <td><?php echo $row['plan_expiry'] ?: '<span class="text-muted">N/A</span>'; ?></td>
                                            <td><?php echo $row['product_id'] ?: '<span class="text-muted">N/A</span>'; ?></td>
                                            <td><?php echo $row['created_at']; ?></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary" onclick="editUser(<?php echo $row['user_id']; ?>)">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-sm btn-outline-info" onclick="viewUser(<?php echo $row['user_id']; ?>)">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    <?php endwhile; ?>
                                <?php else: ?>
                                    <tr>
                                        <td colspan="12" class="text-center py-4">
                                            <i class="fas fa-search fa-3x text-muted mb-3"></i>
                                            <p class="text-muted">No users found matching your search criteria.</p>
                                        </td>
                                    </tr>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <?php if ($total_pages > 1): ?>
                        <nav>
                            <ul class="pagination justify-content-center">
                                <?php for ($i = 1; $i <= $total_pages; $i++): ?>
                                    <li class="page-item <?php echo ($i == $page) ? 'active' : ''; ?>">
                                        <a class="page-link" href="?page=<?php echo $i; ?><?php echo isset($_GET['search']) ? '&search=' . htmlspecialchars($_GET['search']) : ''; ?>"><?php echo $i; ?></a>
                                    </li>
                                <?php endfor; ?>
                            </ul>
                        </nav>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <script>
        function editUser(userId) {
            alert('Edit user functionality for User ID: ' + userId + ' - Coming soon!');
        }
        
        function viewUser(userId) {
            alert('View user details for User ID: ' + userId + ' - Coming soon!');
        }
        
        // Auto-refresh stats every 30 seconds
        setInterval(function() {
            // You can add AJAX call here to refresh stats
        }, 30000);
    </script>
</body>
</html>

<?php
// Logout logic
if (isset($_POST['logout'])) {
    session_destroy();
    header("Location: " . $_SERVER['PHP_SELF']); // Redirect to clear POST data
    exit();
}
?>
