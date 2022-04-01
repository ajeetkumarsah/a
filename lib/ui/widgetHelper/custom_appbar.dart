import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;

  final List<Widget>? actions;
  const CustomAppBar(
      {Key? key, required this.title, this.leading, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: new Size.fromHeight(120),
      child: Material(
        elevation: 1,
        child: Container(
          color: Colors.white,
          height: 90,
          alignment: Alignment.bottomLeft,
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 15.0, right: 8.0),
            leading: leading != null
                ? leading
                : IconButton(
                    onPressed: () => Navigator.pop(context, false),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
            title: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            trailing: Container(
              padding: EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: actions ?? const <Widget>[],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(120);
}
