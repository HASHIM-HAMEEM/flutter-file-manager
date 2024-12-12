// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeMode _themeMode = ThemeMode.system;
  double _fontSize = 16.0;
  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontFamily: 'Nothing'),
        ),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Settings
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Theme.of(context).dividerColor.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Theme',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontFamily: 'Nothing',
                        ),
                  ),
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Light'),
                  value: ThemeMode.light,
                  groupValue: _themeMode,
                  onChanged: (ThemeMode? value) {
                    if (value != null) {
                      setState(() {
                        _themeMode = value;
                      });
                    }
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Dark'),
                  value: ThemeMode.dark,
                  groupValue: _themeMode,
                  onChanged: (ThemeMode? value) {
                    if (value != null) {
                      setState(() {
                        _themeMode = value;
                      });
                    }
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('System'),
                  value: ThemeMode.system,
                  groupValue: _themeMode,
                  onChanged: (ThemeMode? value) {
                    if (value != null) {
                      setState(() {
                        _themeMode = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Font Size Slider
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Theme.of(context).dividerColor.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Font Size',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontFamily: 'Nothing',
                        ),
                  ),
                ),
                ListTile(
                  title: Text('${_fontSize.round()} px'),
                  subtitle: Slider(
                    value: _fontSize,
                    min: 12,
                    max: 24,
                    divisions: 12,
                    label: _fontSize.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Background Color
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Theme.of(context).dividerColor.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Background Color',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontFamily: 'Nothing',
                        ),
                  ),
                ),
                ListTile(
                  trailing: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onTap: () async {
                    final Color color = await showColorPickerDialog(
                      context,
                      _backgroundColor,
                      title: const Text('Pick a color'),
                    );
                    setState(() {
                      _backgroundColor = color;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Version and Credits
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Theme.of(context).dividerColor.withOpacity(0.2),
              ),
            ),
            child: const ListTile(
              title: Text(
                'Version',
                style: TextStyle(fontFamily: 'Nothing'),
              ),
              subtitle: Text('1.0.0'),
              trailing: Text(
                'fin.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nothing',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
