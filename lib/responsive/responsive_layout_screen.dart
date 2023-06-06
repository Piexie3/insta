import 'package:flutter/material.dart';
import 'package:insta/provider/user_provider.dart';
import 'package:insta/utils/global_variables.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout({
    super.key,
    required this.mobileScreenLayout,
    required this.webScreenLayout
    });

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }
  addData()async{
    UserProvider  _userPeovider = Provider.of(context, listen: false);
    await _userPeovider.refreshUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints){
      if(Constraints.maxWidth> mobileScreenSize){
        //web screen layout
        return widget.webScreenLayout;
      }
      // mobile screen layout
      return widget.mobileScreenLayout;
    });
  }

}