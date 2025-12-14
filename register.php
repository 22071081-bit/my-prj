<?php
include("./includes/header.php");
?>
<script src="../assets/js/boostrap.bundle.js"></script>

<div class="login-container">
    <div class="login-centered-card">
        <div class="login-form-section">
            <h2>Đăng Ký</h2>
            <p>Tạo tài khoản mới để trải nghiệm mua sắm tại Vinamotor.</p>

            <form action="./functions/authcode.php" method="POST" id="register-account">
                <div class="mb-3">
                    <label class="form-label">Họ và tên</label>
                    <input type="text" required name="name" class="form-control" placeholder="Nhập họ tên của bạn">
                </div>
                <div class="mb-3">
                    <label for="InputEmail" class="form-label">Email</label>
                    <input type="email" required name="email" class="form-control" id="InputEmail" aria-describedby="emailHelp" placeholder="Nhập Email của bạn">
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Số điện thoại</label>
                    <input type="number" required name="phone" id="phone" class="form-control" placeholder="Nhập số điện thoại của bạn">
                </div>
                <div class="mb-3">
                    <label for="InputPassword1" class="form-label">Mật khẩu</label>
                    <input type="password" required name="password" id="InputPassword1" class="form-control" placeholder="Nhập mật khẩu">
                </div>
                <div class="mb-3">
                    <label for="InputPassword2" class="form-label">Xác nhận mật khẩu</label>
                    <input type="password" required name="cpassword" id="InputPassword2" class="form-control" placeholder="Xác nhận mật khẩu">
                </div>
                <input type="hidden" name="register-btn" value="check">

                <div class="d-flex justify-content-between align-items-center mt-3" style="display: block !important;">
                     <button type="submit" class="btn btn-login">Đăng Ký</button>
                    <!-- Nút đăng nhập -->
                     <div class="text-center mt-3">
                         Đã có tài khoản? <a href="./login.php">Đăng nhập ngay</a>
                     </div>
                </div>

            </form>
        </div>
    </div>
</div>

<script>
    const validateEmail = (email) => {
        return String(email)
            .toLowerCase()
            .match(
                /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
            );
    };

    // const validateName = (name) => {
    //     return /^[A-Za-z\s]{4,}$/.test(name) && !/\s{2,}/.test(name) && name.trim().length > 0;
    //     // Kiểm tra họ tên không chứa số, ký tự đặc biệt, độ dài tối thiểu 4 ký tự, không chỉ chứa khoảng trắng hoặc 2 ký tự khoảng trắng liên tục
    // };

    const validatePhone = (phone) => {
        return /^\d{10,15}$/.test(phone); // Kiểm tra số điện thoại từ 10 đến 15 ký tự số
    };

    const validatePassword = (password) => {
        return /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/.test(password);
        // Mật khẩu phải có ít nhất 8 ký tự, 1 chữ hoa, 1 chữ thường, 1 số và 1 ký tự đặc biệt
    };

    document.getElementById("register-account").addEventListener('submit', function(e) {
        let name = document.getElementsByName("name")[0].value;
        let email = document.getElementById("InputEmail").value;
        let password1 = document.getElementById("InputPassword1").value;
        let password2 = document.getElementById("InputPassword2").value;
        let phone = document.getElementsByName("phone")[0].value;

        if (!validateName(name)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.success('Họ tên không được để trống hoặc chứa số, ký tự đặc biệt');
            e.preventDefault();
        } else if (!validateEmail(email)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.success('Lỗi email không hợp lệ');
            e.preventDefault();
        } else if (!validatePhone(phone)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.success('Số điện thoại không hợp lệ');
            e.preventDefault();
        } else if (!validatePassword(password1)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.success('Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt');
            e.preventDefault();
        } else if (password1 != password2) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.success('Mật khẩu chưa khớp');
            e.preventDefault();
        } else if (password1.length <= 6) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.success('Vui lòng nhập mật khẩu nhiều hơn 6 kí tự');
            e.preventDefault();
        }
    })
</script>
<?php include("./includes/footer.php") ?>