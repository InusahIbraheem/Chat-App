import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import 'app_footer.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.showFooter = true,
    this.backgroundColor,
    this.extendBodyBehindAppBar = false,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool showFooter;
  final Color? backgroundColor;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: Column(
        children: [
          Expanded(child: body),
          if (showFooter) const AppFooter(),
        ],
      ),
    );
  }
}

class CenteredContent extends StatelessWidget {
  const CenteredContent({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 960),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingMd,
              ),
          child: child,
        ),
      ),
    );
  }
}
