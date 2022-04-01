import 'package:flutter/material.dart';

class ActivityListTile extends StatelessWidget {
  final IconData leadingIcon;
  final Color iconBgColor, iconColor;
  final String title, subtitle;

  ActivityListTile({
    required this.leadingIcon,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: SizedBox.fromSize(
          size: const Size(45, 45), // button width and height
          child: ClipOval(
            child: Material(
                color: iconBgColor, // button color
                child: Icon(leadingIcon,color: iconColor,)),
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.headline3,
        ),
        trailing: Checkbox(
          checkColor: Colors.white,
          value: true,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
