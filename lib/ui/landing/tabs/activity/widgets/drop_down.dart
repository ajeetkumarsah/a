import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/SearchResult.dart';

class DropDownWidgetNew {
  Widget customDropDownExampleMultiSelectionDeal(
      BuildContext context, SearchResult? item) {
    if (item == null) {
      return Container(
        child: Text('Select Deal', style: textHelper.hintText),
      );
    }

    return Container(
      child: Row(
        children: [
          Container(
            height: 25,
            width: 25,
            child: Center(
              child: Icon(
                Icons.monetization_on_outlined,
                size: 16,
              ),
            ),
          ),
          SizedBox(width: 20),
          Text(item.title, style: textHelper.defaultText),
        ],
      ),
    );
  }

  Widget customPopupItemBuilderExampleDeal(
      BuildContext context, SearchResult? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(
          item?.title ?? '',
          style: textHelper.defaultText,
        ),
        leading: Container(
          height: 25,
          width: 25,
          child: Center(
            child: Icon(
              Icons.monetization_on_outlined,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget customDropDownExampleMultiSelectionPeople(
      BuildContext context, SearchPeopleNew? item) {
    if (item == null) {
      return Container(
        child: Text('Select People', style: textHelper.hintText),
      );
    }

    return Container(
      child: Row(
        children: [
          Container(
            height: 25,
            width: 25,
            child: Center(
              child: Icon(
                Boxicons.bx_group,
                size: 16,
              ),
            ),
          ),
          SizedBox(width: 20),
          Text(
            item.name ?? 'NA',
            style: textHelper.defaultText,
          ),
        ],
      ),
    );
  }

  Widget customPopupItemBuilderExamplePeople(
      BuildContext context, SearchPeopleNew? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(
          item?.name ?? '',
          style: textHelper.defaultText,
        ),
        leading: Container(
          height: 25,
          width: 25,
          child: Center(
            child: Icon(
              Boxicons.bx_group,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget customDropDownExampleMultiSelectionLead(
      BuildContext context, SearchLeadNew? item) {
    if (item == null) {
      return Container(
        child: Text('Select Lead', style: textHelper.hintText),
      );
    }

    return Container(
      child: Row(
        children: [
          Container(
            height: 25,
            width: 25,
            child: Center(
              child: Icon(
                Boxicons.bx_bullseye,
                size: 16,
              ),
            ),
          ),
          SizedBox(width: 20),
          Text(item.name!, style: textHelper.defaultText),
        ],
      ),
    );
  }

  Widget customPopupItemBuilderExampleLead(
      BuildContext context, SearchLeadNew? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.name ?? '', style: textHelper.defaultText),
        leading: Container(
          height: 25,
          width: 25,
          child: Center(
            child: Icon(
              Boxicons.bx_bullseye,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget customDropDownExampleMultiSelectionCompany(
      BuildContext context, SearchCompanyNew? item) {
    if (item == null) {
      return Container(
        child: Text('Select Company', style: textHelper.hintText),
      );
    }

    return Container(
      child: Row(
        children: [
          Container(
            height: 25,
            width: 25,
            child: Center(
                child: Icon(
              Boxicons.bx_buildings,
              size: 16,
            )),
          ),
          SizedBox(width: 10),
          Text(item.name, style: textHelper.defaultText),
        ],
      ),
    );
  }

  Widget customPopupItemBuilderExampleCompany(
      BuildContext context, SearchCompanyNew? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.name ?? '', style: textHelper.defaultText),
        leading: Container(
          height: 25,
          width: 25,
          child: Center(
            child: Icon(
              Boxicons.bx_buildings,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}

DropDownWidgetNew dropDownWidget = new DropDownWidgetNew();
