# Đặc tả Yêu cầu Phần mềm (SRS): Hệ thống Quản lý Karaoke (KMS)

Phiên bản: 1.0

Ngày: 15 tháng 1 năm 2025

Tác giả: Nguyễn Văn Tân

-----

## 1. Giới thiệu

Tài liệu này định nghĩa Đặc tả Yêu cầu Phần mềm (Software Requirements Specification - SRS) cho một Hệ thống Quản lý Karaoke (KMS) đa nền tảng. Các yêu cầu được đưa ra nhằm phác thảo đầy đủ các chức năng, hành vi và ràng buộc của hệ thống, đóng vai trò là nguồn thông tin chính (source of truth) cho các nhóm thiết kế, phát triển, kiểm thử (QA) và quản lý dự án.1

### 1.1. Mục đích

Mục đích của tài liệu này là cung cấp một bộ yêu cầu toàn diện cho việc phát triển Hệ thống Quản lý Karaoke (KMS). Hệ thống này được thiết kế để giải quyết các thách thức vận hành cốt lõi của một cơ sở kinh doanh karaoke hiện đại.

Dự án sẽ sử dụng framework Flutter của Google để phát triển và triển khai ứng dụng trên nhiều nền tảng từ một cơ sở mã (single codebase) duy nhất.3 Các nền tảng mục tiêu bao gồm:

- Windows: Cho ứng dụng quản lý trung tâm (Point of Sale - POS).
- Android & iOS: Cho các ứng dụng di động hỗ trợ nhân viên và khách hàng.

Tài liệu này xác định rõ các yêu cầu chức năng (những gì hệ thống làm) và phi chức năng (hệ thống hoạt động như thế nào), tạo cơ sở cho thỏa thuận giữa các bên liên quan về sản phẩm cuối cùng.1

### 1.2. Phạm vi Sản phẩm

Hệ thống KMS là một giải pháp quản lý toàn diện (end-to-end) nhằm mục đích tự động hóa và tối ưu hóa mọi khía cạnh hoạt động của một quán karaoke. Phạm vi của sản phẩm bao gồm, nhưng không giới hạn ở:

- Quản lý Vận hành (POS): Xử lý quy trình check-in, check-out, quản lý sơ đồ phòng trực quan, và chuyển/gộp phòng.5
- Hệ thống Tính tiền: Một công cụ tính tiền giờ linh hoạt, hỗ trợ nhiều biểu giá phức tạp (theo giờ, theo block, theo loại phòng, theo ngày lễ).5
- Quản lý Dịch vụ (F&B): Cho phép gọi món (order) đồ ăn và thức uống, tự động tính vào hóa đơn phòng.9
- Quản lý Kho: Kiểm soát hàng hóa, nguyên vật liệu, định lượng, và theo dõi tồn kho, giá vốn.5
- Báo cáo & Phân tích: Cung cấp các báo cáo chi tiết về doanh thu, chi phí, lợi nhuận và hiệu suất hoạt động.7

### 1.3. Định nghĩa, Từ viết tắt

- Flutter: Framework phát triển giao diện người dùng (UI) đa nền tảng.3
- KMS: (Karaoke Management System) Hệ thống Quản lý Karaoke.
- POS: (Point of Sale) Điểm bán hàng, đề cập đến ứng dụng/trạm thu ngân.14
- F&B: (Food and Beverage) Đồ ăn và thức uống.
- RBAC: (Role-Based Access Control) Kiểm soát truy cập dựa trên vai trò.9
- NFR: (Non-Functional Requirement) Yêu cầu phi chức năng.15
- Firebase: Nền tảng Backend-as-a-Service (BaaS) của Google, cung cấp cơ sở dữ liệu, xác thực và các dịch vụ đám cậy khác.
- Cloud Firestore: Dịch vụ cơ sở dữ liệu NoSQL, thời gian thực của Firebase sẽ được sử dụng làm cơ sở dữ liệu chính.
- FlutterFire: Tên gọi chính thức cho bộ thư viện Flutter SDK của Firebase.
- PCI DSS: (Payment Card Industry Data Security Standard) Tiêu chuẩn Bảo mật Dữ liệu Ngành Thẻ thanh toán.17
- P2PE: (Point-to-Point Encryption) Mã hóa điểm-tới-điểm.18
- UI/UX: (User Interface / User Experience) Giao diện người dùng / Trải nghiệm người dùng.
- API: (Application Programming Interface) Giao diện lập trình ứng dụng.
- BOM: (Bill of Materials) Công thức định lượng nguyên vật liệu.5

### 1.4. Tổng quan về Kiến trúc Hệ thống

Việc đáp ứng yêu cầu đa nền tảng (Windows, Android, iOS) không có nghĩa là xây dựng một ứng dụng duy nhất hoạt động giống hệt nhau ở mọi nơi. Thay vào đó, hệ thống được kiến trúc như một hệ sinh thái gồm nhiều ứng dụng chuyên biệt, nhắm đến các vai trò người dùng cụ thể.

Tất cả các ứng dụng này sẽ sử dụng Firebase làm nền tảng backend đám mây (BaaS). Các dịch vụ cốt lõi như Cloud Firestore sẽ được dùng làm cơ sở dữ liệu thời gian thực, Firebase Authentication để quản lý người dùng, và Firebase Cloud Functions để xử lý logic nghiệp vụ phía máy chủ (ví dụ: tổng hợp báo cáo, tích hợp thanh toán).

Flutter được chọn làm công nghệ chủ đạo vì khả năng biên dịch sang mã nguồn gốc (native) trên tất cả các nền tảng mục tiêu (Windows, iOS, Android) 3, cho phép chia sẻ tối đa mã nguồn trong khi vẫn cung cấp hiệu suất và trải nghiệm người dùng gốc.

Bảng 1: Danh mục Ứng dụng Hệ thống (Application Portfolio)

|              |                                          |               |                             |
| :----------: | :--------------------------------------: | :-----------: | :-------------------------: |
| Tên Ứng dụng | Mục đích chính                           | Nền tảng Đích | Vai trò Người dùng Chính    |
| KMS-Manager  | Quản lý vận hành, POS, Báo cáo, Cấu hình | Windows       | Chủ quán, Quản lý, Thu ngân |
| KMS-Staff    | Check-in, Order F&B, Xử lý yêu cầu      | Android, iOS  | Nhân viên Phục vụ, Lễ tân   |

### 1.5. Tài liệu Tham khảo

- Tiêu chuẩn IEEE 830-1998 - Thực hành Khuyến nghị cho Đặc tả Yêu cầu Phần mềm.
- Tiêu chuẩn ISO/IEC/IEEE 29148:2011 - Quy trình Kỹ thuật Hệ thống và Phần mềm.20
- Tài liệu thiết kế Đa nền tảng của Flutter.3
- Tài liệu chính thức của Firebase (Firebase Documentation).
- Tiêu chuẩn Bảo mật PCI DSS.17

-----

## 2. Mô tả Tổng quan

Phần này mô tả các vai trò người dùng sẽ tương tác với hệ thống, các ràng buộc chung và các giả định làm cơ sở cho thiết kế.

### 2.1. Bối cảnh Sản phẩm

Hệ thống KMS được thiết kế để thay thế các quy trình thủ công (ghi giấy, tính nhẩm) hoặc các phần mềm POS thế hệ cũ. Mục tiêu là cung cấp một giải pháp hợp nhất, thời gian thực, giảm thiểu sai sót của con người, ngăn chặn thất thoát 12 và nâng cao trải nghiệm tổng thể của khách hàng. Hệ thống phải đảm bảo việc tính tiền giờ là chính xác tuyệt đối 5, việc quản lý F&B nhanh chóng và việc kiểm soát kho hàng chặt chẽ.11

### 2.2. Đặc điểm Người dùng (User Roles)

Hệ thống sẽ định nghĩa các vai trò người dùng chính sau đây để thực thi chính sách phân quyền:

- Quản trị viên (Admin / Chủ quán): Người dùng có quyền lực cao nhất. Chịu trách nhiệm cấu hình hệ thống (giá cả, phòng ốc), quản lý tài khoản nhân viên, xem các báo cáo tài chính nhạy cảm (ví dụ: lợi nhuận, giá vốn) và có thể thực hiện các hành động ghi đè cấp cao (ví dụ: hủy hóa đơn đã thanh toán).13
- Quản lý (Manager): Quản lý hoạt động hàng ngày. Được phép xem báo cáo doanh thu theo ca, quản lý nhập/xuất kho 11, và xử lý các nghiệp vụ đặc biệt như áp dụng giảm giá thủ công hoặc xử lý khiếu nại.8
- Thu ngân (Cashier): Người dùng chính của ứng dụng KMS-Manager (Windows). Chịu trách nhiệm cho các nghiệp vụ POS cốt lõi: check-in, check-out, tính tiền, in hóa đơn và nhận thanh toán.5 Quyền hạn bị giới hạn, ví dụ không thể xem báo cáo lợi nhuận hoặc tự ý thay đổi giá.8
- Nhân viên Phục vụ (Staff): Người dùng chính của ứng dụng KMS-Staff (Android/iOS). Chịu trách nhiệm nhận đặt phòng tại sảnh, dẫn khách, ghi order F&B tại phòng, và phản hồi các yêu cầu dịch vụ của khách.9

### 2.3. Ma trận Phân quyền (RBAC)

Để đảm bảo an ninh và ngăn chặn gian lận, hệ thống phải thực thi cơ chế Kiểm soát Truy cập Dựa trên Vai trò (RBAC) một cách nghiêm ngặt. Các hoạt động nhạy cảm như xóa hóa đơn, giảm giá thủ công, hoặc thay đổi giá gốc phải được giới hạn cho các vai trò quản lý cấp cao.8

Việc triển khai RBAC sẽ được thực hiện bằng Firebase Authentication kết hợp với Quy tắc Bảo mật của Cloud Firestore (Firestore Security Rules) và/hoặc Firebase Custom Claims. Điều này đảm bảo rằng các quy tắc phân quyền được thực thi ở phía máy chủ (backend) và không thể bị qua mặt bởi client.

Bảng 2: Ma trận Phân quyền Chức năng (RBAC) - Sơ bộ

|                                                            |                             |                  |         |             |                    |
| :--------------------------------------------------------: | :-------------------------: | :--------------: | :-----: | :---------: | :----------------: |
| Module                                                     | Chức năng                   | Admin (Chủ quán) | Quản lý | Thu ngân    | Phục vụ (Staff)    |
| Quản lý Phòng                                              | Xem sơ đồ                   | R                | R       | R           | R (Đơn giản)       |
|                                                            | Check-in / Check-out        | R/C/U            | R/C/U   | R/C/U       | R/C (Chỉ Check-in) |
|                                                            | Chuyển/Gộp phòng            | R/U              | R/U     | R/U         | -                 |
| Thanh toán                                                 | Tạo & In hóa đơn            | R/C              | R/C     | R/C         | -                 |
|                                                            | Áp dụng giảm giá (thủ công) | R/U              | R/U     | R (Hạn chế) | -                 |
|                                                            | Hủy hóa đơn (đã in)         | R/D              | R/D     | -          | -                 |
| Kho (F&B)                                                 | Order món (Bán hàng)        | R/C              | R/C     | R/C         | R/C                |
|                                                            | Nhập kho / Kiểm kho         | R/C/U/D          | R/C/U   | -          | -                 |
| Báo cáo                                                    | Xem Doanh thu               | R                | R       | R (Theo ca) | -                 |
|                                                            | Xem Lợi nhuận (Giá vốn)     | R                | R       | -          | -                 |
| Cấu hình                                                   | Cài đặt giá giờ / Thuế      | R/C/U/D          | R/U     | -          | -                 |
|                                                            | Quản lý tài khoản nhân viên | R/C/U/D          | R/C/U   | -          | -                 |
| (R=Read, C=Create, U=Update, D=Delete, - = Không có quyền) |                             |                  |         |             |                    |

### 2.4. Giả định và Ràng buộc

- Ràng buộc (Công nghệ): Toàn bộ hệ sinh thái ứng dụng (KMS-Manager, KMS-Staff, KMS-Customer) phải được phát triển bằng Flutter từ một cơ sở mã chung.
- Ràng buộc (Backend): Hệ thống sẽ chỉ sử dụng Firebase làm nền tảng backend đám mây. Không hỗ trợ triển khai tại chỗ (on-premise).
- Ràng buộc (Hạ tầng): Hệ thống yêu cầu kết nối Internet ổn định, có độ trễ thấp để đảm bảo giao tiếp và đồng bộ hóa thời gian thực giữa các ứng dụng và dịch vụ Firebase.
- Ràng buộc (Bảo mật): Mạng Wi-Fi dành cho khách (Guest Wi-Fi) phải được phân đoạn (segmented) và cách ly hoàn toàn khỏi mạng POS nội bộ.
- Giả định: Khách hàng (chủ quán) tự trang bị phần cứng cần thiết, bao gồm: máy tính Windows cho POS, máy in hóa đơn, thiết bị di động cho nhân viên, và hệ thống phát nhạc/TV trong phòng hát.

-----

## 3. Yêu cầu Chức năng (Functional Requirements)

Phần này mô tả chi tiết các hành vi và chức năng mà hệ thống phải thực hiện, được nhóm theo các module nghiệp vụ chính.

### 3.1. FR-MGR: Module Quản lý (Core) - (Trên KMS-Manager/Windows)

Đây là trung tâm điều hành của quán, được vận hành chủ yếu bởi Thu ngân và Quản lý trên ứng dụng Windows.

#### 3.1.1. Quản lý Sơ đồ Phòng (Visual Map)

- FR-MGR-001: Hệ thống phải hiển thị một sơ đồ phòng trực quan, thể hiện chính xác bố cục của quán karaoke.6
- FR-MGR-002: Sơ đồ phải hỗ trợ phân chia theo nhiều khu vực (ví dụ: Khu VIP, Khu Thường, Sảnh).5
- FR-MGR-003: Mỗi phòng trên sơ đồ phải hiển thị rõ ràng và tức thì các trạng thái bằng màu sắc hoặc biểu tượng (dữ liệu được đồng bộ hóa thời gian thực từ Cloud Firestore), bao gồm:

  - Trống (Sẵn sàng phục vụ).5
  - Đang hát (Có khách, đang tính giờ).5
  - Đã đặt trước (Được đặt cho một khung giờ cụ thể).6
  - Chưa dọn dẹp (Khách vừa rời đi, chờ nhân viên xác nhận dọn phòng).
  - Bảo trì (Phòng đang tạm ngưng phục vụ).

- FR-MGR-004: Thu ngân phải có khả năng nhấp (click) hoặc chạm (nếu dùng màn hình cảm ứng) vào một phòng để thực hiện các thao tác nghiệp vụ.6

#### 3.1.2. Nghiệp vụ Phòng (Room Operations)

- FR-MGR-005 (Check-in): Khi Thu ngân/Nhân viên thực hiện check-in cho một phòng, hệ thống phải ngay lập tức bắt đầu tính giờ tự động cho phòng đó.5
- FR-MGR-006 (Check-out): Khi thực hiện check-out, hệ thống phải:

1.  Chốt thời gian sử dụng dịch vụ.
2.  Tự động tính toán tổng tiền (tiền giờ + tiền F&B) dựa trên các quy tắc định giá.
3.  Hiển thị màn hình thanh toán chi tiết.5

- FR-MGR-007 (Chuyển phòng): Hệ thống phải hỗ trợ nghiệp vụ chuyển phòng. Toàn bộ hóa đơn (bao gồm thời gian bắt đầu và các món F&B đã gọi) phải được di chuyển từ phòng A sang phòng B.5
- FR-MGR-008 (Gộp phòng): (Nâng cao) Hệ thống phải cho phép gộp hóa đơn từ nhiều phòng (ví dụ: đoàn khách đi chung) vào một hóa đơn duy nhất để thanh toán.

#### 3.1.3. Quản lý Đặt phòng (Booking)

- FR-MGR-009: Hệ thống phải cho phép nhân viên (Lễ tân/Thu ngân) tạo một lịch đặt phòng trước cho khách hàng.6
- FR-MGR-010: Thông tin đặt phòng phải bao gồm tối thiểu: Tên khách hàng, Số điện thoại 9, Ngày/giờ bắt đầu, Thời lượng dự kiến, Loại phòng, và Tiền cọc (nếu có).
- FR-MGR-011: Phòng đã đặt trước phải được hiển thị rõ ràng trên sơ đồ phòng (FR-MGR-003) khi gần đến giờ hẹn.

### 3.2. FR-BILL: Module Tính tiền & Thanh toán - (Trên KMS-Manager/Windows)

Đây là module nghiệp vụ phức tạp và quan trọng nhất, quyết định trực tiếp đến doanh thu. Hệ thống tính tiền phải là một "Công cụ Quy tắc (Rules Engine)" linh hoạt, không chỉ đơn thuần là phép tính (Giờ ra - Giờ vào) * Đơn giá. Logic này xuất phát từ thực tế kinh doanh karaoke, nơi giá cả biến động liên tục trong ngày và theo loại phòng.5

Ví dụ, một khách hàng check-in lúc 17:00 (giờ thấp điểm) và check-out lúc 19:00 (giờ cao điểm) phải được hệ thống tự động tính tiền cho 1 giờ giá thấp điểm và 1 giờ giá cao điểm, mà không cần sự can thiệp thủ công.

#### 3.2.1. Công cụ Định giá (Pricing Engine)

- FR-BILL-001: Hệ thống phải cho phép Quản trị viên/Quản lý cấu hình nhiều biểu giá khác nhau.8 Các cấu hình này sẽ được lưu trữ trên Cloud Firestore.
- FR-BILL-002: Hệ thống phải hỗ trợ và tự động áp dụng các quy tắc định giá sau (có thể kết hợp):

  - Theo Loại phòng/Khu vực: Giá phòng VIP phải khác giá phòng thường.5
  - Theo Khung giờ (Timeframes): Tự động chuyển đổi giá khi vào các khung giờ khác nhau (ví dụ: Giờ vàng, Giờ cao điểm).5
  - Theo Ngày trong tuần: Giá cuối tuần (Thứ 7, CN) phải khác giá ngày thường.5
  - Theo Ngày đặc biệt: Tự động áp dụng bảng giá riêng cho các ngày Lễ, Tết đã được cài đặt trước.5

- FR-BILL-003: Hệ thống phải hỗ trợ tính tiền theo các đơn vị (do quản lý cấu hình):

  - Theo phút.
  - Theo giờ.
  - Theo block (ví dụ: làm tròn lên 15 phút, 30 phút). Khách hát 10 phút vẫn tính tiền 1 block 15 phút.5

Bảng 3: Ví dụ Cấu hình Quy tắc Định giá (Pricing Rules)

|     |              |            |               |               |               |        |
| :-: | :----------: | :--------: | :-----------: | :-----------: | :-----------: | :----: |
| ID  | Tên Quy tắc  | Loại phòng | Ngày áp dụng  | Khung giờ     | Đơn giá (VND) | Đơn vị |
| R01 | Giờ vàng     | Thường     | Thứ 2 - Thứ 6 | 09:00 - 17:00 | 120,000       | /giờ   |
| R02 | Giờ cao điểm | Thường     | Thứ 2 - Thứ 6 | 17:01 - 23:59 | 180,000       | /giờ   |
| R03 | Cuối tuần    | Thường     | Thứ 7, CN     | 09:00 - 23:59 | 200,000       | /giờ   |
| R04 | VIP Tối      | VIP        | Mọi ngày      | 18:00 - 23:59 | 300,000       | /giờ   |
| R05 | Lễ 30/4      | Tất cả     | 30/04         | 00:00 - 23:59 | 350,000       | /giờ   |

#### 3.2.2. Nghiệp vụ Thanh toán (Payment)

- FR-BILL-004: Màn hình thanh toán phải hiển thị hóa đơn một cách chi tiết, trực quan, tách bạch rõ ràng giữa tiền giờ và tiền dịch vụ F&B.10
- FR-BILL-005: Hệ thống phải hỗ trợ nhiều hình thức thanh toán: Tiền mặt, Thẻ ngân hàng (POS), Chuyển khoản, và (Nâng cao) Tích hợp Ví điện tử (MoMo, VNPay).
- FR-BILL-006: Hệ thống phải hỗ trợ các nghiệp vụ giảm giá (discount) và khuyến mãi 8:

  - Giảm giá thủ công (theo % hoặc số tiền cố định) trên tổng hóa đơn (yêu cầu quyền của Quản lý, được kiểm soát bởi Firebase Security Rules).
  - Tự động áp dụng giảm giá theo chương trình khuyến mãi đã cài đặt (ví dụ: Combo, Giờ vàng).11
  - Tự động áp dụng giảm giá theo Thẻ VIP của khách hàng (xem FR-CRM-004).5

- FR-BILL-007: Hệ thống phải hỗ trợ in hóa đơn (bill) ra máy in nhiệt chuyên dụng (ví dụ: khổ 80mm).24
- FR-BILL-008: (Nâng cao) Hệ thống phải cho phép ghi nợ (công nợ) hóa đơn cho khách hàng thân thiết hoặc khách hàng doanh nghiệp.5

### 3.3. FR-STAFF: Module Nhân viên Phục vụ - (Trên KMS-Staff/Android & iOS)

Ứng dụng di động này được thiết kế để tối ưu hóa tốc độ và sự linh hoạt cho nhân viên phục vụ, giải phóng họ khỏi quầy thu ngân cố định.25

- FR-STAFF-001: Nhân viên phải đăng nhập vào ứng dụng bằng tài khoản đã được cấp (sử dụng Firebase Authentication).
- FR-STAFF-002: Ứng dụng phải hiển thị một danh sách hoặc sơ đồ phòng (phiên bản đơn giản hóa) cho phép nhân viên xem nhanh trạng thái phòng (Trống, Đang hát), đồng bộ hóa từ Cloud Firestore.
- FR-STAFF-003: Cho phép nhân viên thực hiện Check-in cho khách ngay tại sảnh (nếu khách không đặt trước).
- FR-STAFF-004: Cung cấp giao diện gọi món (order) F&B.9 Nhân viên có thể chọn phòng, sau đó thêm các món ăn, thức uống vào hóa đơn của phòng đó (ghi dữ liệu vào Cloud Firestore).
- FR-STAFF-005: Khi một đơn hàng F&B được xác nhận trên ứng dụng, đơn hàng đó phải tự động được thêm vào hóa đơn tổng của phòng trên hệ thống POS (KMS-Manager) theo thời gian thực (thông qua cơ chế lắng nghe (listener) của Cloud Firestore).
- FR-STAFF-006: (Nâng cao) Ứng dụng phải có khả năng nhận thông báo đẩy (push notification) khi khách hàng (từ ứng dụng KMS-Customer) yêu cầu dịch vụ (ví dụ: gọi thêm đá, khăn lạnh).

### 3.4. FR-INV: Module Kho hàng & F&B - (Trên KMS-Manager/Windows)

Module này chịu trách nhiệm quản lý dòng chảy của hàng hóa, dịch vụ, kiểm soát chi phí và ngăn chặn thất thoát.5 Dữ liệu kho hàng sẽ được lưu trữ và quản lý trên Cloud Firestore.

- FR-INV-001: Hệ thống phải cho phép quản lý danh mục hàng hóa (đồ ăn, thức uống, thuốc lá...) và dịch vụ (phí phục vụ...).9
- FR-INV-002: Mỗi mặt hàng trong kho phải có các thuộc tính: Tên, Đơn vị tính (chai, lon, đĩa), Giá bán, và Giá vốn (giá nhập vào).5
- FR-INV-003 (Nhập kho): Hỗ trợ tạo phiếu nhập kho, ghi nhận số lượng, giá nhập, và thông tin nhà cung cấp.11
- FR-INV-004 (Xuất kho): Hàng hóa phải được tự động trừ kho (xuất kho) khi được bán (tức là khi nhân viên order và thêm vào hóa đơn phòng).5 (Logic này có thể được thực thi bằng Cloud Functions để đảm bảo tính toàn vẹn).
- FR-INV-005 (Tồn kho): Hệ thống phải cho phép Quản lý xem số lượng tồn kho thực tế của bất kỳ mặt hàng nào tại bất kỳ thời điểm nào.5
- FR-INV-006 (Định lượng - BOM): (Nâng cao) Hệ thống phải hỗ trợ công thức định lượng (Bill of Materials).5

  - Ví dụ: Bán "1 Đĩa Trái Cây" (mặt hàng bán) sẽ tự động trừ kho các nguyên vật liệu: 0.1kg Táo, 0.2kg Nho, 0.1kg Dưa hấu.

### 3.5. FR-REPORT: Module Báo cáo & Thống kê - (Trên KMS-Manager/Windows)

Module này cung cấp cho Chủ quán/Quản lý cái nhìn sâu sắc về tình hình kinh doanh, giúp ra quyết định dựa trên dữ liệu.5

#### 3.5.1. Ràng buộc Báo cáo với Firebase (Reporting Constraints with Firebase)

- Do sử dụng Cloud Firestore (cơ sở dữ liệu NoSQL) làm backend, các truy vấn tổng hợp phức tạp (complex aggregation queries) để tạo báo cáo (ví dụ: tính tổng doanh thu theo tháng, lợi nhuận) không được hỗ trợ trực tiếp hoặc không hiệu quả về chi phí/hiệu suất khi truy vấn trên bộ dữ liệu lớn.

#### 3.5.2. Yêu cầu Báo cáo

- FR-REPORT-001 (Báo cáo Tổng quan): Báo cáo Doanh thu, Chi phí, và Lợi nhuận (tổng quan) theo một khoảng thời gian tùy chọn (ngày, tuần, tháng).5
- FR-REPORT-002 (Báo cáo Doanh thu Chi tiết): Cung cấp các báo cáo doanh thu được phân tích chi tiết theo:

  - Theo phòng, theo khu vực.5
  - Theo nhân viên (thu ngân, phục vụ).5
  - Theo mặt hàng F&B (mặt hàng nào bán chạy nhất).
  - Theo khung giờ (khung giờ nào mang lại doanh thu cao nhất).

- FR-REPORT-003 (Báo cáo Kho):

  - Báo cáo Nhập-Xuất-Tồn (Inventory movement report).5
  - Báo cáo giá trị tồn kho (tính theo giá vốn).11
  - Báo cáo hao hụt (nếu có kiểm kho).

- FR-REPORT-004 (Báo cáo Thu-Chi): Quản lý dòng tiền mặt, theo dõi các phiếu thu (ngoài bán hàng) và phiếu chi (ví dụ: chi mua hàng, chi lương).5
- FR-REPORT-005 (Báo cáo Công nợ): Theo dõi công nợ nhà cung cấp và công nợ khách hàng (đã kích hoạt ở FR-BILL-008).5
- FR-REPORT-006 (Tổng hợp Dữ liệu cho Báo cáo): Để giải quyết ràng buộc 3.6.1, hệ thống phải sử dụng Firebase Cloud Functions để lắng nghe các sự kiện (ví dụ: một hóa đơn mới được thanh toán) và cập nhật các tài liệu "tổng hợp" (aggregation documents) trong Cloud Firestore theo thời gian thực. Các ứng dụng client sẽ đọc trực tiếp từ các tài liệu đã tổng hợp này để hiển thị báo cáo, giảm thiểu chi phí đọc và tăng tốc độ tải.
- FR-REPORT-007 (Phân tích Nâng cao): (Nâng cao) Đối với các yêu cầu phân tích dữ liệu lớn và phức tạp, hệ thống phải cung cấp khả năng tích hợp và đồng bộ hóa dữ liệu từ Cloud Firestore sang BigQuery. Báo cáo sau đó sẽ được tạo bằng các công cụ truy vấn SQL trên BigQuery.

### 3.7. FR-CRM: Module Quản lý Khách hàng - (Trên KMS-Manager/Windows)

Module này giúp quản lý khách hàng thân thiết và triển khai các chương trình marketing.5 Dữ liệu khách hàng sẽ được lưu trên Cloud Firestore.

- FR-CRM-001 (Cơ sở dữ liệu Khách hàng): Cho phép lưu trữ thông tin khách hàng (Tên, Số điện thoại) khi họ thanh toán hoặc đặt phòng.8
- FR-CRM-002 (Quản lý Thẻ VIP): Hỗ trợ tạo và quản lý các cấp độ thẻ thành viên (ví dụ: Vàng, Bạc, Đồng).5
- FR-CRM-003 (Tích điểm): Tự động tích lũy điểm cho khách hàng dựa trên tổng chi tiêu của hóa đơn.11
- FR-CRM-004 (Chính sách Khuyến mãi): Tự động áp dụng các chính sách giảm giá dựa trên:

  - Cấp độ thẻ VIP (ví dụ: Thẻ Vàng giảm 10% F&B).11
  - Ngày sinh nhật của khách hàng.8

- FR-CRM-005 (Quản lý Chương trình): Cho phép tạo và quản lý các chương trình khuyến mãi (voucher, giảm giá theo combo F&B, giảm giá giờ hát).11

-----

## 4. Yêu cầu Nền tảng Cụ thể (Platform-Specific Requirements)

Phần này đặc tả các yêu cầu riêng biệt mà Flutter phải xử lý để đảm bảo ứng dụng hoạt động tối ưu và "giống như native" trên từng nền tảng.

### 4.1. Chung (Flutter Framework)

- PLT-FL-001 (Một Cơ sở mã): Toàn bộ dự án (bao gồm KMS-Manager, KMS-Staff, KMS-Customer) phải được phát triển từ một (1) cơ sở mã Flutter duy nhất. Phải sử dụng các kỹ thuật (ví dụ: 'flavors' hoặc 'entrypoints') để biên dịch ra các ứng dụng đích riêng biệt.3
- PLT-FL-002 (UI Thích ứng - Adaptive UI): Giao diện người dùng phải có khả năng thích ứng để phù hợp với quy ước thiết kế của nền tảng.26

  - Trên Android/Windows, hệ thống phải ưu tiên sử dụng các widget theo phong cách Material Design (ví dụ: AlertDialog, Switch).26
  - Trên iOS, các thành phần tương tác cơ bản (nút, công tắc, hộp thoại) phải tự động điều chỉnh sang phong cách Cupertino (ví dụ: CupertinoAlertDialog, Switch.adaptive) để mang lại cảm giác "native" cho người dùng.26

- PLT-FL-003 (Kênh Nền tảng - Platform Channels): Hệ thống phải sử dụng cơ chế Platform Channels (hoặc FFI) của Flutter để gọi bất kỳ mã nguồn gốc (native) nào (Java/Kotlin trên Android, Swift/Objective-C trên iOS, C++ trên Windows) khi cần thiết cho các tính năng không được Flutter hỗ trợ sẵn.30
- PLT-FL-004 (Tích hợp Firebase): Hệ thống phải sử dụng bộ SDK FlutterFire (bộ thư viện Firebase chính thức cho Flutter) để tích hợp với tất cả các dịch vụ backend của Firebase.

### 4.2. Windows (KMS-Manager)

Ứng dụng Windows là một ứng dụng POS "hạng nặng" (heavy-duty), đòi hỏi hiệu suất và khả năng tích hợp phần cứng mà ứng dụng di động không có. Nó phải hoạt động như một ứng dụng desktop thực thụ.

- PLT-WIN-001 (Biên dịch Gốc): Ứng dụng phải được biên dịch thành tệp .exe chạy gốc trên Windows, sử dụng trình biên dịch C++ của Flutter, để đảm bảo hiệu suất tối đa và không phụ thuộc vào trình duyệt.6
- PLT-WIN-002 (Tối ưu hóa Desktop): Giao diện (ví dụ: sơ đồ phòng, bảng biểu báo cáo) phải được tối ưu hóa cho màn hình lớn, hỗ trợ đầy đủ tương tác bằng chuột, bàn phím (phím tắt) và màn hình cảm ứng (nếu có).23
- PLT-WIN-003 (Tích hợp Phần cứng): Phải sử dụng Platform Channels 30 để giao tiếp với các API hệ thống Win32/C++ 19 nhằm mục đích:

  - Điều khiển máy in hóa đơn nhiệt qua cổng USB, LAN hoặc COM.24
  - Gửi lệnh mở ngăn kéo tiền mặt (thường kết nối qua máy in).

- PLT-WIN-004 (Hệ thống Tệp): Phải có khả năng truy cập hệ thống tệp của Windows để thực hiện các tác vụ như xuất báo cáo ra file Excel/CSV (FR-REPORT).
- PLT-WIN-005 (Đa cửa sổ): (Nâng cao) Ứng dụng nên hỗ trợ đa cửa sổ (multi-window), cho phép người quản lý mở cửa sổ báo cáo trong khi cửa sổ POS chính vẫn hoạt động.
- PLT-WIN-006 (Firebase trên Windows): Ứng dụng KMS-Manager (Windows) phải sử dụng các thư viện FlutterFire được hỗ trợ cho Windows để kết nối và đồng bộ hóa dữ liệu với Cloud Firestore và Firebase Authentication.

### 4.3. Android & iOS (KMS-Staff & KMS-Customer)

- PLT-MOB-001 (Phần cứng Di động): Ứng dụng (đặc biệt là KMS-Customer) phải có khả năng truy cập phần cứng của thiết bị di động 32:

  - Camera: Để quét mã QR (kết nối phòng).

- PLT-MOB-002 (Thông báo Đẩy): Ứng dụng KMS-Staff phải hỗ trợ đầy đủ Thông báo Đẩy (Push Notifications) (sử dụng Firebase Cloud Messaging - FCM) để nhận các yêu cầu dịch vụ (FR-STAFF-006) và các cảnh báo từ quản lý.33
- PLT-MOB-003 (Kết nối Mạng): Ứng dụng KMS-Customer phải có khả năng quét và kết nối với mạng Wi-Fi cục bộ để giao tiếp với các dịch vụ Firebase.

-----

## 5. Yêu cầu Phi chức năng (Non-Functional Requirements)

Đây là các tiêu chuẩn về chất lượng, hiệu suất và bảo mật mà hệ thống phải tuân thủ.16

### 5.1. NFR-PERF: Yêu cầu về Hiệu suất

- NFR-PERF-001 (Tốc độ Khung hình): Mọi tương tác giao diện người dùng (cuộn, chuyển trang, hoạt ảnh) trên tất cả các nền tảng phải đạt tốc độ khung hình tối thiểu 60 FPS (khung hình/giây).34 Trên các thiết bị hỗ trợ (ví dụ: iPad Pro, điện thoại 120Hz), hệ thống phải cố gắng đạt 120 FPS để đảm bảo trải nghiệm mượt mà nhất.34
- NFR-PERF-002 (Thời gian Phản hồi):

  - Thời gian khởi động ứng dụng (cold start): Phải dưới 3 giây.
  - Thời gian tải sơ đồ phòng (KMS-Manager): Phải dưới 2 giây (ngay cả với 100 phòng, sử dụng dữ liệu từ bộ đệm của Firestore).
  - Thời gian gửi order F&B (KMS-Staff): Phải dưới 1 giây (ghi vào bộ đệm ngoại tuyến của Firestore).

- NFR-PERF-003 (Tối ưu hóa Flutter): Mã nguồn phải tuân thủ các thực hành tốt nhất về hiệu suất của Flutter 35:

  - Sử dụng `const` widgets ở mọi nơi có thể để giảm thiểu việc rebuild.
  - Quản lý state một cách hiệu quả (tránh `setState` toàn bộ cây widget khi không cần thiết).
  - Sử dụng `ListView.builder` và `GridView.builder` cho các danh sách dài (lịch sử giao dịch).35
  - Tối ưu hóa kích thước và sử dụng bộ đệm (caching) cho hình ảnh (ví dụ: ảnh F&B).36

- NFR-PERF-004 (Xử lý Bất đồng bộ): Mọi tác vụ nặng (ví dụ: xuất file báo cáo lớn) phải được thực hiện trên một luồng nền (background isolate) để không làm "đơ" (jank) luồng UI chính.36

### 5.2. NFR-SEC: Yêu cầu về Bảo mật

Đây là yêu cầu phi chức năng quan trọng nhất đối với một hệ thống POS xử lý thanh toán và dữ liệu. Vi phạm bảo mật có thể gây thiệt hại tài chính và pháp lý nghiêm trọng.

- NFR-SEC-001 (Mã hóa Dữ liệu):

  - Hệ thống sẽ dựa vào Firebase để tự động xử lý mã hóa dữ liệu.
  - Trên đường truyền: Firebase tự động mã hóa tất cả dữ liệu trên đường truyền bằng HTTPS.17
  - Lúc nghỉ (At-rest): Dữ liệu trên Cloud Firestore và các dịch vụ khác của Firebase được tự động mã hóa ở phía máy chủ.

- NFR-SEC-002 (Bảo mật Mã nguồn):

  - Nghiêm cấm hardcode bất kỳ thông tin nhạy cảm nào (API keys, "secrets") trực tiếp trong mã nguồn Dart.15 Phải sử dụng biến môi trường (environment variables) hoặc tệp cấu hình được mã hóa.

- NFR-SEC-003 (Bảo mật Thanh toán):

  - Hệ thống phải tuân thủ PCI DSS (Tiêu chuẩn Bảo mật Dữ liệu Ngành Thẻ thanh toán).17
  - Hệ thống không bao giờ được lưu trữ toàn bộ dữ liệu thẻ tín dụng (số thẻ đầy đủ, CVV) trên Cloud Firestore. Quá trình xử lý thẻ phải được ủy quyền hoàn toàn cho một nhà cung cấp cổng thanh toán (payment gateway) tuân thủ P2PE.18

- NFR-SEC-004 (Bảo mật Mạng):

  - Phải triển khai Phân đoạn Mạng (Network Segmentation).39 Mạng Wi-Fi dành cho khách (để dùng KMS-Customer) phải được cách ly hoàn toàn khỏi mạng nội bộ (máy POS, máy in).

- NFR-SEC-005 (Kiểm soát Truy cập):

  - Hệ thống phải triển khai Kiểm soát Truy cập Dựa trên Vai trò (RBAC) bằng cách sử dụng Firebase Authentication và Quy tắc Bảo mật của Cloud Firestore (Firestore Security Rules).
  - Quy tắc bảo mật phải được viết một cách cẩn thận để thực thi ma trận RBAC (Bảng 2), đảm bảo người dùng chỉ có thể đọc/ghi dữ liệu mà họ được phép truy cập.

- NFR-SEC-006 (Cập nhật): Hệ thống phải có cơ chế cập nhật phần mềm (ứng dụng Flutter, hệ điều hành) để vá các lỗ hổng bảo mật mới nhất.38

### 5.3. NFR-USE: Yêu cầu về Khả năng sử dụng (Usability)

- NFR-USE-001 (KMS-Manager): Giao diện trên Windows phải trực quan, rõ ràng. Một thu ngân mới phải có thể được đào tạo và sửn dụng thành thạo các thao tác cơ bản (check-in, check-out, order) trong vòng dưới 1 giờ.6
- NFR-USE-002 (KMS-Staff): Giao diện trên di động cho nhân viên phải được tối ưu hóa cho tốc độ và sử dụng bằng một tay. Các nút bấm phải lớn, quy trình order phải giảm thiểu số lần nhấp (clicks).
- NFR-USE-003 (KMS-Customer): Giao diện cho khách hàng phải thân thiện, dễ sử dụng cho mọi đối tượng, kể cả những người không rành về công nghệ.
- NFR-USE-004 (Tính nhất quán): Hệ thống phải duy trì tính nhất quán về thuật ngữ, biểu tượng và luồng nghiệp vụ trên cả 3 nền tảng (Windows, iOS, Android).3

### 5.4. NFR-REL: Yêu cầu về Độ tin cậy (Reliability)

- NFR-REL-001 (Chế độ Offline của Firebase):

  - Một quán karaoke không thể ngừng hoạt động chỉ vì mất kết nối Internet. Đây là một yêu cầu sống còn.
  - Hệ thống phải tận dụng tối đa khả năng duy trì dữ liệu ngoại tuyến (offline persistence) được tích hợp sẵn của Cloud Firestore trên tất cả các nền tảng (Android, iOS và Windows).
  - Yêu cầu: Khi được bật, Cloud Firestore phải tự động lưu trữ dữ liệu vào bộ đệm cục bộ (local cache). Các ứng dụng (KMS-Manager, KMS-Staff) phải có khả năng tiếp tục thực hiện các nghiệp vụ cốt lõi (Check-in, Check-out, Order F&B) ngay cả khi mất kết nối Internet tạm thời.
  - Yêu cầu: Dữ liệu được ghi khi ngoại tuyến phải tự động đồng bộ hóa (sync) với máy chủ Cloud Firestore ngay khi kết nối được khôi phục, mà không cần can thiệp thủ công.

- NFR-REL-002 (Sao lưu Dữ liệu): Firebase cung cấp các cơ chế sao lưu tự động (automatic backups) và Phục hồi tại một thời điểm (Point-in-Time Recovery - PITR). Quản trị viên hệ thống phải cấu hình các tính năng này để đề phòng mất mát dữ liệu.

### 5.5. NFR-MAINT: Yêu cầu về Khả năng Bảo trì

- NFR-MAINT-001 (Chất lượng Mã nguồn): Mã nguồn Flutter phải tuân thủ nghiêm ngặt các tiêu chuẩn (ví dụ: Effective Dart), được tổ chức theo một kiến trúc phần mềm rõ ràng (ví dụ: Clean Architecture, MVVM) và có bình luận (comment) đầy đủ.
- NFR-MAINT-0Vaw2X5Q-UkQ5uCzRfYXpdzArn)
2.  How to write system requirement specification (SRS) documents - Jama Software, accessed November 11, 2025, [https://www.jamasoftware.com/requirements-management-guide/writing-requirements/how-to-write-system-requirement-specification-srs-documents/](https://www.google.com/url?q=https://www.jamasoftware.com/requirements-management-guide/writing-requirements/how-to-write-system-requirement-specification-srs-documents/&sa=D&source=editors&ust=1762953627463834&usg=AOvVaw2PLv-zVC892uwJK4eRKgV5)
3.  Multi-Platform - Flutter, accessed November 11, 2025, [https://flutter.dev/multi-platform](https://www.google.com/url?q=https://flutter.dev/multi-platform&sa=D&source=editors&ust=1762953627464136&usg=AOvVaw3gSfOleMol-YLf3IfpPm_Q)
4.  Flutter - Build apps for any screen, accessed November 11, 2025, [https://flutter.dev/](https://www.google.com/url?q=https://flutter.dev/&sa=D&source=editors&ust=1762953627464365&usg=AOvVaw1iMIj07zfUJv6pJSGx2VVq)
5.  Phần mềm quản lý quán karaoke - MekongSoft, accessed November 11, 2025, [https://mekongsoft.com.vn/tin-tuc/phan-mem/phan-mem-quan-ly-quan-karaoke-a33](https://www.google.com/url?q=https://mekongsoft.com.vn/tin-tuc/phan-mem/phan-mem-quan-ly-quan-karaoke-a33&sa=D&source=editors&ust=1762953627464630&usg=AOvVaw3uGoKRVFZNKjQUB9SAUTS6)
6.  Phần mềm quản lý phòng Karaoke, accessed November 11, 2025, [https://www.winta.com.vn/Tin-tuc-moi/58/phan-mem-quan-ly-phong-karaoke.html](https://www.google.com/url?q=https://www.winta.com.vn/Tin-tuc-moi/58/phan-mem-quan-ly-phong-karaoke.html&sa=D&source=editors&ust=1762953627464877&usg=AOvVaw13MKdFm222K25XxsT5IAiW)
7.  Phần mềm quản lý khách sạn (Hotel) / Nhà nghỉ / Karaoke Lihasoft, accessed November 11, 2025, [https://lihasoft.vn/phan-mem-quan-ly-khach-san-hotel-nha-nghi-lihasoft/](https://www.google.com/url?q=https://lihasoft.vn/phan-mem-quan-ly-khach-san-hotel-nha-nghi-lihasoft/&sa=D&source=editors&ust=1762953627465187&usg=AOvVaw2l1RkfvJkuxSQtvQKPZGyp)
8.  Top phần mềm quản lý tính tiền karaoke tốt nhất hiện nay - FPT Shop, accessed November 11, 2025, [https://fptshop.com.vn/tin-tuc/danh-gia/phan-mem-quan-ly-tinh-tien-karaoke-166456](https://www.google.com/url?q=https://fptshop.com.vn/tin-tuc/danh-gia/phan-mem-quan-ly-tinh-tien-karaoke-166456&sa=D&source=editors&ust=1762953627465443&usg=AOvVaw3CRwaFqBuYCTWvGrLkcG-L)
9.  Review top 5 phần mềm quản lý quán Karaoke phổ biến nhất hiện nay - KiotViet, accessed November 11, 2025, [https://www.kiotviet.vn/review-top-5-phan-mem-quan-ly-quan-karaoke-pho-bien-nhat-hien-nay/](https://www.google.com/url?q=https://www.kiotviet.vn/review-top-5-phan-mem-quan-ly-quan-karaoke-pho-bien-nhat-hien-nay/&sa=D&source=editors&ust=1762953627465713&usg=AOvVaw3MN1GHvMVjNusIj2uZMStN)
    1S-Template: A markdown template for Software Requirements Specification based on IEEE 830 and ISO/IEC/IEEE 29148:2011 - GitHub, accessed November 11, 2025, [https://github.com/jam01/SRS-Template](https://www.google.com/url?q=https://github.com/jam01/SRS-Template&sa=D&source=editors&ust=1762953627469545&usg=AOvVaw0RNUW5gj7fDDxjkueAxvBn)
21. Phân Tích Hệ Thống Quản Lý Quán Karaoke Giảng Viên:Nguyễn Văn Danh, accessed November 11, 2025, [https://phantichthietkehethong.files.wordpress.com/2014/10/nhom3_lop13cd-tp2_lan2.pdf](https://www.google.com/url?q=https://phantichthietkehethong.files.wordpress.com/2014/10/nhom3_lop13cd-tp2_lan2.pdf&sa=D&source=editors&ust=1762953627469915&usg=AOvVaw3X5bQHMwaoX6Ap_WOZHSHj)
22. Professional Karaoke Software for Business | KaraokeMedia Pro X, accessed November 11, 2025, [https://www.karaokemedia.com/en/karaoke-software/](https://www.google.com/url?q=https://www.karaokemedia.com/en/karaoke-software/&sa=D&source=editors&ust=1762953627470133&usg=AOvVaw3gudzxttCcMcKDlXqe8BCA)
23. Video Hoster Karaoke Program for Professional or Home Use - MTU, accessed November 11, 2025, [http://www.mtu.com/basics/karaoke-hoster.htm](https://www.google.com/url?q=http://www.mtu.com/basics/karaoke-hoster.htm&sa=D&source=editors&ust=1762953627470334&usg=AOvVaw1uiRv87zCWTzwdnespXZ_q)
24. Phần mềm tính tiền Karaoke, accessed November 11, 2025, [https://vietbill.vn/gioi-thieu-phan-mem-quan-ly-tinh-tien-karaoke/](https://www.google.com/url?q=https://vietbill.vn/gioi-thieu-phan-mem-quan-ly-tinh-tien-karaoke/&sa=D&source=editors&ust=1762953627470525&usg=AOvVaw1OgShH7Uw2p3PAVUkAgp00)
25. TOP 11 phần mềm quản lý tính tiền karaoke miễn phí, tốt nhất - Thegioididong.com, accessed November 11, 2025, [https://www.thegioididong.com/game-app/top-11-phan-mem-quan-ly-tinh-tien-karaoke-mien-phi-tot-nhat-1372362](https://www.google.com/url?q=https://www.thegioididong.com/game-app/top-11-phan-mem-quan-ly-tinh-tien-karaoke-mien-phi-tot-nhat-1372362&sa=D&source=editors&ust=1762953627470822&usg=AOvVaw0ge0Q08TL7cxtNCi30LJYQ)
26. Cross-Platform UI Consistency with .adaptive Widgets in Flutter | by Shihab Ks - Medium, accessed November 11, 2025, [https://medium.com/@shihab.ks56/cross-platform-ui-consistency-with-adaptive-widgets-in-flutter-f96ac1fe80f5](https://www.google.com/url?q=https://medium.com/@shihab.ks56/cross-platform-ui-consistency-with-adaptive-widgets-in-flutter-f96ac1fe80f5&sa=D&source=editors&ust=1762953627471138&usg=AOvVaw3tg8aVjjGTVPGcSrw-WA5F)
27. Implement Adaptive UI in Flutter for Different Platforms - DEV Community, accessed November 11, 2025, [https://dev.to/saurabh-dhariwal/implement-adaptive-ui-in-flutter-for-different-platforms-11dc](https://www.google.com/url?q=https://dev.to/saurabh-dhariwal/implement-adaptive-ui-in-flutter-for-different-platforms-11dc&sa=D&source=editors&ust=1762953627471449&usg=AOvVaw1B2aFZYft3yMvUA_bZyapa)
28. UI consistency in Cross-platform Application in Flutter | by Pranav Jha - wesionaryTEAM, accessed November 11, 2025, [https://articles.wesionary.team/ui-consistency-in-cross-platform-application-in-flutter-7710fe57cb8b](https://www.google.com/url?q=https://articles.wesionary.team/ui-consistency-in-cross-platform-application-in-flutter-7710fe57cb8b&sa=D&source=editors&ust=1762953627471744&usg=AOvVaw3bFFMIEWL0HQr4sBZL1wmK)
29. Say Goodbye to Fragmented UX: How Flutter Ensures Uniform Design Across Devices, accessed November 11, 2025, [https://metadesignsolutions.com/say-goodbye-to-fragmented-ux-how-flutter-ensures-uniform-design-across-devices/](https://www.google.com/url?q=https://metadesignsolutions.com/say-goodbye-to-fragmented-ux-how-flutter-ensures-uniform-design-across-devices/&sa=D&source=editors&ust=1762953627472668&usg=AOvVaw1JkZsKRpBlbdXbnPpPYs5X)
30. Writing custom platform-specific code - Flutter documentation, accessed November 11, 2025, [https://docs.flutter.dev/platform-integration/platform-channels](https://www.google.com/url?q=https://docs.flutter.dev/platform-integration/platform-channels&sa=D&source=editors&ust=1762953627473005&usg=AOvVaw03El1ZV85p96w45fIaQ4vx)
31. What is the difference between Flutter for Web and for Mobile Apps? - Stack Overflow, accessed November 11, 2025, [https://stackoverflow.com/questions/65151339/what-is-the-difference-between-flutter-for-web-and-for-mobile-apps](https://www.google.com/url?q=https://stackoverflow.com/questions/65151339/what-is-the-difference-between-flutter-for-web-and-for-mobile-apps&sa=D&source=editors&ust=1762953627473653&usg=AOvVaw1hVlAeweh57XqbZafBLW6P)
32. Building a karaoke app with audio recording and playback in Flutter, accessed November 11, 2025, [https://colinchflutter.github.io/2023-09-18/08-57-18-066420-building-a-karaoke-app-with-audio-recording-and-playback-in-flutter/](https://www.google.com/url?q=https://colinchflutter.github.io/2023-09-18/08-57-18-066420-building-a-karaoke-app-with-audio-recording-and-playback-in-flutter/&sa=D&source=editors&ust=1762953627474050&usg=AOvVaw1tHdmLaCuo7-m7MWBllLgi)
33. How to Build a Karaoke App: 19 Steps - DevTeam.Space, accessed November 11, 2025, [https://www.devteam.space/blog/how-to-build-a-karaoke-app/](https://www.google.com/url?q=https://www.devteam.space/blog/how-to-build-a-karaoke-app/&sa=D&source=editors&ust=1762953627474261&usg=AOvVaw14T9HO2MgcF7dapWBMRC6c)
34. Flutter performance profiling, accessed November 11, 2025, [https://docs.flutter.dev/perf/ui-performance](https://www.google.com/url?q=https://docs.flutter.dev/perf/ui-performance&sa=D&source=editors&ust=1762953627474431&usg=AOvVaw2AdAVVgtQrcCnuaYEr-vQt)
35. Performance best practices - Flutter documentation, accessed November 11, 2025, [https://docs.flutter.dev/perf/best-practices](https://www.google.com/url?q=https://docs.flutter.dev/perf/best-practices&sa=D&source=editors&ust=1762953627474622&usg=AOvVaw14jFyiD77Tmle2cHOiUcQk)
36. Flutter App Performance: Optimization Guide & Best Practices, accessed November 11, 2025, [https://flutternest.com/blog/flutter-app-performance](https://www.google.com/url?q=https://flutternest.com/blog/flutter-app-performance&sa=D&source=editors&ust=1762953627474939&usg=AOvVaw2lHBmW2n0BHEhCAh3nTc86)
37. Flutter Performance Optimization Techniques & Best Practices - UXCam, accessed November 11, 2025, [https://uxcam.com/blog/flutter-performance-optimization/](https://www.google.com/url?q=https://uxcam.com/blog/flutter-performance-optimization/&sa=D&source=editors&ust=1762953627476047&usg=AOvVaw16QDLFMss7T3s5Z3U0pAfn)
38. POS Security: 11 Best Practices For Running A Tight Ship In 2025 - The CFO Club, accessed November 11, 2025, [https://thecfoclub.com/operational-finance/pos-security/](https://www.google.com/url?q=https://thecfoclub.com/operational-finance/pos-security/&sa=D&source=editors&ust=1762953627476320&usg=AOvVaw3ywhns2E5VqhcW9mWZS5Y5)
39. What is POS Security? Guide to POS Security Measures - LincSell, accessed November 11, 2025, [https://lincsell.com/pos-security-measures/](https://www.google.com/url?q=httpss-Template: A markdown template for Software Requirements Specification based on IEEE 830 and ISO/IEC/IEEE 29148:2011 - GitHub, accessed November 11, 2025, [https://github.com/jam01/SRS-Template](https://www.google.com/url?q=https://github.com/jam01/SRS-Template&sa=D&source=editors&ust=1762953627469545&usg=AOvVaw0RNUW5gj7fDDxjkueAxvBn)
21. Phân Tích Hệ Thống Quản Lý Quán Karaoke Giảng Viên:Nguyễn Văn Danh, accessed November 11, 2025, [https://phantichthietkehethong.files.wordpress.com/2014/10/nhom3_lop13cd-tp2_lan2.pdf](https://www.google.com/url?q=https://phantichthietkehethong.files.wordpress.com/2014/10/nhom3_lop13cd-tp2_lan2.pdf&sa=D&source=editors&ust=1762953627469915&usg=AOvVaw3X5bQHMwaoX6Ap_WOZHSHj)
22. Professional Karaoke Software for Business | KaraokeMedia Pro X, accessed November 11, 2025, [https://www.karaokemedia.com/en/karaoke-software/](https://www.google.com/url?q=https://www.karaokemedia.com/en/karaoke-software/&sa=D&source=editors&ust=1762953627470133&usg=AOvVaw3gudzxttCcMcKDlXqe8BCA)
23. Video Hoster Karaoke Program for Professional or Home Use - MTU, accessed November 11, 2025, [http://www.mtu.com/basics/karaoke-hoster.htm](https://www.google.com/url?q=http://www.mtu.com/basics/karaoke-hoster.htm&sa=D&source=editors&ust=1762953627470334&usg=AOvVaw1uiRv87zCWTzwdnespXZ_q)
24. Phần mềm tính tiền Karaoke, accessed November 11, 2025, [https://vietbill.vn/gioi-thieu-phan-mem-quan-ly-tinh-tien-karaoke/](https://www.google.com/url?q=https://vietbill.vn/gioi-thieu-phan-mem-quan-ly-tinh-tien-karaoke/&sa=D&source=editors&ust=1762953627470525&usg=AOvVaw1OgShH7Uw2p3PAVUkAgp00)
25. TOP 11 phần mềm quản lý tính tiền karaoke miễn phí, tốt nhất - Thegioididong.com, accessed November 11, 2025, [https://www.thegioididong.com/game-app/top-11-phan-mem-quan-ly-tinh-tien-karaoke-mien-phi-tot-nhat-1372362](https://www.google.com/url?q=https://www.thegioididong.com/game-app/top-11-phan-mem-quan-ly-tinh-tien-karaoke-mien-phi-tot-nhat-1372362&sa=D&source=editors&ust=1762953627470822&usg=AOvVaw0ge0Q08TL7cxtNCi30LJYQ)
26. Cross-Platform UI Consistency with .adaptive Widgets in Flutter | by Shihab Ks - Medium, accessed November 11, 2025, [https://medium.com/@shihab.ks56/cross-platform-ui-consistency-with-adaptive-widgets-in-flutter-f96ac1fe80f5](https://www.google.com/url?q=https://medium.com/@shihab.ks56/cross-platform-ui-consistency-with-adaptive-widgets-in-flutter-f96ac1fe80f5&sa=D&source=editors&ust=1762953627471138&usg=AOvVaw3tg8aVjjGTVPGcSrw-WA5F)
27. Implement Adaptive UI in Flutter for Different Platforms - DEV Community, accessed November 11, 2025, [https://dev.to/saurabh-dhariwal/implement-adaptive-ui-in-flutter-for-different-platforms-11dc](https://www.google.com/url?q=https://dev.to/saurabh-dhariwal/implement-adaptive-ui-in-flutter-for-different-platforms-11dc&sa=D&source=editors&ust=1762953627471449&usg=AOvVaw1B2aFZYft3yMvUA_bZyapa)
28. UI consistency in Cross-platform Application in Flutter | by Pranav Jha - wesionaryTEAM, accessed November 11, 2025, [https://articles.wesionary.team/ui-consistency-in-cross-platform-application-in-flutter-7710fe57cb8b](https://www.google.com/url?q=https://articles.wesionary.team/ui-consistency-in-cross-platform-application-in-flutter-7710fe57cb8b&sa=D&source=editors&ust=1762953627471744&usg=AOvVaw3bFFMIEWL0HQr4sBZL1wmK)
    2s://lincsell.com/pos-security-measures/&sa=D&source=editors&ust=1762953627476519&usg=AOvVaw2MrPWTl-dAo3maeCFmNy14)