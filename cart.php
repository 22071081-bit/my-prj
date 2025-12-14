<?php
include("./includes/header.php");
if (!isset($_SESSION['auth_user']['id'])) {
    die("Bạn chưa đăng nhập tài khoản. <a style='color: red;' href='./login.php'>Đăng nhập ngay</a>");
}
?>

<body>
    <div class="bg-main">
        <div class="container">
            <div class="box">
                <div class="breadcumb">
                    <a href="index.php">Trang chủ</a>
                    <span><i class='bx bxs-chevrons-right'></i></span>
                    <a href="#">Giỏ hàng của tôi</a>
                </div>
            </div>

            <div class="box" style="padding: 0 40px">
                <div class="product-info">
                    <?php
                    $products = getMyOrders();
                    $total_price = 0;
                    if (mysqli_num_rows($products) == 0) {
                    ?>
                        <p style="font-size: 20px; text-align: center;">
                            Giỏ hàng của bạn trống. Mua ngay <a style="color: blue; text-decoration: underline" href="./products.php">tại đây</a>
                        </p>
                    <?php } else { ?>
                        <table width="100%" border="1" cellspacing="0">
                            <tr>
                                <th>Tên sản phẩm</th>
                                <th>Số lượng</th>
                                <th>Giá</th>
                                <th>Tổng</th>
                                <th>Xóa</th>
                                <th>Cập nhật</th>
                            </tr>
                            <?php foreach ($products as $product) { ?>
                                <tr>
                                    <td style="text-align: left;">
                                        <a href="./product-detail.php?slug=<?= $product['slug'] ?>">
                                            <?= $product['name'] ?>
                                        </a>
                                    </td>
                                    <form action="./functions/ordercode.php" method="post">
                                        <td width=100>
                                            <input type="hidden" name="update_product" value="true">
                                            <input type="hidden" name="product_id" value="<?= $product['product_id'] ?>">
                                            <input type="hidden" class="product-price" value="<?= $product['selling_price'] ?>">
                                            <input type="number" name="quantity" value="<?= $product['quantity'] ?>" class="input-number">
                                        </td>
                                        <td>
                                            <span>
                                                <?= number_format($product['selling_price'], 0, ',', '.') ?>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="total-price">
                                                <?= number_format($product['selling_price'] * $product['quantity'], 0, ',', '.') ?>
                                            </span>
                                        </td>
                                        <td>
                                            <a class="btn-buy" style="background-color: #fc8d8b" href="./functions/ordercode.php?deleteID=<?= $product['id'] ?>">Xóa</a>
                                        </td>
                                        <td>
                                            <button class="btn-buy">Cập nhật</button>
                                        </td>
                                    </form>
                                </tr>
                            <?php
                                $total_price +=  $product['selling_price'] * $product['quantity'];
                            }
                            ?>
                        </table>
                        <form action="./functions/ordercode.php" method="post" class="form-pay">
                            <input type="hidden" name="buy_product" value="true">
                            <div class="shipping-options" style="margin: 20px 0;">
                                <h4>Phương thức giao hàng:</h4>
                                <div style="margin: 10px 0;">
                                    <input type="radio" id="normal" name="shipping" value="normal" checked>
                                    <label for="normal">Giao hàng thường (1-2 ngày) - Miễn phí</label>
                                </div>
                                <div style="margin: 10px 0;">
                                    <input type="radio" id="express" name="shipping" value="express">
                                    <label for="express">Giao hàng nhanh (trong ngày) - 50.000đ</label>
                                </div>
                            </div>
                            <div class="total-section">
                                <span>Phí vận chuyển: <span id="shipping-fee">0</span>đ</span>
                                <span>Tổng tiền hàng: <?= number_format($total_price, 0, '', '.') ?>đ</span>
                                <span>Tổng thanh toán: <span id="final-total"><?= number_format($total_price, 0, '', '.') ?></span>đ</span>
                            </div>
                            <button class="btn-model">Đặt hàng</button>
                            <div class="model none">
                                <div class="model-body">
                                    <p style="font-weight: bold; font-size: 18px; text-align: center;">Quét mã QR để thanh toán</p>
                                    <img src="./images/qrcode.png" alt="">
                                    <div class="btn-group">
                                        <button type="submit" value="online" name="btn-pay">Thanh toán online</button>
                                        <button type="submit" value="offline" name="btn-pay">Thanh toán khi nhận hàng</button>
                                        <button class="close" id="close-model">Hủy</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    <?php } ?>
                    <a href="./purchase-history.php">
                        <h4>Xem đơn hàng đã mua</h4>
                    </a>
                    <br>
                    <br>
                </div>
            </div>
        </div>
    </div>

    <?php include("./includes/footer.php") ?>
    <script src="./assets/js/app.js"></script>
    <script src="./assets/js/index.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</body>
<script>
    $(document).ready(function() {
        $('.input-number').on('change', function(e) {
            if (e.target.value == 0) {
                e.target.value = 1;
            }
            const node = $(this).parent().parent();
            const price = parseInt(node.find('.product-price').val());
            let total_order = parseInt(e.target.value);
            let total_price = price * total_order;
            node.find('.total-price').html(total_price);
        });

        $(document).on('click', '.btn-model', function(event) {
            event.preventDefault();

            $('.model').css('display', 'flex');
        });

        $(document).on('click', '#close-model', function(event) {
            event.preventDefault();

            $('.model').css('display', 'none');
        });

        // Xử lý thay đổi phương thức giao hàng
        $('input[name="shipping"]').change(function() {
            const shippingFee = $(this).val() === 'express' ? 50000 : 0;
            const totalPrice = <?= $total_price ?>;
            const finalTotal = totalPrice + shippingFee;

            $('#shipping-fee').text(shippingFee.toLocaleString('vi-VN'));
            $('#final-total').text(finalTotal.toLocaleString('vi-VN'));
        });
    });
</script>

</html>