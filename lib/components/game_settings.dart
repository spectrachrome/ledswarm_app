import 'package:flutter/material.dart';
import 'package:flutter_tailwind_ui/flutter_tailwind_ui.dart';

class GameSettings extends StatefulWidget {
  const GameSettings();

  @override
  State<GameSettings> createState() => GameSettingsState();
}

class GameSettingsState extends State<GameSettings> {
  final controller = TFormController();
  String selectedGameMode = "Last One Standing";

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

  Widget _buildConfigurationInterface() {
    switch (selectedGameMode) {
      case "Last One Standing":
        return _LastOneStandingConfig(key: const ValueKey('los'));
      case "Territory":
        return _TerritoryConfig(key: const ValueKey('territory'));
      case "Custom":
        return _CustomConfig(key: const ValueKey('custom'));
      default:
        return _LastOneStandingConfig(key: const ValueKey('default'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TCard(
      child: TForm(
        controller: controller,
        child: Column(
          spacing: TSpace.v24,
          children: [
            TSelect(
              id: 'select',
              label: const Text('Game mode'),
              initialValue: selectedGameMode,
              items: const ["Last One Standing", "Territory", "Custom"],
              onChanged: (value) {
                setState(() {
                  selectedGameMode = value as String;
                });
              },
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                  child: child,
                );
              },
              child: _buildConfigurationInterface(),
            ),
          ],
        ),
      ),
    );
  }
}

// Configuration widgets for each game mode
class _LastOneStandingConfig extends StatelessWidget {
  const _LastOneStandingConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 20 * 2,
      height: 200.0,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Colors.red.withOpacity(0.05),
            Colors.green.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.green.withOpacity(0.2), width: 1),
      ),
      child: Column(
        children: [
          Text(
            'Configure elimination-based gameplay settings',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _TerritoryConfig extends StatelessWidget {
  const _TerritoryConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 20 * 2,
      height: 200.0,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Colors.red.withOpacity(0.05),
            Colors.green.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.green.withOpacity(0.2), width: 1),
      ),
      child: Column(
        children: [
          Text(
            'Configure territory-based gameplay settings',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CustomConfig extends StatelessWidget {
  const _CustomConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 20 * 2,
      height: 200.0,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Colors.red.withOpacity(0.05),
            Colors.green.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.green.withOpacity(0.2), width: 1),
      ),
      child: Column(
        children: [
          Icon(Icons.tune, size: 32, color: Colors.purple.shade400),
          const SizedBox(height: 16),
          Text(
            'Custom Game Configuration',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.purple.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your own unique game rules',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
