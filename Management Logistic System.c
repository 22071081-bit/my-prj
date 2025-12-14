#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <ctype.h>

#define MAX_USERS 100
#define MAX_ORDERS 500
#define MAX_ITEMS 1000
#define MAX_VEHICLES 50
#define MAX_ROUTES 100
#define MAX_NAME_LEN 100
#define MAX_ADDRESS_LEN 200

// Cấu trúc dữ liệu
typedef struct {
    char username[50];
    char password[50];
    char role[20]; // "admin", "manager", "employee"
} User;

typedef struct {
    int item_id;
    char name[MAX_NAME_LEN];
    int quantity;
    float price;
    char category[50];
    char location[50];
} InventoryItem;

typedef struct {
    int order_id;
    char customer_name[MAX_NAME_LEN];
    char customer_address[MAX_ADDRESS_LEN];
    char customer_phone[20];
    int item_id;
    int quantity;
    float total_amount;
    char status[20]; // "pending", "processing", "shipped", "delivered"
    char order_date[20];
    int assigned_vehicle;
} Order;

typedef struct {
    int vehicle_id;
    char type[30]; // "truck", "van", "motorcycle"
    char license_plate[20];
    float capacity;
    float current_load;
    char status[20]; // "available", "busy", "maintenance"
    char driver_name[MAX_NAME_LEN];
} Vehicle;

typedef struct {
    int route_id;
    char start_location[MAX_ADDRESS_LEN];
    char end_location[MAX_ADDRESS_LEN];
    float distance;
    float estimated_time;
    int vehicle_id;
    char status[20]; // "planned", "in_progress", "completed"
} Route;

// Biến toàn cục
User users[MAX_USERS];
InventoryItem inventory[MAX_ITEMS];
Order orders[MAX_ORDERS];
Vehicle vehicles[MAX_VEHICLES];
Route routes[MAX_ROUTES];

int user_count = 0;
int inventory_count = 0;
int order_count = 0;
int vehicle_count = 0;
int route_count = 0;

User current_user;
int is_logged_in = 0;

// Hàm tiện ích
void clear_screen() {
    #ifdef _WIN32
        system("cls");
    #else
        system("clear");
    #endif
}

void pause_screen() {
    printf("\nNhan Enter de tiep tuc...");
    getchar();
    getchar();
}

void display_logo() {
    printf("\n");
    printf("  =================================================================\n");
    printf("  ||                                                             ||\n");
    printf("  ||    ██╗      ██████╗  ██████╗ ██╗███████╗████████╗██╗ ██████╗||\n");
    printf("  ||    ██║     ██╔═══██╗██╔════╝ ██║██╔════╝╚══██╔══╝██║██╔════╝||\n");
    printf("  ||    ██║     ██║   ██║██║  ███╗██║███████╗   ██║   ██║██║     ||\n");
    printf("  ||    ██║     ██║   ██║██║   ██║██║╚════██║   ██║   ██║██║     ||\n");
    printf("  ||    ███████╗╚██████╔╝╚██████╔╝██║███████║   ██║   ██║╚██████╗||\n");
    printf("  ||    ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚══════╝   ╚═╝   ╚═╝ ╚═════╝||\n");
    printf("  ||                                                             ||\n");
    printf("  ||              MANAGEMENT SYSTEM - Version 1.0               ||\n");
    printf("  ||                   Developed by Student                      ||\n");
    printf("  =================================================================\n");
    printf("\n");
}

// Hàm đọc dữ liệu từ file CSV (mô phỏng đọc Excel)
void load_sample_data() {
    // Dữ liệu mẫu cho users
    strcpy(users[0].username, "admin");
    strcpy(users[0].password, "admin123");
    strcpy(users[0].role, "admin");
    
    strcpy(users[1].username, "manager");
    strcpy(users[1].password, "manager123");
    strcpy(users[1].role, "manager");
    
    strcpy(users[2].username, "employee");
    strcpy(users[2].password, "emp123");
    strcpy(users[2].role, "employee");
    
    user_count = 3;
    
    // Dữ liệu mẫu cho kho hàng
    inventory[0].item_id = 1001;
    strcpy(inventory[0].name, "Laptop Dell XPS");
    inventory[0].quantity = 50;
    inventory[0].price = 1200.0;
    strcpy(inventory[0].category, "Electronics");
    strcpy(inventory[0].location, "Kho A1");
    
    inventory[1].item_id = 1002;
    strcpy(inventory[1].name, "iPhone 15 Pro");
    inventory[1].quantity = 30;
    inventory[1].price = 999.0;
    strcpy(inventory[1].category, "Electronics");
    strcpy(inventory[1].location, "Kho A2");
    
    inventory[2].item_id = 1003;
    strcpy(inventory[2].name, "Samsung TV 55 inch");
    inventory[2].quantity = 25;
    inventory[2].price = 800.0;
    strcpy(inventory[2].category, "Electronics");
    strcpy(inventory[2].location, "Kho B1");
    
    inventory_count = 3;
    
    // Dữ liệu mẫu cho phương tiện
    vehicles[0].vehicle_id = 2001;
    strcpy(vehicles[0].type, "Truck");
    strcpy(vehicles[0].license_plate, "29A-12345");
    vehicles[0].capacity = 5000.0;
    vehicles[0].current_load = 0.0;
    strcpy(vehicles[0].status, "available");
    strcpy(vehicles[0].driver_name, "Nguyen Van A");
    
    vehicles[1].vehicle_id = 2002;
    strcpy(vehicles[1].type, "Van");
    strcpy(vehicles[1].license_plate, "30B-67890");
    vehicles[1].capacity = 2000.0;
    vehicles[1].current_load = 0.0;
    strcpy(vehicles[1].status, "available");
    strcpy(vehicles[1].driver_name, "Tran Van B");
    
    vehicle_count = 2;
    
    // Dữ liệu mẫu cho đơn hàng
    orders[0].order_id = 3001;
    strcpy(orders[0].customer_name, "Nguyen Thi C");
    strcpy(orders[0].customer_address, "123 Nguyen Trai, Ha Noi");
    strcpy(orders[0].customer_phone, "0901234567");
    orders[0].item_id = 1001;
    orders[0].quantity = 2;
    orders[0].total_amount = 2400.0;
    strcpy(orders[0].status, "pending");
    strcpy(orders[0].order_date, "2024-06-15");
    orders[0].assigned_vehicle = 0;
    
    order_count = 1;
}

// Hàm xác thực đăng nhập
int authenticate_user(char* username, char* password) {
    for (int i = 0; i < user_count; i++) {
        if (strcmp(users[i].username, username) == 0 && 
            strcmp(users[i].password, password) == 0) {
            current_user = users[i];
            is_logged_in = 1;
            return 1;
        }
    }
    return 0;
}

// Hàm đăng nhập
void login() {
    char username[50], password[50];
    
    clear_screen();
    display_logo();
    
    printf("=== DANG NHAP HE THONG ===\n\n");
    printf("Ten dang nhap: ");
    scanf("%s", username);
    printf("Mat khau: ");
    scanf("%s", password);
    
    if (authenticate_user(username, password)) {
        printf("\nDang nhap thanh cong! Chao mung %s (%s)\n", 
               current_user.username, current_user.role);
        pause_screen();
    } else {
        printf("\nTen dang nhap hoac mat khau khong dung!\n");
        pause_screen();
    }
}

// Quản lý đơn hàng
void display_orders() {
    clear_screen();
    printf("=== DANH SACH DON HANG ===\n\n");
    printf("%-8s %-20s %-15s %-10s %-12s %-15s %-12s\n", 
           "ID", "Khach hang", "SDT", "Ma SP", "So luong", "Tong tien", "Trang thai");
    printf("--------------------------------------------------------------------------------\n");
    
    for (int i = 0; i < order_count; i++) {
        printf("%-8d %-20s %-15s %-10d %-12d %-15.2f %-12s\n",
               orders[i].order_id,
               orders[i].customer_name,
               orders[i].customer_phone,
               orders[i].item_id,
               orders[i].quantity,
               orders[i].total_amount,
               orders[i].status);
    }
    pause_screen();
}

void add_order() {
    clear_screen();
    printf("=== THEM DON HANG MOI ===\n\n");
    
    Order new_order;
    new_order.order_id = 3000 + order_count + 1;
    
    printf("Ten khach hang: ");
    getchar(); // Clear buffer
    fgets(new_order.customer_name, MAX_NAME_LEN, stdin);
    new_order.customer_name[strcspn(new_order.customer_name, "\n")] = 0;
    
    printf("Dia chi: ");
    fgets(new_order.customer_address, MAX_ADDRESS_LEN, stdin);
    new_order.customer_address[strcspn(new_order.customer_address, "\n")] = 0;
    
    printf("So dien thoai: ");
    scanf("%s", new_order.customer_phone);
    
    printf("Ma san pham: ");
    scanf("%d", &new_order.item_id);
    
    printf("So luong: ");
    scanf("%d", &new_order.quantity);
    
    // Tìm giá sản phẩm
    float price = 0;
    for (int i = 0; i < inventory_count; i++) {
        if (inventory[i].item_id == new_order.item_id) {
            price = inventory[i].price;
            break;
        }
    }
    
    new_order.total_amount = price * new_order.quantity;
    strcpy(new_order.status, "pending");
    strcpy(new_order.order_date, "2024-06-17");
    new_order.assigned_vehicle = -1;
    
    orders[order_count] = new_order;
    order_count++;
    
    printf("\nDon hang da duoc them thanh cong! ID: %d\n", new_order.order_id);
    pause_screen();
}

void update_order_status() {
    clear_screen();
    printf("=== CAP NHAT TRANG THAI DON HANG ===\n\n");
    
    int order_id;
    printf("Nhap ID don hang: ");
    scanf("%d", &order_id);
    
    int found = -1;
    for (int i = 0; i < order_count; i++) {
        if (orders[i].order_id == order_id) {
            found = i;
            break;
        }
    }
    
    if (found == -1) {
        printf("Khong tim thay don hang!\n");
        pause_screen();
        return;
    }
    
    printf("Don hang hien tai: %s\n", orders[found].status);
    printf("1. Pending\n2. Processing\n3. Shipped\n4. Delivered\n");
    printf("Chon trang thai moi: ");
    
    int choice;
    scanf("%d", &choice);
    
    switch (choice) {
        case 1: strcpy(orders[found].status, "pending"); break;
        case 2: strcpy(orders[found].status, "processing"); break;
        case 3: strcpy(orders[found].status, "shipped"); break;
        case 4: strcpy(orders[found].status, "delivered"); break;
        default: printf("Lua chon khong hop le!\n"); pause_screen(); return;
    }
    
    printf("Cap nhat trang thai thanh cong!\n");
    pause_screen();
}

void order_management_menu() {
    int choice;
    do {
        clear_screen();
        printf("=== QUAN LY DON HANG ===\n\n");
        printf("1. Xem danh sach don hang\n");
        printf("2. Them don hang moi\n");
        printf("3. Cap nhat trang thai don hang\n");
        printf("0. Quay lai\n");
        printf("\nLua chon cua ban: ");
        scanf("%d", &choice);
        
        switch (choice) {
            case 1: display_orders(); break;
            case 2: add_order(); break;
            case 3: update_order_status(); break;
            case 0: break;
            default: 
                printf("Lua chon khong hop le!\n"); 
                pause_screen(); 
                break;
        }
    } while (choice != 0);
}

// Quản lý kho
void display_inventory() {
    clear_screen();
    printf("=== DANH SACH TON KHO ===\n\n");
    printf("%-8s %-25s %-10s %-12s %-15s %-15s\n", 
           "Ma SP", "Ten san pham", "So luong", "Gia", "Danh muc", "Vi tri");
    printf("---------------------------------------------------------------------------------\n");
    
    for (int i = 0; i < inventory_count; i++) {
        printf("%-8d %-25s %-10d %-12.2f %-15s %-15s\n",
               inventory[i].item_id,
               inventory[i].name,
               inventory[i].quantity,
               inventory[i].price,
               inventory[i].category,
               inventory[i].location);
    }
    pause_screen();
}

void add_inventory_item() {
    clear_screen();
    printf("=== THEM SAN PHAM VAO KHO ===\n\n");
    
    InventoryItem new_item;
    new_item.item_id = 1000 + inventory_count + 1;
    
    printf("Ten san pham: ");
    getchar(); // Clear buffer
    fgets(new_item.name, MAX_NAME_LEN, stdin);
    new_item.name[strcspn(new_item.name, "\n")] = 0;
    
    printf("So luong: ");
    scanf("%d", &new_item.quantity);
    
    printf("Gia: ");
    scanf("%f", &new_item.price);
    
    printf("Danh muc: ");
    scanf("%s", new_item.category);
    
    printf("Vi tri kho: ");
    scanf("%s", new_item.location);
    
    inventory[inventory_count] = new_item;
    inventory_count++;
    
    printf("\nSan pham da duoc them vao kho! Ma SP: %d\n", new_item.item_id);
    pause_screen();
}

void update_inventory() {
    clear_screen();
    printf("=== CAP NHAT TON KHO ===\n\n");
    
    int item_id;
    printf("Nhap ma san pham: ");
    scanf("%d", &item_id);
    
    int found = -1;
    for (int i = 0; i < inventory_count; i++) {
        if (inventory[i].item_id == item_id) {
            found = i;
            break;
        }
    }
    
    if (found == -1) {
        printf("Khong tim thay san pham!\n");
        pause_screen();
        return;
    }
    
    printf("San pham: %s\n", inventory[found].name);
    printf("So luong hien tai: %d\n", inventory[found].quantity);
    printf("Nhap so luong moi: ");
    scanf("%d", &inventory[found].quantity);
    
    printf("Cap nhat thanh cong!\n");
    pause_screen();
}

void inventory_management_menu() {
    int choice;
    do {
        clear_screen();
        printf("=== QUAN LY KHO ===\n\n");
        printf("1. Xem danh sach ton kho\n");
        printf("2. Them san pham moi\n");
        printf("3. Cap nhat so luong ton kho\n");
        printf("0. Quay lai\n");
        printf("\nLua chon cua ban: ");
        scanf("%d", &choice);
        
        switch (choice) {
            case 1: display_inventory(); break;
            case 2: add_inventory_item(); break;
            case 3: update_inventory(); break;
            case 0: break;
            default: 
                printf("Lua chon khong hop le!\n"); 
                pause_screen(); 
                break;
        }
    } while (choice != 0);
}

// Quản lý phương tiện
void display_vehicles() {
    clear_screen();
    printf("=== DANH SACH PHUONG TIEN ===\n\n");
    printf("%-8s %-12s %-15s %-12s %-12s %-12s %-20s\n", 
           "Ma PT", "Loai", "Bien so", "Tai trong", "Tai hien", "Trang thai", "Tai xe");
    printf("-------------------------------------------------------------------------------------\n");
    
    for (int i = 0; i < vehicle_count; i++) {
        printf("%-8d %-12s %-15s %-12.1f %-12.1f %-12s %-20s\n",
               vehicles[i].vehicle_id,
               vehicles[i].type,
               vehicles[i].license_plate,
               vehicles[i].capacity,
               vehicles[i].current_load,
               vehicles[i].status,
               vehicles[i].driver_name);
    }
    pause_screen();
}

void add_vehicle() {
    clear_screen();
    printf("=== THEM PHUONG TIEN MOI ===\n\n");
    
    Vehicle new_vehicle;
    new_vehicle.vehicle_id = 2000 + vehicle_count + 1;
    
    printf("Loai phuong tien: ");
    scanf("%s", new_vehicle.type);
    
    printf("Bien so xe: ");
    scanf("%s", new_vehicle.license_plate);
    
    printf("Tai trong toi da (kg): ");
    scanf("%f", &new_vehicle.capacity);
    
    new_vehicle.current_load = 0.0;
    strcpy(new_vehicle.status, "available");
    
    printf("Ten tai xe: ");
    getchar(); // Clear buffer
    fgets(new_vehicle.driver_name, MAX_NAME_LEN, stdin);
    new_vehicle.driver_name[strcspn(new_vehicle.driver_name, "\n")] = 0;
    
    vehicles[vehicle_count] = new_vehicle;
    vehicle_count++;
    
    printf("\nPhuong tien da duoc them! Ma PT: %d\n", new_vehicle.vehicle_id);
    pause_screen();
}

void update_vehicle_status() {
    clear_screen();
    printf("=== CAP NHAT TRANG THAI PHUONG TIEN ===\n\n");
    
    int vehicle_id;
    printf("Nhap ma phuong tien: ");
    scanf("%d", &vehicle_id);
    
    int found = -1;
    for (int i = 0; i < vehicle_count; i++) {
        if (vehicles[i].vehicle_id == vehicle_id) {
            found = i;
            break;
        }
    }
    
    if (found == -1) {
        printf("Khong tim thay phuong tien!\n");
        pause_screen();
        return;
    }
    
    printf("Phuong tien: %s - %s\n", vehicles[found].type, vehicles[found].license_plate);
    printf("Trang thai hien tai: %s\n", vehicles[found].status);
    printf("1. Available\n2. Busy\n3. Maintenance\n");
    printf("Chon trang thai moi: ");
    
    int choice;
    scanf("%d", &choice);
    
    switch (choice) {
        case 1: strcpy(vehicles[found].status, "available"); break;
        case 2: strcpy(vehicles[found].status, "busy"); break;
        case 3: strcpy(vehicles[found].status, "maintenance"); break;
        default: printf("Lua chon khong hop le!\n"); pause_screen(); return;
    }
    
    printf("Cap nhat trang thai thanh cong!\n");
    pause_screen();
}

void vehicle_management_menu() {
    int choice;
    do {
        clear_screen();
        printf("=== QUAN LY PHUONG TIEN ===\n\n");
        printf("1. Xem danh sach phuong tien\n");
        printf("2. Them phuong tien moi\n");
        printf("3. Cap nhat trang thai phuong tien\n");
        printf("0. Quay lai\n");
        printf("\nLua chon cua ban: ");
        scanf("%d", &choice);
        
        switch (choice) {
            case 1: display_vehicles(); break;
            case 2: add_vehicle(); break;
            case 3: update_vehicle_status(); break;
            case 0: break;
            default: 
                printf("Lua chon khong hop le!\n"); 
                pause_screen(); 
                break;
        }
    } while (choice != 0);
}

// Quản lý tuyến đường và giao hàng
void display_routes() {
    clear_screen();
    printf("=== DANH SACH TUYEN DUONG ===\n\n");
    printf("%-8s %-25s %-25s %-12s %-12s %-8s %-12s\n", 
           "Ma TD", "Diem bat dau", "Diem ket thuc", "Khoang cach", "Thoi gian", "Ma PT", "Trang thai");
    printf("-----------------------------------------------------------------------------------------------\n");
    
    for (int i = 0; i < route_count; i++) {
        printf("%-8d %-25s %-25s %-12.1f %-12.1f %-8d %-12s\n",
               routes[i].route_id,
               routes[i].start_location,
               routes[i].end_location,
               routes[i].distance,
               routes[i].estimated_time,
               routes[i].vehicle_id,
               routes[i].status);
    }
    pause_screen();
}

void create_delivery_route() {
    clear_screen();
    printf("=== TAO TUYEN DUONG GIAO HANG ===\n\n");
    
    Route new_route;
    new_route.route_id = 4000 + route_count + 1;
    
    printf("Diem bat dau: ");
    getchar(); // Clear buffer
    fgets(new_route.start_location, MAX_ADDRESS_LEN, stdin);
    new_route.start_location[strcspn(new_route.start_location, "\n")] = 0;
    
    printf("Diem ket thuc: ");
    fgets(new_route.end_location, MAX_ADDRESS_LEN, stdin);
    new_route.end_location[strcspn(new_route.end_location, "\n")] = 0;
    
    printf("Khoang cach (km): ");
    scanf("%f", &new_route.distance);
    
    printf("Thoi gian uoc tinh (gio): ");
    scanf("%f", &new_route.estimated_time);
    
    // Hiển thị phương tiện có sẵn
    printf("\nPhuong tien co san:\n");
    for (int i = 0; i < vehicle_count; i++) {
        if (strcmp(vehicles[i].status, "available") == 0) {
            printf("%d. %s - %s (Tai xe: %s)\n", 
                   vehicles[i].vehicle_id, 
                   vehicles[i].type, 
                   vehicles[i].license_plate,
                   vehicles[i].driver_name);
        }
    }
    
    printf("Chon ma phuong tien: ");
    scanf("%d", &new_route.vehicle_id);
    
    strcpy(new_route.status, "planned");
    
    routes[route_count] = new_route;
    route_count++;
    
    printf("\nTuyen duong da duoc tao! Ma TD: %d\n", new_route.route_id);
    pause_screen();
}

void assign_order_to_route() {
    clear_screen();
    printf("=== PHAN CONG DON HANG CHO TUYEN DUONG ===\n\n");
    
    // Hiển thị đơn hàng chưa được giao
    printf("Don hang chua duoc phan cong:\n");
    for (int i = 0; i < order_count; i++) {
        if (strcmp(orders[i].status, "pending") == 0 || 
            strcmp(orders[i].status, "processing") == 0) {
            printf("ID: %d - %s - %s\n", 
                   orders[i].order_id,
                   orders[i].customer_name,
                   orders[i].customer_address);
        }
    }
    
    int order_id;
    printf("\nNhap ID don hang: ");
    scanf("%d", &order_id);
    
    // Hiển thị tuyến đường đã lên kế hoạch
    printf("\nTuyen duong co san:\n");
    for (int i = 0; i < route_count; i++) {
        if (strcmp(routes[i].status, "planned") == 0) {
            printf("ID: %d - %s -> %s\n", 
                   routes[i].route_id,
                   routes[i].start_location,
                   routes[i].end_location);
        }
    }
    
    int route_id;
    printf("Chon ma tuyen duong: ");
    scanf("%d", &route_id);
    
    // Cập nhật trạng thái đơn hàng
    for (int i = 0; i < order_count; i++) {
        if (orders[i].order_id == order_id) {
            strcpy(orders[i].status, "shipped");
            orders[i].assigned_vehicle = route_id;
            break;
        }
    }
    
    // Cập nhật trạng thái tuyến đường
    for (int i = 0; i < route_count; i++) {
        if (routes[i].route_id == route_id) {
            strcpy(routes[i].status, "in_progress");
            break;
        }
    }
    
    printf("\nPhan cong thanh cong!\n");
    pause_screen();
}

void route_management_menu() {
    int choice;
    do {
        clear_screen();
        printf("=== QUAN LY TUYEN DUONG VA GIAO HANG ===\n\n");
        printf("1. Xem danh sach tuyen duong\n");
        printf("2. Tao tuyen duong giao hang\n");
        printf("3. Phan cong don hang cho tuyen duong\n");
        printf("0. Quay lai\n");
        printf("\nLua chon cua ban: ");
        scanf("%d", &choice);
        
        switch (choice) {
            case 1: display_routes(); break;
            case 2: create_delivery_route(); break;
            case 3: assign_order_to_route(); break;
            case 0: break;
            default: 
                printf("Lua chon khong hop le!\n"); 
                pause_screen(); 
                break;
        }
    } while (choice != 0);
}

// Menu chính
void main_menu() {
    int choice;
    do {
        clear_screen();
        display_logo();
        printf("Xin chao, %s (%s)!\n\n", current_user.username, current_user.role);
        printf("=== MENU CHINH ===\n\n");
        printf("1. Quan ly don hang\n");
        printf("2. Quan ly kho\n");
        printf("3. Quan ly phuong tien van chuyen\n");
        printf("4. Quan ly tuyen duong va giao hang\n");
        printf("0. Dang xuat\n");
        printf("\nLua chon cua ban: ");
        scanf("%d", &choice);
        
        switch (choice) {case 1: order_management_menu(); break;
            case 2: inventory_management_menu(); break;
            case 3: vehicle_management_menu(); break;
            case 4: route_management_menu(); break;
            case 0: 
                is_logged_in = 0;
                printf("Dang xuat thanh cong!\n");
                pause_screen();
                break;
            default: 
                printf("Lua chon khong hop le!\n"); 
                pause_screen(); 
                break;
        }
    } while (choice != 0);
}

// Báo cáo và thống kê
void generate_inventory_report() {
    clear_screen();
    printf("=== BAO CAO TON KHO ===\n\n");
    
    float total_value = 0;
    int low_stock_items = 0;
    
    printf("%-8s %-25s %-10s %-12s %-15s\n", 
           "Ma SP", "Ten san pham", "So luong", "Gia", "Gia tri");
    printf("------------------------------------------------------------------------\n");
    
    for (int i = 0; i < inventory_count; i++) {
        float item_value = inventory[i].quantity * inventory[i].price;
        total_value += item_value;
        
        if (inventory[i].quantity < 10) {
            low_stock_items++;
        }
        
        printf("%-8d %-25s %-10d %-12.2f %-15.2f",
               inventory[i].item_id,
               inventory[i].name,
               inventory[i].quantity,
               inventory[i].price,
               item_value);
               
        if (inventory[i].quantity < 10) {
            printf(" [Sap het hang!]");
        }
        printf("\n");
    }
    
    printf("\n========================================\n");
    printf("Tong gia tri kho hang: %.2f VND\n", total_value);
    printf("So san pham sap het hang: %d\n", low_stock_items);
    pause_screen();
}

void generate_order_report() {
    clear_screen();
    printf("=== BAO CAO DON HANG ===\n\n");
    
    int pending_orders = 0, processing_orders = 0, shipped_orders = 0, delivered_orders = 0;
    float total_revenue = 0;
    
    for (int i = 0; i < order_count; i++) {
        total_revenue += orders[i].total_amount;
        
        if (strcmp(orders[i].status, "pending") == 0) pending_orders++;
        else if (strcmp(orders[i].status, "processing") == 0) processing_orders++;
        else if (strcmp(orders[i].status, "shipped") == 0) shipped_orders++;
        else if (strcmp(orders[i].status, "delivered") == 0) delivered_orders++;
    }
    
    printf("Thong ke don hang:\n");
    printf("- Cho xu ly: %d don\n", pending_orders);
    printf("- Dang xu ly: %d don\n", processing_orders);
    printf("- Da gui di: %d don\n", shipped_orders);
    printf("- Da giao: %d don\n", delivered_orders);
    printf("- Tong cong: %d don\n", order_count);
    printf("\nTong doanh thu: %.2f VND\n", total_revenue);
    
    pause_screen();
}

void generate_vehicle_report() {
    clear_screen();
    printf("=== BAO CAO PHUONG TIEN ===\n\n");
    
    int available_vehicles = 0, busy_vehicles = 0, maintenance_vehicles = 0;
    float total_capacity = 0, total_current_load = 0;
    
    for (int i = 0; i < vehicle_count; i++) {
        total_capacity += vehicles[i].capacity;
        total_current_load += vehicles[i].current_load;
        
        if (strcmp(vehicles[i].status, "available") == 0) available_vehicles++;
        else if (strcmp(vehicles[i].status, "busy") == 0) busy_vehicles++;
        else if (strcmp(vehicles[i].status, "maintenance") == 0) maintenance_vehicles++;
    }
    
    printf("Thong ke phuong tien:\n");
    printf("- San sang: %d xe\n", available_vehicles);
    printf("- Dang ban: %d xe\n", busy_vehicles);
    printf("- Bao tri: %d xe\n", maintenance_vehicles);
    printf("- Tong cong: %d xe\n", vehicle_count);
    printf("\nTai trong:\n");
    printf("- Tong tai trong: %.2f kg\n", total_capacity);
    printf("- Dang tai: %.2f kg\n", total_current_load);
    printf("- Con trong: %.2f kg\n", total_capacity - total_current_load);
    printf("- Ti le su dung: %.1f%%\n", 
           total_capacity > 0 ? (total_current_load / total_capacity) * 100 : 0);
    
    pause_screen();
}

void reports_menu() {
    int choice;
    do {
        clear_screen();
        printf("=== BAO CAO VA THONG KE ===\n\n");
        printf("1. Bao cao ton kho\n");
        printf("2. Bao cao don hang\n");
        printf("3. Bao cao phuong tien\n");
        printf("0. Quay lai\n");
        printf("\nLua chon cua ban: ");
        scanf("%d", &choice);
        
        switch (choice) {
            case 1: generate_inventory_report(); break;
            case 2: generate_order_report(); break;
            case 3: generate_vehicle_report(); break;
            case 0: break;
            default: 
                printf("Lua chon khong hop le!\n"); 
                pause_screen(); 
                break;
        }
    } while (choice != 0);
}

// Quản lý người dùng (chỉ dành cho admin)
void display_users() {
    clear_screen();
    printf("=== DANH SACH NGUOI DUNG ===\n\n");
    printf("%-20s %-15s %-15s\n", "Ten dang nhap", "Mat khau", "Vai tro");
    printf("----------------------------------------------------\n");
    
    for (int i = 0; i < user_count; i++) {
        printf("%-20s %-15s %-15s\n",
               users[i].username,
               "********", // Ẩn mật khẩu
               users[i].role);
    }
    pause_screen();
}

void add_user() {
    if (strcmp(current_user.role, "admin") != 0) {
        printf("Ban khong co quyen thuc hien chuc nang nay!\n");
        pause_screen();
        return;
    }
    
    clear_screen();
    printf("=== THEM NGUOI DUNG MOI ===\n\n");
    
    User new_user;
    printf("Ten dang nhap: ");
    scanf("%s", new_user.username);
    
    // Kiểm tra trùng username
    for (int i = 0; i < user_count; i++) {
        if (strcmp(users[i].username, new_user.username) == 0) {
            printf("Ten dang nhap da ton tai!\n");
            pause_screen();
            return;
        }
    }
    
    printf("Mat khau: ");
    scanf("%s", new_user.password);
    
    printf("Vai tro (admin/manager/employee): ");
    scanf("%s", new_user.role);
    
    users[user_count] = new_user;
    user_count++;
    
    printf("\nNguoi dung da duoc them thanh cong!\n");
    pause_screen();
}

void user_management_menu() {
    if (strcmp(current_user.role, "admin") != 0) {
        printf("Ban khong co quyen truy cap chuc nang nay!\n");
        pause_screen();
        return;
    }
    
    int choice;
    do {
        clear_screen();
        printf("=== QUAN LY NGUOI DUNG ===\n\n");
        printf("1. Xem danh sach nguoi dung\n");
        printf("2. Them nguoi dung moi\n");
        printf("0. Quay lai\n");
        printf("\nLua chon cua ban: ");
        scanf("%d", &choice);
        
        switch (choice) {
            case 1: display_users(); break;
            case 2: add_user(); break;
            case 0: break;
            default: 
                printf("Lua chon khong hop le!\n"); 
                pause_screen(); 
                break;
        }
    } while (choice != 0);
}

// Tìm kiếm và lọc dữ liệu
void search_orders() {
    clear_screen();
    printf("=== TIM KIEM DON HANG ===\n\n");
    printf("1. Tim theo ID don hang\n");
    printf("2. Tim theo ten khach hang\n");
    printf("3. Tim theo trang thai\n");
    printf("Chon loai tim kiem: ");
    
    int search_type;
    scanf("%d", &search_type);
    
    switch (search_type) {
        case 1: {
            int order_id;
            printf("Nhap ID don hang: ");
            scanf("%d", &order_id);
            
            printf("\nKet qua tim kiem:\n");
            printf("%-8s %-20s %-15s %-10s %-12s %-15s %-12s\n", 
                   "ID", "Khach hang", "SDT", "Ma SP", "So luong", "Tong tien", "Trang thai");
            printf("--------------------------------------------------------------------------------\n");
            
            for (int i = 0; i < order_count; i++) {
                if (orders[i].order_id == order_id) {
                    printf("%-8d %-20s %-15s %-10d %-12d %-15.2f %-12s\n",
                           orders[i].order_id,
                           orders[i].customer_name,
                           orders[i].customer_phone,
                           orders[i].item_id,
                           orders[i].quantity,
                           orders[i].total_amount,
                           orders[i].status);
                    break;
                }
            }
            break;
        }
        case 2: {
            char customer_name[MAX_NAME_LEN];
            printf("Nhap ten khach hang: ");
            getchar(); // Clear buffer
            fgets(customer_name, MAX_NAME_LEN, stdin);
            customer_name[strcspn(customer_name, "\n")] = 0;
            
            printf("\nKet qua tim kiem:\n");
            printf("%-8s %-20s %-15s %-10s %-12s %-15s %-12s\n", 
                   "ID", "Khach hang", "SDT", "Ma SP", "So luong", "Tong tien", "Trang thai");
            printf("--------------------------------------------------------------------------------\n");
            
            for (int i = 0; i < order_count; i++) {
                if (strstr(orders[i].customer_name, customer_name) != NULL) {
                    printf("%-8d %-20s %-15s %-10d %-12d %-15.2f %-12s\n",
                           orders[i].order_id,
                           orders[i].customer_name,
                           orders[i].customer_phone,
                           orders[i].item_id,
                           orders[i].quantity,
                           orders[i].total_amount,
                           orders[i].status);
                }
            }
            break;
        }
        case 3: {
            char status[20];
            printf("Nhap trang thai (pending/processing/shipped/delivered): ");
            scanf("%s", status);
            
            printf("\nKet qua tim kiem:\n");
            printf("%-8s %-20s %-15s %-10s %-12s %-15s %-12s\n", 
                   "ID", "Khach hang", "SDT", "Ma SP", "So luong", "Tong tien", "Trang thai");
            printf("--------------------------------------------------------------------------------\n");
            
            for (int i = 0; i < order_count; i++) {
                if (strcmp(orders[i].status, status) == 0) {
                    printf("%-8d %-20s %-15s %-10d %-12d %-15.2f %-12s\n",
                           orders[i].order_id,
                           orders[i].customer_name,
                           orders[i].customer_phone,
                           orders[i].item_id,
                           orders[i].quantity,
                           orders[i].total_amount,
                           orders[i].status);
                }
            }
            break;
        }
        default:
            printf("Lua chon khong hop le!\n");
            break;
    }
    
    pause_screen();
}

void search_inventory() {
    clear_screen();
    printf("=== TIM KIEM SAN PHAM ===\n\n");
    printf("1. Tim theo ma san pham\n");
    printf("2. Tim theo ten san pham\n");
    printf("3. Tim theo danh muc\n");
    printf("4. Loc san pham sap het hang\n");
    printf("Chon loai tim kiem: ");
    
    int search_type;
    scanf("%d", &search_type);
    
    switch (search_type) {
        case 1: {
            int item_id;
            printf("Nhap ma san pham: ");
            scanf("%d", &item_id);
            
            printf("\nKet qua tim kiem:\n");
            printf("%-8s %-25s %-10s %-12s %-15s %-15s\n", 
                   "Ma SP", "Ten san pham", "So luong", "Gia", "Danh muc", "Vi tri");
            printf("---------------------------------------------------------------------------------\n");
            
            for (int i = 0; i < inventory_count; i++) {
                if (inventory[i].item_id == item_id) {
                    printf("%-8d %-25s %-10d %-12.2f %-15s %-15s\n",
                           inventory[i].item_id,
                           inventory[i].name,
                           inventory[i].quantity,
                           inventory[i].price,
                           inventory[i].category,
                           inventory[i].location);
                    break;
                }
            }
            break;
        }
        case 2: {
            char product_name[MAX_NAME_LEN];
            printf("Nhap ten san pham: ");
            getchar(); // Clear buffer
            fgets(product_name, MAX_NAME_LEN, stdin);
            product_name[strcspn(product_name, "\n")] = 0;
            
            printf("\nKet qua tim kiem:\n");
            printf("%-8s %-25s %-10s %-12s %-15s %-15s\n", 
                   "Ma SP", "Ten san pham", "So luong", "Gia", "Danh muc", "Vi tri");
            printf("---------------------------------------------------------------------------------\n");
            
            for (int i = 0; i < inventory_count; i++) {
                if (strstr(inventory[i].name, product_name) != NULL) {
                    printf("%-8d %-25s %-10d %-12.2f %-15s %-15s\n",
                           inventory[i].item_id,
                           inventory[i].name,
                           inventory[i].quantity,
                           inventory[i].price,
                           inventory[i].category,
                           inventory[i].location);
                }
            }
            break;
        }
        case 3: {
            char category[50];
            printf("Nhap danh muc: ");
            scanf("%s", category);
            
            printf("\nKet qua tim kiem:\n");
            printf("%-8s %-25s %-10s %-12s %-15s %-15s\n", 
                   "Ma SP", "Ten san pham", "So luong", "Gia", "Danh muc", "Vi tri");
            printf("---------------------------------------------------------------------------------\n");
            
            for (int i = 0; i < inventory_count; i++) {
                if (strcmp(inventory[i].category, category) == 0) {
                    printf("%-8d %-25s %-10d %-12.2f %-15s %-15s\n",
                           inventory[i].item_id,
                           inventory[i].name,
                           inventory[i].quantity,
                           inventory[i].price,
                           inventory[i].category,
                           inventory[i].location);
                }
            }
            break;
        }
        case 4: {
            printf("\nSan pham sap het hang (< 10 sp):\n");
            printf("%-8s %-25s %-10s %-12s %-15s %-15s\n", 
                   "Ma SP", "Ten san pham", "So luong", "Gia", "Danh muc", "Vi tri");
            printf("---------------------------------------------------------------------------------\n");
            
            for (int i = 0; i < inventory_count; i++) {
                if (inventory[i].quantity < 10) {
                    printf("%-8d %-25s %-10d %-12.2f %-15s %-15s\n",
                           inventory[i].item_id,
                           inventory[i].name,
                           inventory[i].quantity,
                           inventory[i].price,
                           inventory[i].category,
                           inventory[i].location);
                }
            }
            break;
        }
        default:
            printf("Lua chon khong hop le!\n");
            break;
    }
    
    pause_screen();
}

void search_menu() {
    int choice;
    do {
        clear_screen();
        printf("=== TIM KIEM VA LOC DU LIEU ===\n\n");
        printf("1. Tim kiem don hang\n");
        printf("2. Tim kiem san pham\n");
        printf("0. Quay lai\n");
        printf("\nLua chon cua ban: ");
        scanf("%d", &choice);
        
        switch (choice) {
            case 1: search_orders(); break;
            case 2: search_inventory(); break;
            case 0: break;
            default: 
                printf("Lua chon khong hop le!\n"); 
                pause_screen(); 
                break;
        }
    } while (choice != 0);
}

// Cập nhật menu chính để thêm các chức năng mới
void updated_main_menu() {
    int choice;
    do {
        clear_screen();
        display_logo();
        printf("Xin chao, %s (%s)!\n\n", current_user.username, current_user.role);
        printf("=== MENU CHINH ===\n\n");
        printf("1. Quan ly don hang\n");
        printf("2. Quan ly kho\n");
        printf("3. Quan ly phuong tien van chuyen\n");
        printf("4. Quan ly tuyen duong va giao hang\n");
        printf("5. Bao cao va thong ke\n");
        printf("6. Tim kiem va loc du lieu\n");
        if (strcmp(current_user.role, "admin") == 0) {
            printf("7. Quan ly nguoi dung\n");
        }
        printf("0. Dang xuat\n");
        printf("\nLua chon cua ban: ");
        scanf("%d", &choice);
        
        switch (choice) {
            case 1: order_management_menu(); break;
            case 2: inventory_management_menu(); break;
            case 3: vehicle_management_menu(); break;
            case 4: route_management_menu(); break;
            case 5: reports_menu(); break;
            case 6: search_menu(); break;
            case 7: 
                if (strcmp(current_user.role, "admin") == 0) {
                    user_management_menu();
                } else {
                    printf("Lua chon khong hop le!\n");
                    pause_screen();
                }
                break;
            case 0: 
                is_logged_in = 0;
                printf("Dang xuat thanh cong!\n");
                pause_screen();
                break;
            default: 
                printf("Lua chon khong hop le!\n"); 
                pause_screen(); 
                break;
        }
    } while (choice != 0);
}

// Hàm main
int main() {
    load_sample_data();
    
    printf("Khoi tao he thong thanh cong!\n");
    printf("Dang nhap mau:\n");
    printf("- Admin: admin/admin123\n");
    printf("- Manager: manager/manager123\n");
    printf("- Employee: employee/emp123\n");
    pause_screen();
    
    while (1) {
        if (!is_logged_in) {
            login();
        } else {
            updated_main_menu();
        }
    }
    
    return 0;
} 
