import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    Key? key,
    this.title = '-',
    this.subtitle = '-',
    this.icon = Icons.home,
    this.sideColor,
    this.padding,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;
  final Color? sideColor;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Ink(
        decoration: BoxDecoration(
          color: sideColor ?? primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            bottomLeft: Radius.circular(4.0),
            topRight: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              color: black.withOpacity(.25),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Ink(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
            child: ListTile(
              onTap: onTap,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: sideColor),
                ],
              ),
              title: Text(
                title,
                style: bodyFont,
              ),
              subtitle: Text(
                subtitle,
                style: bodyFont.copyWith(
                  fontSize: 10.0,
                  color: grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
