import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/HomePageItems/PaymentDonePage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  String? dropdownValue;

  List<String> list = <String>[
    'User Experience',
    'Payment',
    'Account',
    'other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: AppButton(
          width: MediaQuery.of(context).size.width,
          height: 55,
          color: AppColor.BUTTON_COLOR,
          label: 'Submit',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentDone(
                          contactUs: true,
                        )));
          },
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        backgroundColor: AppColor.BUTTON_COLOR,
        title: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 1.5,
            child: getSemiBoldText(
              msg: 'Contact Us',
              color: Colors.white,
              fontSize: 16,
            )),
      ),
      body: Container(
        child: billInfo(),
      ),
    );
  }

  billInfo() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getBoldText(
              msg: 'Your current Budi App balance is',
              fontSize: 16,
              color: AppColor.SIGNIN_COLOR),
          SizedBox(
            height: 8,
          ),
          dropDownField(),
          SizedBox(
            height: 8,
          ),
          textField('Subject'),
          SizedBox(
            height: 8,
          ),
          textField('Type Here'),
        ],
      ),
    );
  }

  textField(String hint) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColor.TEXT_COLOR.withOpacity(0.4)),
        color: AppColor.BACKGROUND_COLOR.withOpacity(0.5),
      ),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: AppColor.TEXT_COLOR.withOpacity(0.6))),
      ),
    );
  }

  dropDownField() {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColor.TEXT_COLOR.withOpacity(0.4)),
        color: AppColor.BACKGROUND_COLOR.withOpacity(0.5),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        isExpanded: true,
        elevation: 16,
        hint: Text('Select topic'),
        style: const TextStyle(color: Colors.black),
        underline: SizedBox(),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
