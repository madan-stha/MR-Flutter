import 'package:flutter/material.dart';

import '../src.dart';

class ProfileFieldData {
  final String label;
  final Widget prefix;
  final String hintText;
  final isNumberField;
  final int maxLines;
  final bool contentPadding;
  final bool isReadOnly;
  final isLastItem;

  ProfileFieldData({
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

List<ProfileFieldData> updateProfileField = [
  ProfileFieldData(
    label: AppString.lblFullName,
    prefix:
        SvgHelper.fromSource(path: Assets.userprofile, height: 16, width: 16),
    hintText: AppString.lblEnterFullName,
  ),
  ProfileFieldData(
    label: AppString.lblEmail,
    isReadOnly: true,
    prefix: SvgHelper.fromSource(path: Assets.email, height: 16, width: 16),
    hintText: AppString.lblEnterEmail,
  ),
  ProfileFieldData(
    label: AppString.lblContactNumber,
    prefix: SvgHelper.fromSource(path: Assets.phone, height: 16, width: 16),
    hintText: AppString.lblEnterContactNumber,
    isNumberField: true,
  ),
  ProfileFieldData(
    label: AppString.lblCity,
    prefix: SvgHelper.fromSource(path: Assets.location, height: 16, width: 16),
    hintText: AppString.lblEnterCity,
  ),
  ProfileFieldData(
    label: AppString.lblState,
    prefix: SvgHelper.fromSource(path: Assets.location, height: 16, width: 16),
    hintText: AppString.lblEnterState,
  ),
  ProfileFieldData(
    label: AppString.lblCountry,
    prefix: SvgHelper.fromSource(path: Assets.location, height: 16, width: 16),
    hintText: AppString.lblEnterCountry,
    isLastItem: true,
  ),

];
