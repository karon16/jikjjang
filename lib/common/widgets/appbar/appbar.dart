import 'package:flutter/material.dart';
import 'package:jikjjang_app/utils/constants/sizes.dart';
import 'package:jikjjang_app/utils/device/device_utility.dart';

class JAppBar extends StatelessWidget implements PreferredSizeWidget {
  const JAppBar({
    super.key,
    this.title,
    this.showBackArrow = true,
    this.leadingWidget,
    this.onLeadingPressed,
    required this.actions,
    this.bottom,
    this.route,
  });

  final Widget? title;
  final bool showBackArrow;
  final Widget? leadingWidget;
  final VoidCallback? onLeadingPressed;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: _buildLeading(context),
      leadingWidth: 75, // Adjusted to prevent overflow
      title: title != null
          ? Padding(
              padding: const EdgeInsets.only(right: JSizes.paddingMD),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: JSizes.font18,
                    ),
                child: title!,
              ),
            )
          : null,
      actions: actions,
      toolbarHeight: _calculateToolbarHeight(),
      elevation: 0,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      centerTitle: false,
      bottom: bottom,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (showBackArrow) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
            FocusScope.of(context).unfocus(); // Removes focus from text field
            Navigator.pushReplacementNamed(context, route ?? '/');
            // Navigator.pop(context); // Go back to the previous screen
          }
      );
    } else if (leadingWidget != null) {
      return leadingWidget;
    }
    return null;
  }

  @override
  Size get preferredSize => Size.fromHeight(_calculateToolbarHeight());

  double _calculateToolbarHeight() {
    double baseHeight = JDeviceUtility.getAppBarHeight();
    return bottom != null
        ? baseHeight + bottom!.preferredSize.height
        : baseHeight;
  }
}
