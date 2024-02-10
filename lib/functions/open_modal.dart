import 'package:flutter/material.dart';

class OpenModal {
  static Future<void> openModal(BuildContext context, Widget modal) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => modal,
    );
  }
}
