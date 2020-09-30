import 'package:MoneyMe/constants.dart';
import 'package:MoneyMe/screens/home/components/jar_card.dart';
import 'package:MoneyMe/screens/home/home_controller.dart';

import 'package:flutter/material.dart';

class JarsListBoard extends StatelessWidget {
  final HomeController controller;
  const JarsListBoard({
    Key key,
    @required this.size,
    @required this.controller,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: double.infinity, maxHeight: size.height * 0.4),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: kDefaultPaddingVertical + 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: kDefaultPaddingHorizontal),
              child: Text(
                'Danh sách hũ',
                style: kTitleTextStyle,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 4),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return JarCard(
                    title: controller.jarsList[index].jarName ?? "Trống",
                    subTitle: controller.jarsList[index].jarTitle ?? "Trống",
                    iconName: controller.jarsList[index].icon.substring(4),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
