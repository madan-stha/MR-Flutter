import '../src.dart';

class SettingModel {
  String url;
  String label;
  String subtitle;
  String? icon;
  String categoryName;

  SettingModel({
    required this.url,
    required this.label,
    this.subtitle = "",
    this.icon,
    this.categoryName = 'Get in Touch',
  });
}

List<SettingModel> supportModel = [
  SettingModel(
    url: 'mailto:feedback@edigitalnepal.edu.np',
    label: 'feedback@edigitalnepal.edu.np',
    subtitle: 'email',
    icon: Assets.email,
  ),
  SettingModel(
    url: 'tel:000-111-222-333',
    label: '01-111-222-333',
    subtitle: 'landline',
    icon: Assets.phone,
  ),
  SettingModel(
    url: '',
    label: 'Kathmandu, Nepal',
    subtitle: 'address',
    icon: Assets.location,
  ),
  SettingModel(
    url: 'https://www.edigitalnepal.com/',
    label: 'www.edigitalnepal.com',
    subtitle: 'website',
    icon: Assets.web,
  ),
];

List<SettingModel> socialMediaModel = [
  SettingModel(
    url: 'https://www.facebook.com/shotcoder-tech',
    label: 'Facebook',
    subtitle: 'facebook',
    icon: Assets.facebook,
    categoryName: 'Connect with Us',
  ),
  SettingModel(
    url: 'https://twitter.com/shotcoder-tech',
    label: 'Twitter',
    subtitle: 'twitter',
    icon: Assets.twitter,
    categoryName: 'Connect with Us',
  ),
];

List<SettingModel> settingsItems = [
  SettingModel(
    url: '/updateprofile-screen',
    label: 'Update Profile Detail',
    categoryName: 'Personal Profile Setting',
  ),
  SettingModel(
    url: '/changepassword-screen',
    label: 'Change Password',
    categoryName: 'Personal Profile Setting',
  ),
  SettingModel(
    url: '/morealert-screen',
    label: 'Customize Alert Preference',
    categoryName: 'Notification Preference',
  ),
  SettingModel(
    url: '/faq-screen',
    label: 'FAQs',
    categoryName: 'Help & Support',
  ),
  SettingModel(
    url: '/contactsupport-screen',
    label: 'Contact Support',
    categoryName: 'Help & Support',
  ),
  SettingModel(
    url: '/languagepreferences-screen',
    label: 'Language',
    categoryName: 'Language Preference',
  ),
  SettingModel(
    url: '/theme-screen',
    label: 'Theme',
    categoryName: 'Others',
  ),
];
