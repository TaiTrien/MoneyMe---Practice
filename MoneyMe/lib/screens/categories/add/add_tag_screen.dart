import 'package:MoneyMe/constants.dart';
import 'package:flutter/material.dart';

class AddTagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.white),
        title: Text(
          'Thêm hạng mục',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPaddingHorizontal,
              vertical: kDefaultPaddingVertical,
            ),
            height: size.height * 0.4,
            decoration: BoxDecoration(
              color: Colors.white54,
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: ClipOval(
                    child: CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Icon(
                        Icons.ac_unit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [],
                ),
                Row(
                  children: [],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
