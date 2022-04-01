import 'package:flutter/material.dart';
import 'package:salessimplify/constants/fieldinputtype.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/DealModel.dart';
import 'package:salessimplify/models/Leads.dart';
import 'package:salessimplify/models/PipelineModel.dart';
import 'package:salessimplify/models/company.dart';
import 'package:salessimplify/models/global_search.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/contact/orgDetails.dart';
import 'package:salessimplify/ui/landing/tabs/contact/peopledetails.dart';
import 'package:salessimplify/ui/landing/tabs/deal/deal_details_page.dart';
import 'package:salessimplify/ui/landing/tabs/lead/leaddetails.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/util/utils.dart';
import 'FormTextField.dart';
import 'empty_list_shimmer.dart';
import 'icon_button_helper.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  static String ROUTE_SEARCH = "route/SearchWidget";
  FieldInputType? inputType;

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _controller = new TextEditingController();
  GlobalSearchModel? globalSearchMode;
  bool isLoading = false;
  late DealModel dealmodel;

  getDealsWithDefaultId(BuildContext ctx) async {
    var data = await Repository.getInstance().getPipelines();
    if (data is List<PipelineModel> && (data).length > 0) {
      ctx.read<Repository>().getDeals(data[0].id);
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.inputType =
        ModalRoute.of(context)!.settings.arguments as FieldInputType;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 1,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: grey)),
        title: FormTextField(
          hintText: "Search Here",
          controller: _controller,
          onTextChange: onTextChange,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: white, width: 0.01),
            borderRadius: const BorderRadius.all(
              const Radius.circular(4.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: white, width: 0.01),
            borderRadius: const BorderRadius.all(
              const Radius.circular(4.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: white, width: 0.01),
            borderRadius: const BorderRadius.all(
              const Radius.circular(4.0),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: white, width: 0.01),
            borderRadius: const BorderRadius.all(
              const Radius.circular(4.0),
            ),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(
              12,
            ),
            child: IconButton(
              color: Colors.blue,
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _controller.clear();
                });
              },
            ),
          ),
        ],
      ),
      body: isLoading
          ? EmptyListShimmer(tab: 1)
          : globalSearchMode == null
              ? emptyListHelper.getEmptyList(EmptyListHelper.search, context)
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Company",
                          style: textHelper.style16,
                        ),
                      ),
                      globalSearchMode?.company.isEmpty ?? true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 16),
                                Text(
                                  'No records',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          : ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return showTileUI(
                                  onTap: () => Navigator.pushNamed(
                                      context, OrgDetails.ROUTE_ORG_DETAILS,
                                      arguments: {
                                        "name": globalSearchMode
                                                ?.company[index].name ??
                                            'NA',
                                        "id": globalSearchMode
                                                ?.company[index].id ??
                                            '',
                                      }),
                                  title:
                                      globalSearchMode?.company[index].name ??
                                          'NA',
                                );
                              },
                              itemCount: globalSearchMode!.company.length,
                            ),
                      ListTile(
                          title: Text(
                        "People",
                        style: textHelper.style16,
                      )),
                      globalSearchMode?.people.isEmpty ?? true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 16),
                                Text(
                                  'No records',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          : ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return showTileUI(
                                    onTap: () => Navigator.pushNamed(
                                            context, PeopleDetails.ROUTE_LEAD_DETAILS,
                                            arguments: {
                                              "name": globalSearchMode
                                                      ?.people[index].name ??
                                                  'NA',
                                              "id": globalSearchMode
                                                  ?.people[index].id,
                                              "company": globalSearchMode
                                                          ?.people[index]
                                                          .company !=
                                                      null
                                                  ? globalSearchMode
                                                      ?.people[index]
                                                      .company
                                                      .name
                                                  : '',
                                              "email": globalSearchMode!
                                                      .people[index]
                                                      .email
                                                      .isNotEmpty
                                                  ? globalSearchMode
                                                      ?.people[index].email[0]
                                                  : '',
                                            }),
                                    title: globalSearchMode?.people[index].name ??
                                        'NA',
                                    subTitle: globalSearchMode!
                                            .people[index].email.isNotEmpty
                                        ? globalSearchMode!
                                            .people[index].email[0]
                                        : '',
                                    email:
                                        globalSearchMode!.people[index].email.isNotEmpty
                                            ? globalSearchMode!
                                                .people[index].email[0]
                                            : '',
                                    number: globalSearchMode!
                                            .people[index].phone!.isEmpty
                                        ? ''
                                        : globalSearchMode!.people[index].phone?[0].toString() ?? '');
                              },
                              itemCount: globalSearchMode!.people.length,
                            ),
                      ListTile(
                          title: Text(
                        "Deal",
                        style: textHelper.style16,
                      )),
                      globalSearchMode?.deal.isEmpty ?? true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 16),
                                Text(
                                  'No records',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          : ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return showTileUI(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      DealDetailsPage.routeName,
                                      arguments: {
                                        'item': DealModel(
                                          company: Company(
                                              createdAddress: '',
                                              createdAt: '',
                                              email: [],
                                              id: '',
                                              name: '',
                                              owner: '',
                                              phone: [],
                                              website: ''),
                                          dealCurrency: 'INR',
                                          dealValue: 0,
                                          id: globalSearchMode!.deal[index].id,
                                          order: 0,
                                          tags: [],
                                          title: globalSearchMode
                                                  ?.deal[index].title ??
                                              '',
                                          people: DealPeople(
                                            id: '',
                                            state: '',
                                            isDeleted: false,
                                            name: '',
                                            firstName: '',
                                            lastName: '',
                                          ),
                                          status: '',
                                        ),
                                      },
                                    ).then((value) {
                                      if (value == true)
                                        getDealsWithDefaultId(context);
                                    });
                                  },
                                  //  Navigator.pushNamed(
                                  //     context, OrgDetails.ROUTE_ORG_DETAILS,
                                  // arguments: {
                                  //   "name": globalSearchMode
                                  //           ?.deal[index].title ??
                                  //       'NA',
                                  //   "id": globalSearchMode
                                  //           ?.deal[index].id ??
                                  //       '',
                                  // }),
                                  title: globalSearchMode?.deal[index].title ??
                                      'NA',
                                );
                              },
                              itemCount: globalSearchMode!.deal.length,
                            ),
                      ListTile(
                        title: Text(
                          "Lead",
                          style: textHelper.style16,
                        ),
                      ),
                      globalSearchMode?.lead.isEmpty ?? true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 16),
                                Text(
                                  'No records',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          : ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return showTileUI(
                                    onTap: () => Navigator.pushNamed(
                                            context, LeadsDetails.ROUTE_LEAD_DETAILS,
                                            arguments: {
                                              "name": globalSearchMode
                                                  ?.lead[index].name,
                                              "id": globalSearchMode
                                                  ?.lead[index].id,
                                              'company': CompanyNewModel(
                                                  id: globalSearchMode
                                                          ?.lead[index]
                                                          .company
                                                          .id ??
                                                      '',
                                                  name: globalSearchMode
                                                              ?.lead[index]
                                                              .company !=
                                                          null
                                                      ? globalSearchMode
                                                              ?.lead[index]
                                                              .company
                                                              .name ??
                                                          ''
                                                      : ''),
                                              "email": globalSearchMode!
                                                      .lead[index]
                                                      .email
                                                      .isNotEmpty
                                                  ? globalSearchMode
                                                          ?.lead[index]
                                                          .email[0] ??
                                                      ""
                                                  : '',
                                              'phone': globalSearchMode!
                                                      .lead[index]
                                                      .phone!
                                                      .isNotEmpty
                                                  ? globalSearchMode
                                                          ?.lead[index]
                                                          .phone![0]
                                                          .toString() ??
                                                      ''
                                                  : '',
                                            }),
                                    title: globalSearchMode!.lead[index].name != null
                                        ? globalSearchMode!.lead[index].name
                                        : '',
                                    subTitle: globalSearchMode!
                                            .lead[index].email.isNotEmpty
                                        ? globalSearchMode!.lead[index].email[0]
                                        : '',
                                    email: globalSearchMode!
                                            .lead[index].email.isNotEmpty
                                        ? globalSearchMode!.lead[index].email[0]
                                        : '',
                                    number: globalSearchMode!
                                            .lead[index].phone!.isNotEmpty
                                        ? globalSearchMode!.lead[index].phone![0]
                                            .toString()
                                        : '');
                              },
                              itemCount: globalSearchMode?.lead.length,
                            ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
    );
  }

  onTextChange(String value) async {
    setState(() => isLoading = true);
    if (value.isNotEmpty) {
      globalSearchMode =
          await Repository.getInstance().getGlobalSearchResult(value);
      setState(() => isLoading = false);
    }
  }

  showTileUI(
      {required Function()? onTap,
      required String? title,
      String? subTitle,
      String? number,
      String? email}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.0),
                topLeft: Radius.circular(12.0),
              )),
          child: ListTile(
            onTap: onTap,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: white, width: 2.5),
                borderRadius: BorderRadius.circular(12.0)),
            contentPadding: EdgeInsets.all(0.0),
            tileColor: Colors.white,
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: Text(
                  title == null
                      ? 'NA'
                      : title == ''
                          ? 'NA'
                          : title.characters.first,
                  style: TextStyle(
                    fontSize: 20,
                    color: blueColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            title: Text(
              title == '' ? 'NA' : title ?? 'NA',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: black,
              ),
            ),
            subtitle: subTitle == null
                ? null
                : Text(
                    subTitle,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: grey,
                    ),
                  ),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                email == null
                    ? Container()
                    : iconButtonHelper.emailIconButtonHelper(
                        onTap: () => Utils.launchUrl("mailto:$email"),
                      ),
                number == null
                    ? Container()
                    : number.length <= 9
                        ? Container()
                        : iconButtonHelper.callIconButtonHelper(
                            onTap: () => Utils.launchUrl("tel:$number"),
                          ),
                number == null
                    ? Container()
                    : iconButtonHelper.wtpIconButtonHelper(
                        onTap: () => Utils.launchWtp(
                          number: number.toString(),
                        ),
                      ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Container(height: 0.5, color: Colors.grey[200]),
        )
      ],
    );
  }
}
