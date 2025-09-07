import 'package:flutter/material.dart';

class AnimatedMediaControl extends StatefulWidget {
  final double buttonHeight;

  const AnimatedMediaControl({
    Key? key,
    this.buttonHeight = 32.0,
  }) : super(key: key);

  @override
  State<AnimatedMediaControl> createState() => _AnimatedMediaControlState();
}

class _AnimatedMediaControlState extends State<AnimatedMediaControl>
    with TickerProviderStateMixin {
  MediaAction _selected = MediaAction.stop;

  late AnimationController _playPulse;
  late AnimationController _pauseBlink;
  late Animation<Color?> _playColor;
  late Animation<Color?> _pauseColor;

  @override
  void initState() {
    super.initState();

    // Play animation - slow pulse
    _playPulse = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _playColor = ColorTween(
      begin: const Color(0xFF95C11F),
      end: const Color(0x0095C11F),
    ).animate(CurvedAnimation(parent: _playPulse, curve: Curves.easeInOut));

    // Pause animation - smooth blink
    _pauseBlink = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _pauseColor = ColorTween(
      begin: const Color(0xFFFFD803),
      end: const Color(0x00FFD803),
    ).animate(CurvedAnimation(parent: _pauseBlink, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _playPulse.dispose();
    _pauseBlink.dispose();
    super.dispose();
  }

  void _updateSelection(MediaAction action) {
    setState(() {
      _selected = action;

      // Reset animations
      _playPulse.stop();
      _pauseBlink.stop();

      // Start the right animation
      if (action == MediaAction.play) {
        _playPulse.repeat(reverse: true);
      } else if (action == MediaAction.pause) {
        _pauseBlink.repeat(reverse: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.buttonHeight,
      child: AnimatedBuilder(
        animation: Listenable.merge([_playPulse, _pauseBlink]),
        builder: (context, _) {
          return Theme(
            data: Theme.of(context).copyWith(
              segmentedButtonTheme: SegmentedButtonThemeData(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(0, widget.buttonHeight),
                  ),
                  maximumSize: MaterialStateProperty.all(
                    Size(double.infinity, widget.buttonHeight),
                  ),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (!states.contains(MaterialState.selected)) {
                      return Colors.transparent;
                    }

                    // Return animated colors for selected buttons
                    switch (_selected) {
                      case MediaAction.play:
                        //return _playColor.value;
                        return Color(0xFF95C11F);
                      case MediaAction.pause:
                        return _pauseColor.value;
                      case MediaAction.stop:
                        return Color(0xFFEB5F5D);
                    }
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                    return states.contains(MaterialState.selected)
                        ? Colors.white
                        : Colors.black87;
                  }),
                ),
              ),
            ),
            child: SegmentedButton<MediaAction>(
              segments: [
                ButtonSegment(
                  value: MediaAction.play,
                  label: Text("Play"),
                  icon: const Icon(Icons.play_arrow),
                ),
                /*ButtonSegment(
                  value: MediaAction.pause,
                  label: Text("Pause"),
                  icon: const Icon(Icons.pause),
                  ),*/
                ButtonSegment(
                  value: MediaAction.stop,
                  label: Text("Stopped"),
                  icon: const Icon(Icons.stop),
                ),
              ],
              selected: {_selected},
              onSelectionChanged: (Set<MediaAction> selection) {
                if (selection.isNotEmpty) {
                  _updateSelection(selection.first);
                }
              },
              showSelectedIcon: false,
            ),
          );
        },
      ),
    );
  }
}

enum MediaAction { play, pause, stop }
