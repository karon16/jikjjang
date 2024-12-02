import 'package:flutter/material.dart';
import 'package:jikjjang_app/utils/device/device_utility.dart';

class JAppBar extends StatelessWidget implements PreferredSizeWidget {
  const JAppBar({
    super.key,
    this.title,
    this.showBackArrow = true,
    this.leadingWidget,
    this.onLeadingPressed,
    required this.actions,
  });

  final Widget? title;
  final bool showBackArrow;
  final Widget? leadingWidget;
  final VoidCallback? onLeadingPressed;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: _buildLeading(context),
      leadingWidth: 75, // Adjusted to prevent overflow
      title: title != null
          ? Flexible(
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.headlineMedium!,
                overflow: TextOverflow.ellipsis, // Handle long titles
                child: title!,
              ),
            )
          : null,
      // titleSpacing: 20,
      actions: actions,
      toolbarHeight: JDeviceUtility.getAppBarHeight(),
      elevation: 0,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      centerTitle: false,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (showBackArrow) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } else if (leadingWidget != null) {
      return leadingWidget;
    }
    return null;
  }

  @override
  Size get preferredSize => Size.fromHeight(JDeviceUtility.getAppBarHeight());
}
