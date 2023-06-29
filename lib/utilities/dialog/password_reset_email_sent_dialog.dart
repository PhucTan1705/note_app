import 'package:flutter/material.dart';
import 'package:project_23/utilities/dialog/generic_dialog.dart';

Future<void> showPasswordResetDialog(BuildContext context){
  return showGenericDialog<void>(
    context: context, 
    title: "Đặt Lại Mật Khẩu", 
    content: 'Chúng Tôi Đã Gửi Đường Link Đặt Lại Mật Khẩu, Xin Kiểm Tra Email', 
    optionsBuilder:() => {
      'OK' : null,
    },
  );
}