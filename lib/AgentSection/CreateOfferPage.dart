import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Helpers/PickImage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateOferPage extends StatefulWidget {
  const CreateOferPage({Key? key}) : super(key: key);

  @override
  State<CreateOferPage> createState() => _CreateOferPageState();
}

class _CreateOferPageState extends State<CreateOferPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.OFF_WHITE_COLOR,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: AppButton(
          width: MediaQuery.of(context).size.width,
          height: 55,
          color: AppColor.BUTTON_COLOR,
          label: 'Submit Review',
          onTap: () {},
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
              msg: 'Add Offer',
              color: Colors.white,
              fontSize: 16,
            )),
        actions: [
          Image.asset(
            Assets.ic_Search,
            color: Colors.white,
            height: 20,
            width: 20,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getBoldText(
                msg: 'Set a title for your offer',
                fontSize: 16,
                color: AppColor.SIGNIN_COLOR),
            const SizedBox(
              height: 16,
            ),
            textField('Add Title', titleController),
            const SizedBox(
              height: 16,
            ),
            getBoldText(
                msg: 'Upload Images',
                fontSize: 16,
                color: AppColor.SIGNIN_COLOR),
            const SizedBox(
              height: 16,
            ),
            uploadGridViewImage(),
            const SizedBox(
              height: 20,
            ),
            getBoldText(
                msg: 'Set price', fontSize: 16, color: AppColor.SIGNIN_COLOR),
            const SizedBox(
              height: 16,
            ),
            textField('', priceController),
            const SizedBox(
              height: 16,
            ),
            getBoldText(
                msg: 'Describe what you are offering',
                fontSize: 16,
                color: AppColor.SIGNIN_COLOR),
            const SizedBox(
              height: 16,
            ),
            textField('Add Title', descriptionController),
          ],
        ),
      ),
    );
  }

  textField(String hint, TextEditingController textController) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.TEXT_COLOR.withOpacity(0.4)),
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

  uploadGridViewImage() {
    return GestureDetector(
      onTap: (){
        UploadImage.pickImage(ImageSource.gallery, context,
                (result, isSuccess) {
              if (isSuccess) {
                setState(() {
                  // imageFile = File(result.path);
                  Navigator.of(context, rootNavigator: true).pop();
                });
                // uploadSingleImage([imageToUpload.path]);
              }else{
                Navigator.of(context, rootNavigator: true).pop();
              }
            });
      },
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: AppColor.TEXT_COLOR),
        child: Icon(Icons.add, size: 50, color: Colors.white),
      ),
    );
  }
}
