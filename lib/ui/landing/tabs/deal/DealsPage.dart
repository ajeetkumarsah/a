// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/PipelineModel.dart';
import 'package:salessimplify/models/dropdownmodel.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/deal/DealList.dart';
import 'package:salessimplify/ui/landing/tabs/deal/Pipelines.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/ui/landing/tabs/deal/widget/drawer_loader.dart';
import 'package:salessimplify/ui/widget/SearchWidget.dart';
import 'package:salessimplify/ui/widgetHelper/empty_list_shimmer.dart';
import 'package:salessimplify/ui/widgetHelper/logo_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/serach_filter_ui.dart';

class DealsPage extends StatelessWidget{
  BuildContext? _context;
  static final GlobalKey<ScaffoldState> scaffoldKey =
  new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      appBar: LogoAppBar(
          title: SearchFilterUI(
            filterOnPressed: () => scaffoldKey.currentState!.openEndDrawer(),
            searchOnTap: () =>
                Navigator.pushNamed(context, SearchWidget.ROUTE_SEARCH),
            text: "Search Deals",
          )),
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                dense: true,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                tileColor: Colors.grey[200],
                leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "Select Deals",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: Repository.getInstance().getPipelines(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.done
                        ? ListView.builder(
                      itemCount:
                      (snapshot.data as List<PipelineModel>).length,
                      itemBuilder: (BuildContext context, int i) {
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            _context!.read<Repository>().getDeals(
                                (snapshot.data as List<PipelineModel>)[i]
                                    .id);
                          },
                          child: ListTile(
                            title: Text(
                                (snapshot.data as List<PipelineModel>)[i]
                                    .name),
                          ),
                        );
                      },
                    )
                        : DrawerLoader();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [blueColor, deepblue],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                child: DealList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onSelect(DropDownModel dropDownModel) {
    print(dropDownModel.name);
    _context!.read<Repository>().getDeals(dropDownModel.value);
  }

  refresh() {
    if(_context!.read<Repository>().selectedPipelineId.isNotEmpty){
      _context!.read<Repository>().getDeals(_context!.read<Repository>().selectedPipelineId);
    }
  }

}

/*class DealsPage extends StatefulWidget {
  //const DealsPage({Key? key}) : super(key: key);
  List<PipelineModel>? lisOfPipeline;
  @override
  _DealsPageState createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  BuildContext? _context;
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      appBar: LogoAppBar(
          title: SearchFilterUI(
        filterOnPressed: () => scaffoldKey.currentState!.openEndDrawer(),
        searchOnTap: () =>
            Navigator.pushNamed(context, SearchWidget.ROUTE_SEARCH),
        text: "Search Deals",
      )),
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                dense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                tileColor: Colors.grey[200],
                leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "Select Deals",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: Repository.getInstance().getPipelines(),
                  builder: (context, snapshot) {
                    if( snapshot.connectionState == ConnectionState.done && snapshot.data is List<PipelineModel>){
                      widget.lisOfPipeline = (snapshot.data as List<PipelineModel>);
                    }
                    return snapshot.connectionState == ConnectionState.done
                        ? ListView.builder(
                            itemCount:
                                (snapshot.data as List<PipelineModel>).length,
                            itemBuilder: (BuildContext context, int i) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  _context!.read<Repository>().getDeals(
                                      (snapshot.data as List<PipelineModel>)[i]
                                          .id);
                                },
                                child: ListTile(
                                  title: Text(
                                      (snapshot.data as List<PipelineModel>)[i]
                                          .name),
                                ),
                              );
                            },
                          )
                        : DrawerLoader();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [blueColor, deepblue],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                child: DealList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onSelect(DropDownModel dropDownModel) {
    print(dropDownModel.name);
    _context!.read<Repository>().getDeals(dropDownModel.value);
  }

  refresh() {
    if (widget.lisOfPipeline != null && widget.lisOfPipeline!.isNotEmpty) {
      _context!.read<Repository>().getDeals(widget.lisOfPipeline![0].id);
    }
  }
}*/

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
