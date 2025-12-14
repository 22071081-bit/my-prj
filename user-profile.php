<?php
include("./includes/header.php");

if (!isset($_SESSION['auth_user']['id'])) {
  die("Tu choi truy cap");
}

$id = $_SESSION['auth_user']['id'];
$users = getByID("users", $id);
$data = mysqli_fetch_array($users);

?>

<body>
  <div class="container">
    <div class="row p-4">
      <div class="col-md-4">
        <h1>Thông tin cá nhân</h1>
      </div>
      <div class="col-md-5">
        <form action="./functions/authcode.php" method="POST">
          <label class="mb-0" for=""><b>Họ và tên</b></label>
          <input class="form-control" required type="text" name="name" value="<?= $data['name'] ?>"><br>
          <label class="mb-0" for=""><b>Email</b></label>
          <input class="form-control" required type="text" name="email" value="<?= $data['email'] ?>"><br>
          <label class="mb-0" for=""><b>Số điện thoại</b></label>
          <input class="form-control" required type="text" name="phone" value="<?= $data['phone'] ?>"><br>
          <label class="mb-0" for=""><b>Địa chỉ</b></label>
          <input class="form-control" required type="text" name="address" value="<?= $data['address'] ?>"><br>
          <label class="mb-0" for=""><b>Mật khẩu</b></label>
          <input class="form-control" type="password" name="password"><br>
          <label class="mb-0" for=""><b>Xác nhận mật khẩu</b></label>
          <input class="form-control" type="password" name="cpassword"><br>
          <input type="hidden" name="update_user_btn" value="true">
          <button type="submit" class="btn btn-primary">Lưu</button>
        </form>

        <!-- Chỉ hiển thị nút khóa tài khoản nếu không phải admin -->
        <?php if ($_SESSION['role_as'] != 1): ?>
          <form action="./functions/authcode.php" method="POST" class="mt-3" onsubmit="return confirmDeactivate()">
            <input type="hidden" name="deactivate_account_btn" value="true">
            <button type="submit" class="btn btn-danger">Khóa tài khoản</button>
          </form>
        <?php endif; ?>
      </div>
    </div>
  </div>
</body>

<script>
  document.querySelector('form').addEventListener('submit', function(e) {
    let name = document.getElementsByName("name")[0].value;
    let email = document.getElementsByName("email")[0].value;
    let phone = document.getElementsByName("phone")[0].value;
    let password = document.getElementsByName("password")[0].value;
    let cpassword = document.getElementsByName("cpassword")[0].value;

    if (password !== cpassword) {
      alertify.error('Mật khẩu chưa khớp');
      e.preventDefault();
    }
  });

  function confirmDeactivate() {
    return confirm('Bạn có chắc chắn muốn khóa tài khoản? Bạn sẽ không thể đăng nhập lại sau khi khóa.');
  }

  <?php if (isset($_SESSION['message'])) { ?>
    alertify.set('notifier', 'position', 'top-right');
    alertify.success('<?= $_SESSION['message'] ?>');
  <?php unset($_SESSION['message']);
  } ?>
</script>

</html>