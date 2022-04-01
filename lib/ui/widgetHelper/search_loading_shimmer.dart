import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:shimmer/shimmer.dart';

class SearchLoadingListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext bc, int i) {
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            leading: Shimmer.fromColors(
              baseColor: grey.withOpacity(0.4),
              highlightColor: white,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
            title: Shimmer.fromColors(
              baseColor: grey.withOpacity(0.4),
              highlightColor: white,
              child: Container(
                width: 150,
                height: 10,
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            subtitle: Shimmer.fromColors(
              baseColor: grey.withOpacity(0.4),
              highlightColor: white,
              child: Container(
                width: 300,
                height: 5,
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

SearchLoadingListShimmer searchLoadingListShimmer =
    new SearchLoadingListShimmer();
