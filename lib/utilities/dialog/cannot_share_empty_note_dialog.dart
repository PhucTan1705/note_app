import 'package:flutter/material.dart';
import 'package:project_23/utilities/dialog/generic_dialog.dart';



Future<void> shoCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Chia sẽ',
    content: 'Không thể chia sẽ ghi chú trống',
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
