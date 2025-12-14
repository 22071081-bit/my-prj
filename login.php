<?php
include("./includes/header.php");
?>

<script src="../assets/js/boostrap.bundle.js"></script>

<div class="login-container">
    <div class="login-centered-card">
        <div class="login-form-section">
            <h2>Đăng nhập vào Vinamotor</h2>
            <p>Đăng nhập để trải nghiệm mua hàng tại VinaMotor ngay.</p>

            <form action="./functions/authcode.php" method="POST">
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" name="email" id="email" class="form-control" placeholder="email@gmail.com" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <input type="password" name="password" id="password" class="form-control" placeholder="Mật khẩu của bạn" required>
                    <!-- Icon show/hide password might need adjustment based on new design -->
                </div>
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">Nhớ tài khoản</label>
                    </div>
                    <a href="./forgot-password.php" class="forgot-password-link">Quên mật khẩu?</a>
                </div>

                 <div class="d-flex justify-content-between align-items-center mt-3" style="display: block !important;">
                     <button type="submit" name="login_btn" class="btn btn-login">Đăng nhập</button>
                     <!-- Nút đăng ký -->
                     <div class="text-center mt-3">
                          Chưa có tài khoản? <a href="./register.php">Đăng ký ngay</a>
                     </div>
                </div>

            </form>
        </div>
    </div>
</div>

<?php include("./includes/footer.php") ?>
<!-- Script for password toggle might need updating if icon structure changes -->
<!-- Keep the original script block here for now -->
<script>
    const togglePassword = document.getElementById('togglePassword');
    const passwordInput = document.getElementById('InputPassword');

    // Check if the elements exist before adding event listener
    if(togglePassword && passwordInput) {
        togglePassword.addEventListener('click', function() {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            this.classList.toggle('bx-show');
            this.classList.toggle('bx-hide');
        });
    }
</script>