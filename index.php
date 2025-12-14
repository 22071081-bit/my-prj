<?php
include("./includes/header.php");

$bestSellingProducts    =   getBestSelling(8);
$LatestProducts         =   getLatestProducts(8);
?>

<body>
    <div class="hero">
        <div class="slider">
            <div class="container">
                <?php
                $count = 0;
                foreach ($bestSellingProducts as $product) {
                    if ($count == 3) {
                        break;
                    }
                ?>
                    <div class="slide">
                        <div class="info">
                            <div class="info-content">
                                <h2 class="top-down trans-delay-0-2">
                                    <?= (strlen($product['name']) > 50) ? substr($product['name'], 0, 47) . '...' : $product['name'] ?>
                                </h2>

                                <p class="top-down trans-delay-0-4">
                                    <?= nl2br((strlen($product['small_description']) > 200) ? substr($product['small_description'], 0, 200) . '...' : $product['small_description']) ?>
                                </p>

                                <div class="top-down trans-delay-0-6">
                                    <a href="./product-detail.php?slug=<?= $product['slug'] ?>">
                                        <button class="btn-flat btn-hover">
                                            <span>Mua ngay</span>
                                        </button>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="img right-left">
                            <img src="./images/<?= $product['image'] ?>" alt="">
                        </div>
                    </div>
                <?php
                    $count++;
                }
                ?>
            </div>
            <button class="slide-controll slide-next">
                <i class='bx bxs-chevron-right'></i>
            </button>
            <button class="slide-controll slide-prev">
                <i class='bx bxs-chevron-left'></i>
            </button>
        </div>
    </div>

    <div class="promotion">
        <div class="row">
            <?php
            $count = 0;
            foreach ($LatestProducts as $product) {
                if ($count == 3) {
                    break;
                }
            ?>
                <div class="col-4 col-md-12 col-sm-12">
                    <div class="promotion-box">
                        <div class="text">
                            <h3><?= $product['name'] ?></h3>
                            <a href="./product-detail.php?slug=<?= $product['slug'] ?>">
                                <button class="btn-flat btn-hover"><span>Xem chi tiết</span></button>
                            </a>
                        </div>
                        <img src="./images/<?= $product['image'] ?>" alt="">
                    </div>
                </div>
            <?php
                $count++;
            }
            ?>
        </div>
    </div>

    <div class="section">
        <div class="container">
            <div class="section-header">
                <h2>Những sản phẩm mới nhất</h2>
            </div>
            <div class="row" id="latest-products">
                <?php
                foreach ($LatestProducts as $product) {
                ?>
                    <div class="col-3 col-md-6 col-sm-12">
                        <div class="product-card">
                            <div class="product-card-img">
                                <img src="./images/<?= $product['image'] ?>" alt="">
                                <img src="./images/<?= $product['image'] ?>" alt="">
                            </div>
                            <div class="product-card-info">
                                <div class="product-btn">
                                    <a href="./product-detail.php?slug=<?= $product['slug'] ?>">
                                        <button class="btn-flat btn-hover btn-shop-now">Mua ngay</button>
                                    </a>
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
            <div class="section-footer">
                <a href="./products.php" class="btn-flat btn-hover">Xem tất cả</a>
            </div>
        </div>
    </div>

    <div class="bg-second">
        <div class="section container">
            <div class="row">
                <?php
                foreach ($bestSellingProducts as $product) {
                ?>
                    <div class="col-4 col-md-4">
                        <div class="sp-item-img">
                            <img src="./images/<?= $product['image'] ?>" alt="">
                        </div>
                    </div>
                    <div class="col-7 col-md-8">
                        <div class="sp-item-info">
                            <div class="sp-item-name"><?= $product['name'] ?></div>
                            <p class="sp-item-description">
                                <?= $product['small_description'] ?>
                            </p>
                            <a href="./product-detail.php?slug=<?= $product['slug'] ?>">
                                <button class="btn-flat btn-hover">Xem chi tiết</button>
                            </a>
                        </div>
                    </div>
                <?php
                    break;
                }
                ?>
            </div>
        </div>
    </div>

    <div class="section">
        <div class="container">
            <div class="section-header">
                <h2>Những sản phẩm bán chạy nhất</h2>
            </div>
            <div class="row" id="best-products">
                <?php
                foreach ($bestSellingProducts as $product) {
                ?>
                    <div class="col-3 col-md-6 col-sm-12">
                        <div class="product-card">
                            <div class="product-card-img">
                                <img src="./images/<?= $product['image'] ?>" alt="">
                                <img src="./images/<?= $product['image'] ?>" alt="">
                            </div>
                            <div class="product-card-info">
                                <div class="product-btn">
                                    <a href="./product-detail.php?slug=<?= $product['slug'] ?>">
                                        <button class="btn-flat btn-hover btn-shop-now">Mua ngay</button>
                                    </a>
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
            <div class="section-footer">
                <a href="./products.php" class="btn-flat btn-hover">Xem tất cả</a>
            </div>
        </div>
    </div>

    <?php include("./includes/footer.php") ?>
    <script src="./assets/js/app.js"></script>
    <script src="./assets/js/index.js"></script>
</body>

</html>