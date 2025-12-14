<?php
include("./includes/header.php");
if (!isset($_SESSION['auth'])) {
    redirect("login.php", "Vui lòng đăng nhập để tiếp tục");
}
if (isset($_GET['id'])) {
    $order_id = $_GET['id'];
    $order = getOrderDetails($order_id);

    if ($order) {
        $items = getOrderItems($order_id);
?>

        <body>
            <div class="bg-main">
                <div class="container">
                    <div class="box">
                        <div class="card-header bg-primary">
                            <span class="text-white fs-4">Chi tiết đơn hàng #<?= $order_id ?></span>
                            <a href="purchase-history.php" class="btn btn-warning float-end">Quay lại</a>
                        </div>
                        <div class="card-body">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <h4>Thông tin đơn hàng</h4>
                                    <hr>
                                    <p><strong>Ngày đặt:</strong> <?= date('d/m/Y H:i', strtotime($order['created_at'])) ?></p>
                                    <p><strong>Phương thức giao hàng:</strong> <?= $order['shipping_method'] == 'express' ? 'Giao hàng nhanh' : 'Giao hàng thường' ?></p>
                                    <p><strong>Phí vận chuyển:</strong> <?= number_format($order['shipping_fee'], 0, ',', '.') ?>đ</p>
                                    <p><strong>Trạng thái:</strong>
                                        <?php
                                        if ($order['status'] == '2') echo "Đang chuẩn bị hàng";
                                        else if ($order['status'] == '3') echo "Đang giao hàng";
                                        else if ($order['status'] == '4') echo "Đã giao";
                                        else if ($order['status'] == '5') echo "Đã thanh toán";
                                        else if ($order['status'] == '6') echo "Đã hủy";
                                        ?>
                                    </p>
                                </div>
                            </div>

                            <h4>Sản phẩm</h4>
                            <hr>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Hình ảnh</th>
                                        <th>Sản phẩm</th>
                                        <th>Giá</th>
                                        <th>Số lượng</th>
                                        <th>Thành tiền</th>
                                        <th>Đánh giá</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    $total = 0;
                                    foreach ($items as $item) {
                                        $subtotal = $item['selling_price'] * $item['quantity'];
                                        $total += $subtotal;
                                    ?>
                                        <tr>
                                            <td class="product-image">
                                                <img src="images/<?= $item['image'] ?>" alt="<?= $item['name'] ?>"
                                                    style="width: 80px; height: 80px; object-fit: cover;">
                                            </td>
                                            <td>
                                                <a href="product-detail.php?slug=<?= $item['slug'] ?>">
                                                    <?= $item['name'] ?>
                                                </a>
                                            </td>
                                            <td><?= number_format($item['selling_price'], 0, ',', '.') ?>đ</td>
                                            <td><?= $item['quantity'] ?></td>
                                            <td><?= number_format($subtotal, 0, ',', '.') ?>đ</td>
                                            <td>
                                                <?php if ($order['status'] == '4'): ?>
                                                    <?php if ($item['rate'] > 0): ?>
                                                        <a href="vote.php?id=<?= $item['id'] ?>" class="btn btn-sm btn-info">Đánh giá lại</a>
                                                    <?php else: ?>
                                                        <a href="vote.php?id=<?= $item['id'] ?>" class="btn btn-sm btn-primary">Đánh giá</a>
                                                    <?php endif; ?>
                                                <?php elseif ($order['status'] == '3'): ?>
                                                    <form method="POST" action="./functions/ordercode.php">
                                                        <input type="hidden" name="order_id" value="<?= $item['id'] ?>">
                                                        <button type="submit" name="received" class="btn btn-sm btn-success"
                                                            onclick="return confirm('Xác nhận đã nhận được hàng?')">
                                                            Đã nhận
                                                        </button>
                                                    </form>
                                                <?php else: ?>
                                                    <span class="text-muted">Chưa thể đánh giá</span>
                                                <?php endif; ?>
                                            </td>
                                        </tr>
                                    <?php } ?>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="4" class="text-end"><strong>Tổng tiền hàng:</strong></td>
                                        <td colspan="2"><?= number_format($total, 0, ',', '.') ?>đ</td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="text-end"><strong>Phí vận chuyển:</strong></td>
                                        <td colspan="2"><?= number_format($order['shipping_fee'], 0, ',', '.') ?>đ</td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="text-end"><strong>Tổng thanh toán:</strong></td>
                                        <td colspan="2"><?= number_format($total + $order['shipping_fee'], 0, ',', '.') ?>đ</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
    <?php
    } else {
        echo "<div class='py-5'><div class='container'><h4>Không tìm thấy đơn hàng</h4></div></div>";
    }
} else {
    echo "<div class='py-5'><div class='container'><h4>Đường dẫn không hợp lệ</h4></div></div>";
}

include("./includes/footer.php"); ?>
        </body>