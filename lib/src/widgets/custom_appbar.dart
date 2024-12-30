import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final bool onlyBackButton;
  final Function()? onBackPressed;
  final bool titleTranslate;
  final bool showCart;
  final bool isNotification;
  final bool centerTitle;
  final Color? bgColor;
  final Color? titleColor;
  final List<Widget>? actions;
  final bool radius;
  final Widget? bottom;

  const CustomAppBar(
      {super.key,
      this.title = '',
      this.isBackButtonExist = true,
      this.onlyBackButton = false,
      this.titleTranslate = true,
      this.onBackPressed,
      this.showCart = false,
      this.isNotification = false,
      this.centerTitle = false,
      this.bgColor,
      this.titleColor,
      this.radius = true,
      this.bottom,
      this.actions = const [
        SizedBox(),
      ]});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? "",
        style: AppStyles.text16PxMedium.copyWith(
          color: titleColor ?? Theme.of(context).canvasColor,
        ),
      ),
      centerTitle: centerTitle,
      automaticallyImplyLeading: isBackButtonExist,
      titleSpacing: isBackButtonExist ? 5 : 20,
      shape: radius
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            )
          : null,
      leading: isBackButtonExist
          ? IconButton(
              splashRadius: 20,
              hoverColor: Colors.transparent,
              icon: Icon(Icons.arrow_back_ios_rounded,
                  color: onlyBackButton
                      ? AppColors.kPitchBlackColor
                      : Theme.of(context).canvasColor),
              onPressed: () => onBackPressed != null
                  ? onBackPressed!()
                  : Navigator.pop(context),
            )
          : null,
      backgroundColor: bgColor ?? Theme.of(context).primaryColor,
      elevation: 0,
      actions: isNotification
          ? <Widget>[
              IconButton(
                color: AppColors.white,
                icon: SvgHelper.fromSource(path: Assets.notifications),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is to notify.')),
                  );
                },
              )
            ]
          : actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
