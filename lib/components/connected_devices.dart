import 'package:flutter/material.dart';
import 'package:flutter_tailwind_ui/flutter_tailwind_ui.dart';

class ConnectedDevices extends StatefulWidget {
  const ConnectedDevices();

  @override
  State<ConnectedDevices> createState() => ConnectedDevicesState();
}

class ConnectedDevicesState extends State<ConnectedDevices> {
  final controller = TFormController();

  /// Displays a dialog with the current values of the form fields.
  Future<void> showFieldValuesDialog() async {
    final values = controller.getTFormFieldValues();
    await TDialog.show<void>(
      context: context,
      builder: (context) {
        return TDialog(
          title: const Text('Form Field Values'),
          contentTextStyle: TTextStyle.text_sm.copyWith(
            color: context.tw.color.body,
          ),
          cancel: const Text('Close'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final entry in values.entries)
                Column(
                  children: [
                    Row(
                      children: [
                        TText('`${entry.key}`'),
                        const Spacer(),
                        TText('`${entry.value}`'),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TCard(
      /*header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Game controls'),
          TButton.filled(
            size: TWidgetSize.sm,
            onPressed: showFieldValuesDialog,
            child: const Text('Values'),
          ),
        ],
      ),*/
      child: TForm(
        controller: controller,
        child: Column(
          spacing: TSpace.v24,
          children: [
            TSlider(
              id: 'slider',
              label: const Text('Controller brightness'),
              initialValue: 0.75,
            ),
            /*TSlider(
              id: 'slider',
              label: const Text('Acceleration sensitivity'),
              initialValue: 0.75,
            ),
            TSlider(
              id: 'slider',
              label: const Text('Jolt sensitivity'),
              initialValue: 0.75,
            ),*/
            TCheckboxTile.card(
              id: 'checkbox-tile',
              color: Color(0xFF5A7813),
              title: const Text('Allow joining during active sessions'),
              affinity: TControlAffinity.trailing,
            ),

            /*TSwitchTile.card(
              id: 'switch-tile',
              initialValue: true,
              title: const Text('Accelerometer'),
              affinity: TControlAffinity.trailing,
            ),
            TSwitchTile.card(
              id: 'switch-tile',
              initialValue: true,
              title: const Text('Compass'),
              affinity: TControlAffinity.trailing,
            ),*/
            TExpand.width(
              child: TButton.soft(
                color: Color(0xFF94C11F),
                onPressed: () {
                  controller.reset();
                },
                child: const Text('Reset to default'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
