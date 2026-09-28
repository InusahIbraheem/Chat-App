import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_routes.dart';
import '../../widgets/app_scaffold.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notificationsEnabled = true;
  bool _readReceipts = true;
  bool _lastSeen = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _SettingsSection(
            title: 'Appearance',
            children: [
              SwitchListTile(
                secondary: Icon(Icons.dark_mode_outlined, color: colorScheme.primary),
                title: const Text('Dark mode'),
                subtitle: const Text('Use dark theme'),
                value: _darkMode,
                onChanged: (value) => setState(() => _darkMode = value),
              ),
            ],
          ),
          _SettingsSection(
            title: 'Notifications',
            children: [
              SwitchListTile(
                secondary: Icon(Icons.notifications_outlined, color: colorScheme.primary),
                title: const Text('Push notifications'),
                subtitle: const Text('Receive message alerts'),
                value: _notificationsEnabled,
                onChanged: (value) =>
                    setState(() => _notificationsEnabled = value),
              ),
            ],
          ),
          _SettingsSection(
            title: 'Privacy',
            children: [
              SwitchListTile(
                secondary: Icon(Icons.done_all, color: colorScheme.primary),
                title: const Text('Read receipts'),
                subtitle: const Text('Show when messages are read'),
                value: _readReceipts,
                onChanged: (value) => setState(() => _readReceipts = value),
              ),
              SwitchListTile(
                secondary: Icon(Icons.visibility_outlined, color: colorScheme.primary),
                title: const Text('Last seen'),
                subtitle: const Text('Show your online status'),
                value: _lastSeen,
                onChanged: (value) => setState(() => _lastSeen = value),
              ),
            ],
          ),
          _SettingsSection(
            title: 'Account',
            children: [
              ListTile(
                leading: Icon(Icons.lock_outline, color: colorScheme.primary),
                title: const Text('Change password'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout, color: colorScheme.error),
                title: Text(
                  'Log out',
                  style: TextStyle(color: colorScheme.error),
                ),
                onTap: () => context.go(AppRoutes.login),
              ),
            ],
          ),
          _SettingsSection(
            title: 'About',
            children: [
              ListTile(
                leading: Icon(Icons.info_outline, color: colorScheme.primary),
                title: const Text('App version'),
                subtitle: const Text('1.0.0'),
              ),
              ListTile(
                leading: Icon(Icons.code, color: colorScheme.primary),
                title: const Text('Developer'),
                subtitle: Text(AppConstants.developerCredit),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppConstants.spacingMd,
            AppConstants.spacingLg,
            AppConstants.spacingMd,
            AppConstants.spacingSm,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        ...children,
        const Divider(height: 1),
      ],
    );
  }
}
