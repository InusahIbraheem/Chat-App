import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/format_utils.dart';
import '../../services/chat_service.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/user_avatar.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key, required this.userId});

  final String userId;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  Duration _callDuration = Duration.zero;
  Timer? _timer;
  bool _isMuted = false;
  bool _isCameraOff = false;

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
        appBar: AppBar(title: const Text('Video Call')),
        body: const Center(child: Text('User not found')),
      );
    }

    return AppScaffold(
      extendBodyBehindAppBar: true,
      showFooter: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name),
            Text(
              FormatUtils.formatCallDuration(_callDuration),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: colorScheme.primaryContainer.withValues(alpha: 0.3),
            child: Center(
              child: UserAvatar(
                imageUrl: user.avatarUrl,
                radius: 80,
              ).animate(onPlay: (c) => c.repeat(reverse: true)).fade(
                    begin: 0.8,
                    end: 1,
                    duration: 2000.ms,
                  ),
            ),
          ),
          Positioned(
            top: AppConstants.spacingMd,
            right: AppConstants.spacingMd,
            child: Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                border: Border.all(color: Colors.white24),
              ),
              child: _isCameraOff
                  ? const Center(
                      child: Icon(Icons.videocam_off, color: Colors.white54),
                    )
                  : ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                      child: UserAvatar(
                        imageUrl: ChatService.instance.currentUser.avatarUrl,
                        radius: 60,
                      ),
                    ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: AppConstants.spacingXl + MediaQuery.paddingOf(context).bottom,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _VideoControlButton(
                  icon: _isMuted ? Icons.mic_off : Icons.mic,
                  onPressed: () => setState(() => _isMuted = !_isMuted),
                  isActive: _isMuted,
                ),
                const SizedBox(width: AppConstants.spacingMd),
                _VideoControlButton(
                  icon: Icons.call_end,
                  onPressed: () => context.pop(),
                  isDestructive: true,
                ),
                const SizedBox(width: AppConstants.spacingMd),
                _VideoControlButton(
                  icon: _isCameraOff ? Icons.videocam_off : Icons.videocam,
                  onPressed: () =>
                      setState(() => _isCameraOff = !_isCameraOff),
                  isActive: _isCameraOff,
                ),
                const SizedBox(width: AppConstants.spacingMd),
                _VideoControlButton(
                  icon: Icons.cameraswitch,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: AppConstants.spacingSm,
            child: Text(
              AppConstants.developerCredit,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white54,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoControlButton extends StatelessWidget {
  const _VideoControlButton({
    required this.icon,
    required this.onPressed,
    this.isActive = false,
    this.isDestructive = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool isActive;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDestructive
        ? Colors.red
        : isActive
            ? Colors.white24
            : Colors.white.withValues(alpha: 0.15);

    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
      ),
    );
  }
}
