import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_express/ui/HomeScreens/home_page.dart';
import 'package:gas_express/ui/UserAddresses/my_addresses.dart';
import 'package:gas_express/ui/my_wallet.dart';
import 'package:gas_express/ui/notifications.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class drawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        color: primaryAppColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Container(
                height: 100,
                child: CircleAvatar(
                  backgroundColor: whiteColor,
                ),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(
                "assets/images/home.svg",
                color: blackColor.withOpacity(0.6),
              ),
              title: Text(
                getTranslated(context, 'HomePage'),
                style: _textStyle,
              ),
              onTap: () {
                navigateAndClearStack(context, HomePage());
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                "assets/images/addresses.svg",
                color: blackColor.withOpacity(0.6),
              ),
              title: Text(
                getTranslated(context, 'MyAddresses'),
                style: _textStyle,
              ),
              onTap: () {
                navigateAndClearStack(context, MyAddresses());
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                "assets/images/wallet.svg",
                color: blackColor.withOpacity(0.6),
              ),
              title: Text(
                getTranslated(context, 'MyWallet'),
                style: _textStyle,
              ),
              onTap: () {
                navigateAndClearStack(context, MyWallet());
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                "assets/images/notification.svg",
                color: blackColor.withOpacity(0.6),
              ),
              title: Text(
                getTranslated(context, 'Notifications'),
                style: _textStyle,
              ),
              onTap: () {
                navigateAndClearStack(context, Notifications());
              },
            ),
            Divider(),
            ListTile(
              leading: SvgPicture.asset(
                "assets/images/settings.svg",
                color: blackColor.withOpacity(0.6),
              ),
              title: Text(
                getTranslated(context, 'Settings'),
                style: _textStyle,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset(
                "assets/images/call.svg",
                color: blackColor.withOpacity(0.6),
              ),
              title: Text(
                getTranslated(context, 'ContactUs'),
                style: _textStyle,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset(
                "assets/images/share.svg",
                color: blackColor.withOpacity(0.6),
              ),
              title: Text(
                getTranslated(context, 'ShareApp'),
                style: _textStyle,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset(
                "assets/images/language.svg",
                color: blackColor.withOpacity(0.6),
              ),
              title: Text(
                getTranslated(context, 'changeLanguage'),
                style: _textStyle,
              ),
              onTap: () {
                translator.setNewLanguage(
                  context,
                  newLanguage: translator.currentLanguage == 'ar' ? 'en' : 'ar',
                  remember: true,
                  restart: true,
                );
              },
            ),
            Divider(),
            ListTile(
              leading: SvgPicture.asset(
                "assets/images/logout.svg",
                color: blackColor.withOpacity(0.6),
              ),
              title: Text(
                getTranslated(context, 'logOut'),
                style: _textStyle,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle _textStyle =
    TextStyle(color: whiteColor, fontSize: 22);
