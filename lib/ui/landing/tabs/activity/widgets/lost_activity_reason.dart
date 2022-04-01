import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/lost_reason.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:provider/provider.dart';

class ActivityLostReasonWidget extends StatelessWidget {
  final LostReasonModel? selectedModel;
  final Function handler;
  late List<LostReasonModel> list = [];

  ActivityLostReasonWidget(
    this.selectedModel,
    this.handler,
  );

  @override
  Widget build(BuildContext context) {
    list = context.read<Repository>().activityLostReason;

    if (list.length > 0 && selectedModel == null) {
      handler(list[0]);
    }
    return list.length > 0
        ? LostActivityReasonDropDown(
            list,
            selectedModel ?? list[0],
            handler,
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

class LostActivityReasonDropDown extends StatefulWidget {
  final List<LostReasonModel> modes;
  final Function handler;
  LostReasonModel dropdownValue;

  LostActivityReasonDropDown(this.modes, this.dropdownValue, this.handler);

  @override
  _LostActivityReasonDropDownState createState() =>
      _LostActivityReasonDropDownState();
}

class _LostActivityReasonDropDownState
    extends State<LostActivityReasonDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(0.0),
            child: DropdownButton<LostReasonModel>(
              isExpanded: true,
              value: widget.dropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: Theme.of(context).textTheme.caption,
              underline: Container(
                height: 1,
                color: Colors.transparent,
              ),
              onChanged: (LostReasonModel? newValue) {
                setState(() {
                  widget.dropdownValue = newValue!;
                  widget.handler(newValue);
                });
              },
              items: widget.modes.map<DropdownMenuItem<LostReasonModel>>(
                  (LostReasonModel value) {
                return DropdownMenuItem<LostReasonModel>(
                  value: value,
                  child: Container(
                    padding: EdgeInsets.only(left: 35),
                    child: Text(
                      value.reason,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.modes.clear();
  }
}
