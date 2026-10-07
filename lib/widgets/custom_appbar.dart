import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  final Widget? leading;
  final List<Widget>? action;
  final bool? centerTitle;
  final Color? color;
  const CustomAppbar({
    super.key,
    required this.title,
    this.centerTitle,
    this.leading,
    this.action,
    this.subTitle,
    this.color,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.color,
      toolbarHeight: 65,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 3),
          if (widget.subTitle != null)
            Text(
              widget.subTitle!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
        ],
      ),
      leading: widget.leading,
      actions: widget.action,
      centerTitle: widget.centerTitle ?? false,
    );
  }
}
