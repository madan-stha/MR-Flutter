import 'package:flutter/material.dart';

import '../src.dart';

class ConfirmationFieldData {
  final String label;
  final Widget prefix;
  final String hintText;
  final isNumberField;
  final int maxLines;
  final bool contentPadding;
  final bool isReadOnly;
  final isLastItem;

  ConfirmationFieldData({
    required this.label,
    this.prefix = const SizedBox(),
    required this.hintText,
    this.isNumberField = false,
    this.contentPadding = true,
    this.maxLines = 1,
    this.isReadOnly = false,
    this.isLastItem = false,
  });
}

List<ConfirmationFieldData> confirmationfield = [
  ConfirmationFieldData(
      label: AppString.confirmid,
      isReadOnly: true,
      prefix: SvgHelper.fromSource(path: Assets.weight, height: 16, width: 16),
      hintText: AppString.taskid),
  ConfirmationFieldData(
    label: AppString.confirmcustomername,
    isReadOnly: true,
    prefix:
        SvgHelper.fromSource(path: Assets.userprofile, height: 16, width: 16),
    hintText: AppString.customername,
  ),
  ConfirmationFieldData(
    label: AppString.confirmcustomercontact,
    isReadOnly: true,
    prefix: SvgHelper.fromSource(path: Assets.phone, height: 16, width: 16),
    hintText: AppString.customercontact,
  ),
  ConfirmationFieldData(
    label: AppString.confirmcustomerlocation,
    prefix: SvgHelper.fromSource(path: Assets.location, height: 16, width: 16),
    hintText: AppString.customerlocation,
    isReadOnly: true,
  ),
  // ConfirmationFieldData(
  //   label: AppString.lblState,
  //   prefix: SvgHelper.fromSource(path: Assets.location, height: 16, width: 16),
  //   hintText: AppString.lblEnterState,
  // ),
  // ConfirmationFieldData(
  //   label: AppString.lblCountry,
  //   prefix: SvgHelper.fromSource(path: Assets.location, height: 16, width: 16),
  //   hintText: AppString.lblEnterCountry,
  //   isLastItem: true,
  // ),
  // ConfirmationFieldData(
  //   label: AppString.lblDrInformation,
  //   prefix: SvgHelper.fromSource(path: Assets.info, height: 16, width: 16),
  //   hintText: AppString.lblEnterDrInformation,
  //   contentPadding: false,
  //   maxLines: 5,
  // ),
];
