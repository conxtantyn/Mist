import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../common/common.dart';

const int kLogoRatio = 28;
const int kLogoSmRatio = 18;

class LogoBox extends StatelessWidget {
  final int size;
  final double radius;

  LogoBox({
    Key? key,
    this.size = kLogoRatio,
    this.radius = Dimens.padding * 2,
  }) : super(key: key);

  LogoBox.sm({
    Key? key,
    this.size = kLogoSmRatio,
    this.radius = Dimens.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.w,
      width: size.w,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.elliptical(radius, radius),
        ),
        boxShadow: [
          BoxShadow(
            color: context.read<Skin>().background,
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(radius * .8),
              child: Icon(
                Icons.location_history,
                size: size.w / 2.8,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
