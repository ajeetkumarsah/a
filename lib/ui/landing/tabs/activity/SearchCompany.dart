import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/models/company.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/widget/FormTextField.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';

class SearchCompany extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  List<Company> result = [];
  bool isProcessing = false;
  // ignore: non_constant_identifier_names
  static String ROUTE_SEARCH_COMPANY_ACTIVITY = "route/SearchCompany";

  @override
  Widget build(BuildContext context) {
    isProcessing = context.watch<Repository>().isSearchCompanyProcessing;
    result = context.watch<Repository>().searchCompanyResult;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Search Company",
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                FormTextField(
                  hintText: "Search Here",
                  iconColor: Colors.blue,
                  iconData: Icons.search,
                  controller: _controller,
                  onTextChange: (String value) {
                    context
                        .read<Repository>()
                        .getCompanySearch(_controller.text);
                  },
                ),
                Container(
                  padding: EdgeInsets.all(
                    12,
                  ),
                  child: IconButton(
                    color: Colors.blue,
                    icon: Icon(Icons.close),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: isProcessing
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        context
                            .read<Repository>()
                            .setSelectedCompanySearch(result[index]);
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 16,
                              bottom: 4,
                            ),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white38,
                            ),
                            child: Text(
                              result[index].name,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
