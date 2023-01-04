import 'dart:convert';
import 'package:budi/Helpers/AppIndicator.dart';
import 'package:budi/Helpers/ToastMessage.dart';
import 'package:budi/Models/ContactUsModel.dart';
import 'package:http/http.dart' as http;
import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/HomePageItems/PaymentDonePage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  String? dropdownValue;
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
            dropdownValue == null ||
                    subjectController == '' ||
                    descriptionController == ''
                ? ToastMessage.message('All Fields Are Required')
                : contactSubmitPressed(
                    dropdownValue ?? '',
                    subjectController.text ?? '',
                    descriptionController.text ?? '');
          },
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
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
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getBoldText(
              msg: 'Your current Budi App balance is',
              fontSize: 16,
              color: AppColor.SIGNIN_COLOR),
          const SizedBox(
            height: 8,
          ),
          dropDownField(),
          const SizedBox(
            height: 8,
          ),
          textField('Subject', subjectController),
          const SizedBox(
            height: 8,
          ),
          textField('Type Here', descriptionController),
        ],
      ),
    );
  }

  textField(String hint, TextEditingController textController) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColor.TEXT_COLOR.withOpacity(0.4)),
        color: AppColor.BACKGROUND_COLOR.withOpacity(0.5),
      ),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: AppColor.TEXT_COLOR.withOpacity(0.6))),
      ),
    );
  }

  dropDownField() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColor.TEXT_COLOR.withOpacity(0.4)),
        color: AppColor.BACKGROUND_COLOR.withOpacity(0.5),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        isExpanded: true,
        elevation: 16,
        hint: const Text('Select topic'),
        style: const TextStyle(color: Colors.black),
        underline: const SizedBox(),
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

  contactSubmitPressed(String dropDownValue, String subjectValue,
      String descriptionValue) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('LogInToken');
    try {
      var params = {
        'topic': dropDownValue,
        'subject': subjectValue,
        'message': descriptionValue
      };
      final url = Uri.parse('http://74.208.150.111/api/support/contact_us');
      var request = http.MultipartRequest('POST', url)..fields.addAll(params);
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data'
      });
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      var encoded = json.decode(respStr);
      final int statusCode = url.port;
      ContactUsModel data = ContactUsModel.fromJson(encoded);
      if (response.statusCode == 200) {
        dropdownValue = null;
        subjectController.clear();
        descriptionController.clear();
        AppIndicator.disposeIndicator();
        ContactUsModel? apiResultModel;
        apiResultModel = data;
        ToastMessage.message(data.message);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentDone(
                      contactUs: true,
                    )));
      } else {
        ToastMessage.message(data.message);
        AppIndicator.disposeIndicator();
        print(statusCode);
      }
    } catch (exception) {
      AppIndicator.disposeIndicator();
      print("Please Check Internet");
    }
  }
}
