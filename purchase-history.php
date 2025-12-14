<?php
include("./includes/header.php");
if (!isset($_SESSION['auth'])) {
    redirect("login.php", "Vui lòng đăng nhập để tiếp tục");
}
$orders = getOrders();
?>

<body>
    <div class="bg-main">
        <div class="container">
            <div class="box">
                <div class="breadcumb">
                    <a href="index.php">Trang chủ</a>
                    <span><i class='bx bxs-chevrons-right'></i></span>
                    <lý href="#">Quản lý đơn hàng</lý>
                </div>
            </div>
            <div class="box" style="padding: 0 40px">
                <table width="100%" border="1" cellspacing="0" class="table">
                    <thead>
                        <tr>
                            <th>Mã đơn hàng</th>
                            <th>Ngày đặt</th>
                            <th>Phương thức giao hàng</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Chi tiết</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        if (mysqli_num_rows($orders) > 0) {
                            foreach ($orders as $order) {
                                $shipping_method = $order['shipping_method'] == 'express' ? 'Giao hàng nhanh' : 'Giao hàng thường';
                                $total = $order['total_amount'] + $order['shipping_fee'];
                        ?>
                                <tr>
                                    <td>#<?= $order['id'] ?></td>
                                    <td><?= date('d/m/Y H:i', strtotime($order['created_at'])) ?></td>
                                    <td><?= $shipping_method ?></td>
                                    <td><?= number_format($total, 0, ',', '.') ?></td>
                                    <td>
                                        <?php
                                        if ($order['status'] == '2') {
                                            echo "<span class='badge bg-warning'>Đang chuẩn bị hàng</span>";
                                        } else if ($order['status'] == '3') {
                                            echo "<span class='badge bg-info'>Đang giao hàng</span>";
                                        } else if ($order['status'] == '4') {
                                            echo "<span class='badge bg-success'>Đã giao</span>";
                                        } else if ($order['status'] == '5') {
                                            echo "<span class='badge bg-primary'>Đã thanh toán</span>";
                                        } else if ($order['status'] == '6') {
                                            echo "<span class='badge bg-danger'>Đã hủy</span>";
                                        }
                                        ?>
                                    </td>
                                    <td>
                                        <a href="order-details.php?id=<?= $order['id'] ?>" class="btn btn-primary btn-sm">Xem chi tiết</a>
                                    </td>
                                </tr>
                        <?php
                            }
                        } else {
                            echo "<tr><td colspan='6' class='text-center'>Chưa có đơn hàng nào</td></tr>";
                        }
                        ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <?php include("./includes/footer.php") ?>
</body>