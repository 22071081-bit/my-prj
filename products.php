<?php

include("./includes/header.php");

$products   =   getLatestProducts(9, $page, $type, $search);
$page++;
?>

<body>
    <div class="bg-main">
        <div class="container">
            <div class="box">
                <div class="breadcumb">
                    <a href="index.php">Trang chủ</a>
                    <span><i class='bx bxs-chevrons-right'></i></span>
                    <a href="./products.php">Tất cả sản phẩm</a>
                </div>
            </div>
            <div class="box">
                <div class="row">
                    <div class="col-3 filter-col" id="filter-col">
                        <div class="box filter-toggle-box">
                            <button class="btn-flat btn-hover" id="filter-close">close</button>
                        </div>
                        <div class="box">
                            <span class="filter-header">
                                Danh mục
                            </span>
                            <ul class="filter-list">
                                <?php
                                $categories = getAllActive("categories");

                                if (mysqli_num_rows($categories) > 0) {
                                    foreach ($categories as $item) {
                                ?>
                                        <li><a href="./products.php?type=<?= $item['slug'] ?>"><?= $item['name']; ?></a></li>
                                <?php
                                    }
                                } else {
                                    echo "no";
                                }
                                ?>

                            </ul>
                        </div>
                    </div>
                    <div class="col-9 col-md-12">
                        <div class="box filter-toggle-box">
                            <button id="filter-toggle">Lọc</button>
                        </div>
                        <div class="box">
                            <div class="row" id="products">
                                <?php foreach ($products as $product) { ?>
                                    <div class="col-4 col-md-6 col-sm-12">
                                        <div class="product-card">
                                            <div class="product-card-img">
                                                <img src="./images/<?= $product['image'] ?>" alt="">
                                                <img src="./images/<?= $product['image'] ?>" alt="">
                                            </div>
                                            <div class="product-card-info">
                                                <div class="product-btn">
                                                    <?php
                                                        // Check if user is logged in
                                                        $buyNowLink = '';
                                                        if (isset($_SESSION['auth'])) {
                                                            $buyNowLink = './product-detail.php?slug=' . $product['slug'];
                                                        } else {
                                                            $buyNowLink = 'login.php'; // Redirect to login page
                                                        }
                                                    ?>
                                                    <a href="<?= $buyNowLink ?>" class="btn-flat btn-hover btn-shop-now">Mua ngay</a>
                                                </div>
                                                <div class="product-card-name">
                                                    <?= $product['name'] ?>
                                                </div>
                                                <div class="product-card-price">
                                                    <span><del><?= number_format($product['original_price'], 0, ',', '.') ?>đ</del></span>
                                                    <span class="curr-price"><?= number_format($product['selling_price'], 0, ',', '.') ?>đ</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="box">
                            <ul class="pagination">
                                <?php
                                for ($i = 1; $i <= ceil(totalValue('products') / 9); $i++) {
                                    if ($i == $page) {
                                        echo "<li><a class='active'>$i</a></li>";
                                    } else {
                                        echo "<li><a href='?page=$i'>$i</a></li>";
                                    }
                                }
                                ?>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <?php include("./includes/footer.php") ?>
    <script src="./assets/js/app.js"></script>
    <script src="./assets/js/products.js"></script>
</body>

</html>