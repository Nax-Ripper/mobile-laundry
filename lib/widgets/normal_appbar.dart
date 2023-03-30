import 'package:flutter/material.dart';

class NormalAppBar extends StatelessWidget with PreferredSizeWidget {
  String title;
  bool isCenter = false;
  NormalAppBar({
    Key? key,
    required this.title,
    required this.isCenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isCenter
          ? Center(
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.normal),
              ),
            )
          : Text(
              textAlign: TextAlign.center,
              title,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.normal),
            ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
