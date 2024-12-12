// lib/widgets/color_picker_dialog.dart
import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class ColorPickerDialog extends StatelessWidget {
  final Function(Color) onColorSelected;

  const ColorPickerDialog({
    Key? key,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick Background Color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          color: Theme.of(context).scaffoldBackgroundColor,
          onColorChanged: (Color color) {
            onColorSelected(color);
          },
          width: 40,
          height: 40,
          borderRadius: 4,
          spacing: 5,
          runSpacing: 5,
          wheelDiameter: 155,
          heading: Text(
            'Select color',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subheading: Text(
            'Select color shade',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Done'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
