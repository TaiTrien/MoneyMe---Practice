import 'package:flutter/material.dart';

class CustomDiaglog extends StatelessWidget {
  final Image image;
  final List<Widget> actions;
  final String title;
  final String subTitle;
  final Function onPress;
  const CustomDiaglog({
    Key key,
    this.actions,
    this.title,
    this.onPress,
    this.image,
    this.subTitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.all(0),
      title: image,
      content: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title + '\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            TextSpan(
              text: '\n' + subTitle,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
      actions: actions,
      elevation: 24.0,
    );
  }
}
// Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             subTitle,
//             style: TextStyle(
//               color: Colors.black54,
//               fontWeight: FontWeight.w400,
//             ),
//           )
//         ],
//       ),
