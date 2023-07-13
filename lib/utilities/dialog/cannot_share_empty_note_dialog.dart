import 'package:flutter/material.dart';
import 'package:project_23/extensions/buildcontext/loc.dart';
import 'package:project_23/utilities/dialog/generic_dialog.dart';



Future<void> shoCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: context.loc.sharing,
    content: context.loc.cannot_share_empty_note_prompt,
    optionsBuilder: () => {
      context.loc.ok: null,
    },
  );
}
