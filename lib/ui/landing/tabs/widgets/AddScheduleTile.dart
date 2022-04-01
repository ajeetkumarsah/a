import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddScheduleTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
      ),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(6),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          child: Container(
            padding: EdgeInsets.all(14),
            color: Color(0xff100000e6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    right: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xff1a1aff),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Add New Schedule ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff1a1aff),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
