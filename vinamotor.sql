-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 15, 2025 at 04:11 AM
-- Server version: 8.0.30
-- PHP Version: 8.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vinamotor`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` mediumtext,
  `status` tinyint NOT NULL DEFAULT '0',
  `image` varchar(191) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `status`, `image`, `created_at`) VALUES
(1, 'Xe tay ga', 'xe-tay-ga-78', 'Xe tay ga', 0, '1741891429.png', '2025-03-13 18:43:49'),
(2, 'Xe tay côn', 'xe-tay-con', 'Xe tay côn', 0, '1741891462.png', '2025-03-13 18:44:22'),
(3, 'Xe thể thao', 'xe-the-thao-55', 'Xe thể thao', 0, '1741891486.png', '2025-03-13 18:44:46'),
(4, 'Xe số', 'xe-so-56', 'Xe số', 0, '1741891656.png', '2025-03-13 18:47:36');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `status` int NOT NULL DEFAULT '2',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `shipping_method` varchar(10) DEFAULT 'normal',
  `shipping_fee` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `status`, `created_at`, `shipping_method`, `shipping_fee`) VALUES
(1, 2, 4, '2025-03-13 19:11:09', 'express', 50000);

-- --------------------------------------------------------

--
-- Table structure for table `order_detail`
--

CREATE TABLE `order_detail` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `order_id` bigint DEFAULT NULL,
  `selling_price` int NOT NULL,
  `quantity` int NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `rate` tinyint DEFAULT NULL,
  `comment` mediumtext,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `order_detail`
--

INSERT INTO `order_detail` (`id`, `user_id`, `product_id`, `order_id`, `selling_price`, `quantity`, `status`, `rate`, `comment`, `created_at`) VALUES
(1, 2, 13, 1, 129000000, 1, 4, 5, 'Sản phẩm tốt', '2025-03-13 19:11:01'),
(2, 2, 4, NULL, 55300000, 1, 1, NULL, NULL, '2025-03-15 03:51:35');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `category_id` int NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `small_description` mediumtext NOT NULL,
  `description` mediumtext NOT NULL,
  `original_price` int NOT NULL,
  `selling_price` int NOT NULL,
  `image` varchar(191) NOT NULL,
  `qty` int NOT NULL,
  `status` tinyint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `slug`, `small_description`, `description`, `original_price`, `selling_price`, `image`, `qty`, `status`, `created_at`) VALUES
(1, 1, 'Grande phiên bản đặc biệt màu mới 2025', 'grande-phien-ban-dac-biet-mau-moi-2025-26', 'Loại: Blue Core Hybrid, làm mát bằng không khí, 4 thì, 2 van, xy-lanh đơn\r\nBố trí xi lanh: Xy lanh đơn\r\nDung tích xy lanh (CC): 124.9 cc\r\nĐường kính và hành trình piston: 52.4 x 57.9 mm\r\nTỷ số nén: 11.0 : 1\r\nCông suất tối đa: 6.05/6.500 kW/rpm\r\nMô men xoắn cực đại: 10.4 Nm (1.1 kgf.m)/5000 vòng/phút\r\nHệ thống khởi động: Khởi động điện\r\nHệ thống bôi trơn: Dầu bôi trơn', 'Với thiết kế thời trang, thanh lịch và thiết kế cốp xe siêu rộng 27 lít, Yamaha Grande còn là mẫu xe tay ga tiết kiệm xăng số 1 Việt Nam với mức tiêu thụ chỉ 1,66 lít/100km, theo số liệu thống kê và phân tích được Cục Đăng kiểm Việt Nam công bố, xác nhận bởi Báo Giao thông.', 60000000, 50980000, '1741891878.png', 10, 0, '2025-03-13 18:51:18'),
(2, 1, ' Janus phiên bản tiêu chuẩn hoàn toàn mới', '-janus-phien-ban-tieu-chuan-hoan-toan-moi-87', 'Loại: Blue Core Hybrid, làm mát bằng không khí, 4 thì, 2 van, xy-lanh đơn\r\nBố trí xi lanh: Xy lanh đơn\r\nDung tích xy lanh (CC): 124.9 cc\r\nĐường kính và hành trình piston: 52.4 x 57.9 mm\r\nTỷ số nén: 11.0 : 1\r\nCông suất tối đa: 6.05/6.500 kW/rpm\r\nMô men xoắn cực đại: 10.4 Nm (1.1 kgf.m)/5000 vòng/phút\r\nHệ thống khởi động: Khởi động điện\r\nHệ thống bôi trơn: Dầu bôi trơn', 'Xe máy Janus Yamaha 125 Hoàn toàn mới được nâng cấp toàn diện từ thiết kế đến tính năng. Thiết kế sắc nét thời thượng với thân xe vuốt gọn, vận hành mượt mà cùng động cơ Bluecore, Janus mới có mức tiêu thụ nhiên liệu chỉ 1,88 lít/100km.', 30000000, 29856000, '1741891961.png', 10, 0, '2025-03-13 18:52:41'),
(3, 1, 'Janus phiên bản tiêu chuẩn màu mới', 'janus-phien-ban-tieu-chuan-mau-moi-82', 'Loại: Blue Core Hybrid, làm mát bằng không khí, 4 thì, 2 van, xy-lanh đơn\r\nBố trí xi lanh: Xy lanh đơn\r\nDung tích xy lanh (CC): 124.9 cc\r\nĐường kính và hành trình piston: 52.4 x 57.9 mm\r\nTỷ số nén: 11.0 : 1\r\nCông suất tối đa: 6.05/6.500 kW/rpm\r\nMô men xoắn cực đại: 10.4 Nm (1.1 kgf.m)/5000 vòng/phút\r\nHệ thống khởi động: Khởi động điện\r\nHệ thống bôi trơn: Dầu bôi trơn', 'Xe máy Janus Yamaha có thiết kế trẻ trung cùng khả năng vận hành mượt mà với mức giá rất phải chăng cùng mức tiêu thụ chỉ 1,87 lít/100km, động cơ Blue Core, hệ thống Stop & Start.', 30000000, 28956000, '1741892017.png', 10, 0, '2025-03-13 18:53:37'),
(4, 1, ' NVX 155 VVA ABS', '-nvx-155-vva-abs-64', 'Loại: Blue Core Hybrid, làm mát bằng không khí, 4 thì, 2 van, xy-lanh đơn\r\nBố trí xi lanh: Xy lanh đơn\r\nDung tích xy lanh (CC): 124.9 cc\r\nĐường kính và hành trình piston: 52.4 x 57.9 mm\r\nTỷ số nén: 11.0 : 1\r\nCông suất tối đa: 6.05/6.500 kW/rpm\r\nMô men xoắn cực đại: 10.4 Nm (1.1 kgf.m)/5000 vòng/phút\r\nHệ thống khởi động: Khởi động điện\r\nHệ thống bôi trơn: Dầu bôi trơn', 'Thiết kế khỏe khoắn, mang đậm nét thể thao với hiệu suất vận hành mạnh mẽ. Phiên bản mới nhất NVX 155 VVA thế hệ II được trang bị hàng loạt các tính năng hiện đại như: ứng dụng Y-Connect - ứng dụng kết nối xe và điện thoại, động cơ BlueCore 155cc VVA, phanh ABS, khóa thông minh SmartKey, hệ thống ngắt động cơ tạm thời Stop & Start System (SSS), cốp xe rộng lên tới 25 lít,...', 60000000, 55300000, '1741892090.png', 10, 0, '2025-03-13 18:54:50'),
(5, 4, 'Jupiter FI màu mới', 'jupiter-fi-mau-moi-33', 'Loại: 4 kỳ, 2 van, SOHC, làm mát bằng không khí tự nhiên\r\nBố trí xi lanh: Xy lanh đơn\r\nDung tích xy lanh (CC): 113.7\r\nĐường kính và hành trình piston: 50,0mm x 57,9mm\r\nTỷ số nén: 9,3:1\r\nCông suất tối đa: 7,4 kW / 7.750 vòng/phút\r\nMô men xoắn cực đại: 9,9 N.m (0,99 kgf.m) / 6.500 vòng/phút\r\nHệ thống khởi động: Điện / Cần khởi động\r\nHệ thống bôi trơn: Các-te ướt\r\nDung tích dầu máy: 1,0 lít\r\nDung tích bình xăng: 4,1 lít', 'Xe Jupiter FI được đánh giá và công nhận là mẫu xe số tiết kiệm xăng nằm trong top đầu Việt Nam với mức tiêu thụ chỉ 1,643 lít/100km.', 30000000, 28500000, '1741892241.png', 10, 0, '2025-03-13 18:57:21'),
(6, 4, 'Jupiter Finn phiên bản tiêu chuẩn màu mới', 'jupiter-finn-phien-ban-tieu-chuan-mau-moi-23', 'Loại: 4 kỳ, 2 van, SOHC, làm mát bằng không khí tự nhiên\r\nBố trí xi lanh: Xy lanh đơn\r\nDung tích xy lanh (CC): 113.7\r\nĐường kính và hành trình piston: 50,0mm x 57,9mm\r\nTỷ số nén: 9,3:1\r\nCông suất tối đa: 7,4 kW / 7.750 vòng/phút\r\nMô men xoắn cực đại: 9,9 N.m (0,99 kgf.m) / 6.500 vòng/phút\r\nHệ thống khởi động: Điện / Cần khởi động\r\nHệ thống bôi trơn: Các-te ướt\r\nDung tích dầu máy: 1,0 lít\r\nDung tích bình xăng: 4,1 lít', 'Với thông điệp “Khởi đầu mới cho hành trình yêu thương”, dòng xe Yamaha Jupiter Finn là người bạn đồng hành đáng tin cậy cho mọi gia đình với mức giá hợp lý, đáp ứng được nhiều nhu cầu đi lại, dễ dàng di chuyển hằng ngày. Đặc biệt, xe được trang bị hệ thống phanh xe kết hợp (UBS) giúp kiểm soát phanh tốt hơn trong các tình huống khẩn cấp, tạo sự yên tâm trên mọi cung đường.', 30000000, 27800000, '1741892286.png', 10, 0, '2025-03-13 18:58:06'),
(7, 4, 'Sirius RC phiên bản vành đúc màu mới', 'sirius-rc-phien-ban-vanh-duc-mau-moi-79', 'Loại: 4 kỳ, 2 van, SOHC, làm mát bằng không khí tự nhiên\r\nBố trí xi lanh: Xy lanh đơn\r\nDung tích xy lanh (CC): 113.7\r\nĐường kính và hành trình piston: 50,0mm x 57,9mm\r\nTỷ số nén: 9,3:1\r\nCông suất tối đa: 7,4 kW / 7.750 vòng/phút\r\nMô men xoắn cực đại: 9,9 N.m (0,99 kgf.m) / 6.500 vòng/phút\r\nHệ thống khởi động: Điện / Cần khởi động\r\nHệ thống bôi trơn: Các-te ướt\r\nDung tích dầu máy: 1,0 lít\r\nDung tích bình xăng: 4,1 lít', 'Yamaha Sirius là mẫu xe số bền bỉ đã có mặt tại thị trường Việt Nam từ hơn 20 năm trước. Cho đến nay, dòng xe này đã được cải tiến đáng kể về thiết kế và động cơ. Hiện xe có 3 phiên bản: phanh cơ, phanh đĩa và vành đúc.', 25000000, 21900000, '1741892324.png', 10, 0, '2025-03-13 18:58:44'),
(8, 4, ' Sirius FI phiên bản vành đúc', '-sirius-fi-phien-ban-vanh-duc-75', 'Loại: 4 kỳ, 2 van, SOHC, làm mát bằng không khí tự nhiên\r\nBố trí xi lanh: Xy lanh đơn\r\nDung tích xy lanh (CC): 113.7\r\nĐường kính và hành trình piston: 50,0mm x 57,9mm\r\nTỷ số nén: 9,3:1\r\nCông suất tối đa: 7,4 kW / 7.750 vòng/phút\r\nMô men xoắn cực đại: 9,9 N.m (0,99 kgf.m) / 6.500 vòng/phút\r\nHệ thống khởi động: Điện / Cần khởi động\r\nHệ thống bôi trơn: Các-te ướt\r\nDung tích dầu máy: 1,0 lít\r\nDung tích bình xăng: 4,1 lít', 'Nhờ trang bị hệ thống phun xăng điện tử FI, xe Sirius FI có mức tiêu thụ nhiên liệu cực kì tiết kiệm chỉ 1,65 lít/100km.', 25000000, 23500000, '1741892372.png', 10, 0, '2025-03-13 18:59:32'),
(9, 2, 'PG-1 phiên bản màu mới', 'pg-1-phien-ban-mau-moi-82', 'Loại: 4 kỳ, 2 van, SOHC, làm mát bằng không khí\r\nBố trí xi lanh: Xi lanh đơn\r\nDung tích xy lanh (CC): 113.7 cm³\r\nĐường kính và hành trình piston: 50.0 x 57.9 mm\r\nTỷ số nén: 9.3:1\r\nCông suất tối đa: 6.6 kW / 7.000 vòng/phút\r\nMô men xoắn cực đại: 9.5 Nm / 5.500 vòng/phút\r\nHệ thống khởi động: Khởi động điện\r\nHệ thống bôi trơn: Cacte ướt\r\nDung tích dầu máy: 0.8 L\r\nDung tích bình xăng: 5.1 L', 'Yamaha PG-1 là sự kết hợp từ sự vận hành dễ dàng của một chiếc xe đô thị cùng khả năng off-road của một mẫu xe việt dã. Chiếc xe này vừa mang lại sự tiện lợi khi di chuyển trong nội đô, vừa có hiệu suất đủ tốt để đáp ứng những hành trình xa, mang lại cảm hứng lái xe khác biệt.', 35000000, 32000000, '1741892485.png', 10, 0, '2025-03-13 19:01:25'),
(10, 2, 'Exciter 155 VVA phiên bản cao cấp', 'exciter-155-vva-phien-ban-cao-cap-63', 'Loại: 4 kỳ, 2 van, SOHC, làm mát bằng không khí\r\nBố trí xi lanh: Xi lanh đơn\r\nDung tích xy lanh (CC): 113.7 cm³\r\nĐường kính và hành trình piston: 50.0 x 57.9 mm\r\nTỷ số nén: 9.3:1\r\nCông suất tối đa: 6.6 kW / 7.000 vòng/phút\r\nMô men xoắn cực đại: 9.5 Nm / 5.500 vòng/phút\r\nHệ thống khởi động: Khởi động điện\r\nHệ thống bôi trơn: Cacte ướt\r\nDung tích dầu máy: 0.8 L\r\nDung tích bình xăng: 5.1 L', 'Yamaha Exciter là mẫu xe côn tay được ưa chuộng nhất tại thị trường Việt Nam. Bên cạnh phiên bản Exciter 150 rất được yêu thích, Yamaha Motor Việt Nam phát triển dòng Exciter 155 VVA với nhiều chi tiết mới dựa trên các công nghệ đang được áp dụng trên siêu xe thể thao YZF-R1. Vừa mạnh mẽ như xe phân khối lớn, Exciter vừa đảm bảo tính ổn định và linh hoạt khi vận hành hàng ngày của một chiếc xe thể thao phân khối nhỏ.', 55000000, 50600000, '1741892539.png', 10, 0, '2025-03-13 19:02:19'),
(11, 3, 'YZF-R15M hoàn toàn mới', 'yzf-r15m-hoan-toan-moi-19', 'Loại: 4 thì, 4 van, SOHC, 1 xy-lanh, làm mát bằng dung dịch, van biến thiên VVA\r\nBố trí xi lanh: Xy-lanh đơn\r\nDung tích xy lanh (CC): 155.1\r\nĐường kính và hành trình piston: 58.0 x 58.7 mm\r\nTỷ số nén: 11.6:1\r\nCông suất tối đa: 14.2 kW (19.3 PS) / 10.000 vòng/phút\r\nMô men xoắn cực đại: 14.7 N.m (1.5 kgf.m) / 8.500 vòng/phút\r\nHệ thống khởi động: Điện\r\nHệ thống bôi trơn: Cácte ướt\r\nMức tiêu thụ nhiên liệu (l/100km): 2.30', 'Yamaha YZF-R15 là mẫu xe thể thao dung tích xy lanh 155cc, sở hữu những đường nét thừa hưởng DNA từ \"đàn anh\" YZF-R1. Xe được trang bị nhiều công nghệ hiện đại, hệ thống phun xăng điện tử và van biến thiên VVA giúp xe vừa tiết kiệm nhiên liệu, vừa phát huy được khả năng vận hành bền bỉ, đem lại các trải nghiệm phấn khích cho các tay lái.', 89000000, 86000000, '1741892657.png', 10, 0, '2025-03-13 19:04:17'),
(12, 3, 'YZF-R3 2024', 'yzf-r3-2024-52', 'Loại: 4 thì, 4 van, SOHC, 1 xy-lanh, làm mát bằng dung dịch, van biến thiên VVA\r\nBố trí xi lanh: Xy-lanh đơn\r\nDung tích xy lanh (CC): 155.1\r\nĐường kính và hành trình piston: 58.0 x 58.7 mm\r\nTỷ số nén: 11.6:1\r\nCông suất tối đa: 14.2 kW (19.3 PS) / 10.000 vòng/phút\r\nMô men xoắn cực đại: 14.7 N.m (1.5 kgf.m) / 8.500 vòng/phút\r\nHệ thống khởi động: Điện\r\nHệ thống bôi trơn: Cácte ướt\r\nMức tiêu thụ nhiên liệu (l/100km): 2.30', 'Yamaha YZF R3 là mẫu xe phân khối lớn được thiết kế dựa trên cảm hứng từ huyền thoại YZR-M1 của giải đua MotoGP danh tiếng. Mẫu xe moto này được trang bị động cơ 4 thì, xi-lanh đôi, 321 phân khối, làm mát bằng dung dịch, công suất 30.9 kW tại 10.750 vòng/phút và mô-men xoắn cực đại 29,6 Nm tại 9.000 vòng/phút, tích hợp phun xăng điện tử.', 135000000, 132000000, '1741892707.png', 10, 0, '2025-03-13 19:05:07'),
(13, 3, 'MT-03', 'mt-03-69', 'Loại: 4 thì, 4 van, SOHC, 1 xy-lanh, làm mát bằng dung dịch, van biến thiên VVA\r\nBố trí xi lanh: Xy-lanh đơn\r\nDung tích xy lanh (CC): 155.1\r\nĐường kính và hành trình piston: 58.0 x 58.7 mm\r\nTỷ số nén: 11.6:1\r\nCông suất tối đa: 14.2 kW (19.3 PS) / 10.000 vòng/phút\r\nMô men xoắn cực đại: 14.7 N.m (1.5 kgf.m) / 8.500 vòng/phút\r\nHệ thống khởi động: Điện\r\nHệ thống bôi trơn: Cácte ướt\r\nMức tiêu thụ nhiên liệu (l/100km): 2.30', '\r\nMT-03\r\nGiá bán lẻ đề xuất 129.000.000 VNĐ\r\n\r\nMàu sắc: Xám\r\n\r\nYamaha MT-03 là mẫu xe thể thao côn tay được cải tiến và phát triển dựa theo hình mẫu của “Kỵ sĩ bóng đêm”, với thiết kế bụi bặm đường phố, nổi bật & ấn tượng đặc trưng của naked bike. Đặc biệt, xe có khả năng vận hành ấn tượng, sử dụng linh động ngay cả trong điều kiện giao thông đô thị chật chội.', 130000000, 129000000, '1741892820.png', 9, 0, '2025-03-13 19:07:00'),
(14, 3, 'MT-15', 'mt-15-60', 'Loại: 4 thì, 4 van, SOHC, 1 xy-lanh, làm mát bằng dung dịch, van biến thiên VVA\r\nBố trí xi lanh: Xy-lanh đơn\r\nDung tích xy lanh (CC): 155.1\r\nĐường kính và hành trình piston: 58.0 x 58.7 mm\r\nTỷ số nén: 11.6:1\r\nCông suất tối đa: 14.2 kW (19.3 PS) / 10.000 vòng/phút\r\nMô men xoắn cực đại: 14.7 N.m (1.5 kgf.m) / 8.500 vòng/phút\r\nHệ thống khởi động: Điện\r\nHệ thống bôi trơn: Cácte ướt\r\nMức tiêu thụ nhiên liệu (l/100km): 2.30', 'Yamaha MT-15 có thiết kế ấn tượng mang dáng vóc của \"chiến binh\" mạnh mẽ, kế thừa tinh hoa của thế hệ trước. Xe sở hữu phuộc trước up-side-down và phuộc monoshock phía sau, động cơ SOHC 155 cc, van biến thiên VVA đi cùng hệ thống làm mát bằng chất lỏng.', 70000000, 69000000, '1741892882.png', 10, 0, '2025-03-13 19:08:02'),
(15, 2, 'XS155R', 'xs155r-65', 'Loại: 4 kỳ, 2 van, SOHC, làm mát bằng không khí\r\nBố trí xi lanh: Xi lanh đơn\r\nDung tích xy lanh (CC): 113.7 cm³\r\nĐường kính và hành trình piston: 50.0 x 57.9 mm\r\nTỷ số nén: 9.3:1\r\nCông suất tối đa: 6.6 kW / 7.000 vòng/phút\r\nMô men xoắn cực đại: 9.5 Nm / 5.500 vòng/phút\r\nHệ thống khởi động: Khởi động điện\r\nHệ thống bôi trơn: Cacte ướt\r\nDung tích dầu máy: 0.8 L\r\nDung tích bình xăng: 5.1 L', 'Yamaha XS155R được Yamaha Motor Việt Nam phân phối chính hãng từ đầu năm 2023. Đây là dòng xe rất đáng được mong chờ nhờ thiết kế cổ điển đẹp mắt nhưng vẫn sở hữu khối động cơ mạnh mẽ. Với thông điệp “Feel your ride: Lái cảm xúc, Chất đam mê”, XS155R được kỳ vọng mang đến những trải nghiệm lái phấn khích và thú vị cho khách hàng.', 80000000, 77000000, '1741892939.png', 10, 0, '2025-03-13 19:08:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(191) DEFAULT NULL,
  `password` varchar(191) NOT NULL,
  `role_as` tinyint NOT NULL DEFAULT '0',
  `creat_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `address`, `password`, `role_as`, `creat_at`, `status`) VALUES
(1, 'Admin', 'admin@gmail.com', '0123456789', 'Hà Nội', '$2y$10$xdjSZRMIoP0YFO0YwU.iQ.skU42QD41hwyn6h4XXGlJB0rCmkgnvO', 1, '2025-01-25 13:01:13', 'active'),
(2, 'Nguyễn Văn A', 'user@gmail.com', '0123456789', 'Hà Nội', '$2y$10$xdjSZRMIoP0YFO0YwU.iQ.skU42QD41hwyn6h4XXGlJB0rCmkgnvO', 0, '2025-01-25 13:02:43', 'active'),
(3, 'Nguyễn Văn B', 'user2@gmail.com', '0123456789', 'Hà Nội', '$2y$10$xdjSZRMIoP0YFO0YwU.iQ.skU42QD41hwyn6h4XXGlJB0rCmkgnvO', 0, '2025-01-28 13:03:49', 'active');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `order_detail_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
