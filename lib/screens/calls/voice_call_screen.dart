import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/format_utils.dart';
import '../../services/chat_service.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/user_avatar.dart';

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({super.key, required this.userId});

  final String userId;

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  Duration _callDuration = Duration.zero;
  Timer? _timer;
  bool _isMuted = false;
  bool _isSpeakerOn = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _callDuration += const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final user = ChatService.instance.getUserById(widget.userId);

    if (user == null) {
      return AppScaffold(
        appBar: AppBar(title: const Text('Voice Call')),
        body: const Center(child: Text('User not found')),
      );
    }

    return AppScaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primaryContainer,
              colorScheme.surface,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserAvatar(
              imageUrl: user.avatarUrl,
              radius: 64,
              showOnlineIndicator: true,
              isOnline: user.isOnline,
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.05, 1.05),
                  duration: 1500.ms,
                ),
            const SizedBox(height: AppConstants.spacingLg),
            Text(
              user.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              FormatUtils.formatCallDuration(_callDuration),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingXl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _CallActionButton(
                  icon: _isMuted ? Icons.mic_off : Icons.mic,
                  label: _isMuted ? 'Unmute' : 'Mute',
                  isActive: _isMuted,
                  onPressed: () => setState(() => _isMuted = !_isMuted),
                ),
                const SizedBox(width: AppConstants.spacingLg),
                _CallActionButton(
                  icon: Icons.call_end,
                  label: 'End',
                  isDestructive: true,
                  onPressed: () => context.pop(),
                ),
                const SizedBox(width: AppConstants.spacingLg),
                _CallActionButton(
                  icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                  label: 'Speaker',
                  isActive: _isSpeakerOn,
                  onPressed: () =>
                      setState(() => _isSpeakerOn = !_isSpeakerOn),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CallActionButton extends StatelessWidget {
  const _CallActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isActive = false,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isActive;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = isDestructive
        ? Colors.red
        : isActive
            ? colorScheme.primary
            : colorScheme.surfaceContainerHighest;

    final iconColor = isDestructive || isActive
        ? Colors.white
        : colorScheme.onSurface;

    return Column(
      children: [
        Material(
          color: backgroundColor,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(icon, color: iconColor, size: 28),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingSm),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
