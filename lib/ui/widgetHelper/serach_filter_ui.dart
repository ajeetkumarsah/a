import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:salessimplify/controller/color.dart';

class SearchFilterUI extends StatelessWidget {
  final Function() filterOnPressed;
  final Function() searchOnTap;
  final String text;

  const SearchFilterUI(
      {Key? key,
      required this.filterOnPressed,
      required this.searchOnTap,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: InkWell(
          onTap: searchOnTap,
          child: Container(
            height: 35,
            child: TextFormField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                prefixIcon: Icon(
                  Boxicons.bx_search_alt,
                  color: white,
                ),
                hintText: text,
                hintStyle: TextStyle(color: white),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide.none),
                fillColor: white.withOpacity(0.6),
                filled: true,
                enabled: false,
              ),
            ),
          ),
        )),
        SizedBox(width: 15),
        Builder(
          builder: (context) => Container(
            height: 35,
            width: 35,
            padding: EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: IconButton(
              icon: Icon(
                Boxicons.bx_slider_alt,
                color: blueColor,
                size: 20,
              ),
              onPressed: filterOnPressed,
            ),
          ),
        )
      ],
    );
  }
}
