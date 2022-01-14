import 'dart:io';
import 'package:bobobox_restaurant/common/constants.dart';
import 'package:bobobox_restaurant/common/navigation.dart';
import 'package:bobobox_restaurant/provider/preference_provider.dart';
import 'package:bobobox_restaurant/provider/scheduling_provider.dart';
import 'package:bobobox_restaurant/widget/custom_dialog_ios.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/setting-page';

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: cPrimary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: cWhite),
              onPressed: () => Navigation.back(),
            ),
            elevation: 0.0,
            iconTheme: const IconThemeData(color: cWhite),
            title: Expanded(
              child: Text(
                "Setting",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: cWhite,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.15),
              ),
            ),
          ),
          backgroundColor: cWhite,
          body: ListView(
            children: [
              Material(
                child: ListTile(
                  title: const Text('Dark Theme'),
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) => customDialog(context),
                  ),
                ),
              ),
              Consumer<PreferencesProvider>(
                  builder: (context, provider, index) {
                return Material(
                  child: ListTile(
                    title: const Text('Restaurant Notification'),
                    trailing: Consumer<SchedulingProvider>(
                      builder: (context, scheduled, _) {
                        return Switch.adaptive(
                        value: provider.isDailyRestaurantActive,
                          onChanged: (value) async {
                            if (Platform.isIOS) {
                              customDialog(context);
                            } else {
                              scheduled.scheduledNews(value);
                            provider.enableDailyRestaurant(value);
                            }
                          },
                        );
                      },
                    ),
                  ),
                );
              })
            ],
          )),
    );
  }
}
