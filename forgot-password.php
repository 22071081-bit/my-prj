<?php
include("./includes/header.php");
?>
<script src="../assets/js/bootstrap.bundle.js"></script>

<div class="login-container">
    <div class="login-centered-card">
        <div class="login-form-section">
            <h2>Quên mật khẩu</h2>
            <p>Nhập thông tin tài khoản để lấy lại mật khẩu.</p>

            <form action="./functions/authcode.php" method="POST" id="forgot-password-form">
                <div class="mb-3">
                    <label for="username" class="form-label">Tài khoản</label>
                    <input type="text" name="username" class="form-control" id="username" placeholder="Nhập tài khoản" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" id="email" placeholder="Nhập Email" required>
                </div>
                
                 <div class="d-flex justify-content-between align-items-center mt-3" style="display: block !important;">
                     <button type="submit" name="forgot_password_btn" class="btn btn-login">Lấy lại mật khẩu</button>
                     <!-- Link to login page -->
                     <div class="text-center mt-3">
                          Đã nhớ mật khẩu? <a href="./login.php">Đăng nhập</a>
                     </div>
                </div>

            </form>
        </div>
    </div>
</div>

<script>
document.getElementById("forgot-password-form").addEventListener('submit', function(e) {
    e.preventDefault();
    
    const formData = new FormData(this);
    formData.append('forgot_password_btn', '1');
    
    fetch('./functions/authcode.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            Swal.fire({
                title: 'Thành công!',
                text: `Mật khẩu mới của bạn là: ${data.new_password}`,
                icon: 'success',
                confirmButtonText: 'Đăng nhập ngay',
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'login.php';
                }
            });
        } else {
            Swal.fire({
                title: 'Lỗi!',
                text: data.message,
                icon: 'error',
            });
        }
    })
    .catch(() => {
        Swal.fire({
            title: 'Lỗi!',
            text: 'Đã xảy ra lỗi, vui lòng thử lại sau.',
            icon: 'error',
        });
    });
});
</script>

<?php include("./includes/footer.php") ?>