import 'package:flutter/material.dart';
import 'package:project_23/utilities/dialog/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'Đã có lỗi xảy ra',
    content: text,
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
