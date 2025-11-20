import 'package:flutter/material.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({Key? key}) : super(key: key);
}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T> {

  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            backgroundColor ?? Theme.of(context).snackBarTheme.backgroundColor,
      ),
    );
  }

  // Phương thức tiện ích để hiển thị Dialog thông báo
  Future<void> showAlertDialog({
    required String title,
    required String content,
    String confirmButtonText = 'OK',
    VoidCallback? onConfirm,
  }) async {
    return showDialog<void>(
      context: context, barrierDismissible: false, // User must tap button!
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(confirmButtonText),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onConfirm?.call();
              },
            ),
          ],
        );
      },
    );
  }

  // Phương thức tiện ích để ẩn bàn phím ảo
  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // Phương thức tiện ích để lấy kích thước màn hình
  Size get screenSize => MediaQuery.of(context).size;

  // Phương thức tiện ích để kiểm tra orientation
  bool get isPortrait =>
      MediaQuery.of(context).orientation == Orientation.portrait;

// Bạn có thể override các phương thức lifecycle ở đây nếu cần logic chung
// @override
// void initState() {
//   super.initState();
//   // Logic khởi tạo chung
// }

  @override
  void dispose() {
    // Logic dọn dẹp chung
    super.dispose();
  }
}
