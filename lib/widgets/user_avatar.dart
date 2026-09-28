import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 24,
    this.showOnlineIndicator = false,
    this.isOnline = false,
  });

  final String imageUrl;
  final double radius;
  final bool showOnlineIndicator;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: colorScheme.primaryContainer,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: radius * 2,
              height: radius * 2,
              fit: BoxFit.cover,
              placeholder: (_, _) => Icon(
                Icons.person,
                size: radius,
                color: colorScheme.onPrimaryContainer,
              ),
              errorWidget: (_, _, _) => Icon(
                Icons.person,
                size: radius,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ),
        if (showOnlineIndicator)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: radius * 0.45,
              height: radius * 0.45,
              decoration: BoxDecoration(
                color: isOnline ? Colors.green : colorScheme.outline,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.surface,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
