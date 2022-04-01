import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:shimmer/shimmer.dart';

class FormLoader extends StatelessWidget {
  const FormLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            ListView.builder(
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: grey.withOpacity(0.4),
                            highlightColor: white,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 10,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: appColor.grey,
                                  borderRadius: BorderRadius.circular(4.0)),
                            ),
                          ),
                          SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: grey.withOpacity(0.4),
                            highlightColor: white,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 45,
                              decoration: BoxDecoration(
                                  color: appColor.grey,
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Row(
                                children: [],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            ListView.builder(
                itemCount: 10,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Shimmer.fromColors(
                      baseColor: grey.withOpacity(0.4),
                      highlightColor: white,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: appColor.grey,
                                borderRadius: BorderRadius.circular(4.0)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 10,
                            width: 100,
                            decoration: BoxDecoration(
                                color: appColor.grey,
                                borderRadius: BorderRadius.circular(4.0)),
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
