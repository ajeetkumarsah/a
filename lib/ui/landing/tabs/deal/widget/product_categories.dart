import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salessimplify/constants/fieldinputtype.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/activity_details_model.dart';
import 'package:salessimplify/models/deal_product.dart';
import 'package:salessimplify/models/notes.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/widgetHelper/bottomsheet.dart';
import 'package:salessimplify/ui/widgetHelper/custom_alertdialog.dart';
import 'package:salessimplify/ui/widgetHelper/dotted_button.dart';
import 'package:salessimplify/ui/widgetHelper/edit_button.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/tab_loader.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';

class ProductsList extends StatefulWidget {
  final String idType, id;
  ProductsList({Key? key, required this.id, required this.idType})
      : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  Map<String, dynamic> params = {};
  confirmDelete(Map<String, dynamic> params, String id) {
    var baseDialog = BaseAlertDialog(
        title: "Are you sure?",
        content: "Do you want to delete this product?",
        yesOnPressed: () {
          Navigator.pop(context);
          updateDeal(context, id, params, 'Delete').then(() => setState(() {}));
        },
        noOnPressed: () {
          Navigator.pop(context);
        },
        yes: "Delete",
        no: "Cancel");
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Repository.getInstance().getActivityDetails(widget.id, true),
      builder: (context, snapshot) {
        List<dynamic> product = [];
        List<Product> productItems = [];
        List<ActivityDetailsModel>? activityDetails;
        String apiKeyName = '';
        Map<String, dynamic> products = {};
        if (snapshot.connectionState == ConnectionState.done) {
          activityDetails = snapshot.data as List<ActivityDetailsModel>;

          activityDetails.forEach((element) {
            if (element.fieldInputType == 'DEAL_PRODUCT_INPUT') {
              product = element.value;

              apiKeyName = element.apiKeyName;
            }
          });
          if (product.isNotEmpty && product != null) {
            product.forEach((prod) {
              productItems.add(
                Product(
                    productId: prod['productId'],
                    itemName: prod['itemName'],
                    quantity: prod['quantity'].toDouble(),
                    unitPrice: prod['unitPrice'].toDouble(),
                    amount: prod['amount'].toDouble()),
              );
            });
          }
        }
        return snapshot.connectionState == ConnectionState.done
            ? product.isEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child: new DottedButton(
                          title: 'Link a product',
                          onTap: () {
                            CustomBottomSheet(handler: refresh, id: widget.id)
                                .addProductBottomDialog(
                                    context, product, true, apiKeyName, 0);
                          },
                        ),
                      ),
                      Expanded(
                        child: emptyListHelper.getEmptyList(
                            EmptyListHelper.emptyList, context),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: product == null ? 1 : product.length + 1,
                    itemBuilder: (BuildContext context, int i) {
                      if (i == 0) {
                        // return the header
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: new DottedButton(
                            title: 'Link a product',
                            onTap: () {
                              CustomBottomSheet(handler: refresh, id: widget.id)
                                  .addProductBottomDialog(
                                      context, product, true, apiKeyName, 0);
                            },
                          ),
                        );
                      }
                      i -= 1;

                      return Column(
                        children: [
                          ListTile(
                            onLongPress: () {},
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                      'Item Name: ' + product[i]['itemName']),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('Quantity: ' +
                                      product[i]['quantity'].toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('Unit Price: ' +
                                      product[i]['unitPrice'].toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('Amount: ' +
                                      product[i]['amount'].toString()),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                      colors: [redColor, redColor],
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      product.removeAt(i);
                                      params = {apiKeyName: product};
                                      confirmDelete(params, widget.id);
                                    },
                                    child: Center(
                                      child: Icon(
                                        Icons.delete,
                                        color: white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                EditButton(
                                  onTap: () {
                                    // print(product[i]['productId'].toString());
                                    CustomBottomSheet(
                                            handler: refresh, id: widget.id)
                                        .addProductBottomDialog(context,
                                            product, false, apiKeyName, i);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Divider()
                        ],
                      );
                    },
                  )
            : TabLoader();
      },
    );
  }

  Function? handler;
  updateDeal(BuildContext context, String id, Map<String, dynamic> params,
      String? product) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess = await Repository.getInstance()
        .updateDealDetails(params, id, product)
        .then((value) {
      refresh();
    });
    pr.hide();

    if (isSuccess is bool && isSuccess == true) {
      if (handler != null) {
        handler!();
      }
    }
  }

  refresh() {
    setState(() {});
  }

  deleteNote(BuildContext context, String id) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess = await context.read<Repository>().deleteNote(id);
    pr.hide().then((isHidden) {
      print(isHidden);
    });

    if (isSuccess is bool && isSuccess) {
      toastHelper.toastWithTitleAndColor("Deleted successfully!", greenColor);
      setState(() {});
      // Navigator.of(context).pop();
    } else {
      toastHelper.toastWithTitleAndColor("Failed to delete!", redColor);
    }
  }
}
