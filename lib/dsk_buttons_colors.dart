import 'package:flutter/cupertino.dart';
import 'dsk_theme_manager.dart';
import 'dsk_theme_colors.dart';

// Copyright © 2023 Albert Palacios. All Rights Reserved.
// Licensed under the BSD 3-clause license, see LICENSE file for details.

/// Class `DSKButtonsColors` - A custom widget for displaying and selecting colors.
///
/// This widget creates a row of color options, allowing the user to select a color.
///
/// Parameters:
/// * `colors`: (Map<String, Color>) A map of color names to their respective color values.
/// * `selectedColor`: (String) The name of the currently selected color.
/// * `onColorChanged`: (Function(String)?) Callback called when a color is selected.

class DSKButtonsColors extends StatefulWidget {
  /// Map of color names to color values.
  final Map<String, Color> colors;

  /// Name of the currently selected color.
  final String selectedColor;

  /// Callback for color selection.
  final Function(String)? onColorChanged;

  const DSKButtonsColors({
    Key? key,
    required this.colors,
    this.selectedColor = "systemBlue",
    this.onColorChanged,
  }) : super(key: key);

  @override
  DSKButtonsColorsState createState() => DSKButtonsColorsState();
}

/// Class `DSKButtonsColorsState` - The state for `DSKButtonsColors`.
///
/// Manages the rendering of the color selection buttons.
class DSKButtonsColorsState extends State<DSKButtonsColors> {
  String _selectedColor = "";

  @override
  void initState() {
    super.initState();
    DSKThemeManager().addListener(_update);
    _selectedColor = widget.selectedColor;
  }

  @override
  void dispose() {
    DSKThemeManager().removeListener(_update);
    super.dispose();
  }

  void _update() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    DSKThemeManager themeManager = DSKThemeManager();
    // Index to keep track of each color's position.
    int index = -1;
    return Row(
      children: widget.colors.entries.map((entry) {
        final String colorName = entry.key;
        final Color color = entry.value;
        Color colorBorder = color;

        // Adjust the border color based on the theme and color brightness.
        if (themeManager.isLight) {
          colorBorder = DSKColors.adjustColor(color, 1, 0.75);
        } else {
          colorBorder = DSKColors.adjustColor(color, 1, 1.25);
        }
        index = index + 1;
        return GestureDetector(
          onTap: () {
            widget.onColorChanged?.call(colorName);
            setState(() {
              _selectedColor = colorName;
            });
          },
          child: Container(
            width: 16,
            height: 16,
            margin: index == 0 ? null : const EdgeInsets.only(left: 6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(color: colorBorder, width: 1.25),
            ),
            child: Center(
              child: _selectedColor == colorName
                  ? Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: DSKColors.white,
                      ),
                    )
                  : null, // Si no està seleccionat, no mostra res
            ),
          ),
        );
      }).toList(),
    );
  }
}
