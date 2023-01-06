import 'dart:convert';
import 'dart:io';
import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppTextField.dart';
import 'package:budi/Helpers/AppIndicator.dart';
import 'package:budi/Helpers/FileUploadPath.dart';
import 'package:budi/Helpers/PickImage.dart';
import 'package:budi/Helpers/ToastMessage.dart';
import 'package:budi/Models/UserInfoModel.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

typedef void ResponseHandler(dynamic result, bool isSuccess);


class EditPage extends StatefulWidget {
  String? postMedia;

  EditPage({this.postMedia});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  File? imageFile;
  bool galleryCameraTap = false;
  ApiResultModel? apiResultModel;

  TextEditingController? instagramController,
      facebookController,
      tikTokController;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.OFF_WHITE_COLOR,
      body: editPage(),
    );
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: getRegularStyleText(msg: 'StringConst.goodChoice'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: getRegularStyleText(msg: 'Gallery'),
                    onTap: () {
                      galleryCameraTap = true;
                      UploadImage.pickImage(ImageSource.gallery, context,
                          (result, isSuccess) {
                        if (isSuccess) {
                          setState(() {
                            imageFile = File(result.path);
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                          // uploadSingleImage([imageToUpload.path]);
                        }else{
                          Navigator.of(context, rootNavigator: true).pop();
                        }
                      });
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: getRegularStyleText(msg: 'Camera'),
                    onTap: () {
                      galleryCameraTap = true;
                      UploadImage.pickImage(ImageSource.camera, context,
                              (result, isSuccess) {
                            if (isSuccess) {
                              setState(() {
                                imageFile = File(result.path);
                                Navigator.of(context, rootNavigator: true).pop();
                              });
                              // uploadSingleImage([imageToUpload.path]);
                            }else{
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                          });
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget editPage() {
    return Scaffold(
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
              msg: 'Edit Profile',
              color: Colors.white,
              fontSize: 16,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                _showChoiceDialog(context);
              },
              child: CircleAvatar(
                  radius: 55,
                  backgroundColor: AppColor.BUTTON_COLOR,
                  child: imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            imageFile!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            widget.postMedia!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                          ))),
            ),
            GestureDetector(
              onTap: () {
                _showChoiceDialog(context);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: getRegularStyleText(
                  msg: 'Change Profile',
                  color: AppColor.BUTTON_COLOR,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            AppTextField(
              controller: instagramController,
              obscureText: true,
              enable: true,
              prefixIcon: Assets.icinstagramIcon,
              hintText: 'Instagram Link',
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            AppTextField(
              controller: tikTokController,
              obscureText: true,
              enable: true,
              prefixIcon: Assets.icTikTokIcon,
              hintText: 'TikTok Link',
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              height: 80,
              child: AppTextField(
                controller: facebookController,
                obscureText: true,
                enable: true,
                prefixIcon: Assets.icBlackFacebookIcon,
                hintText: 'FaceBook Link',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            AppButton(
              width: MediaQuery.of(context).size.width,
              height: 55,
              color: AppColor.BUTTON_COLOR,
              label: 'Edit',
              onTap: () {
                editButtonPressed(
                    [imageFile!.path],
                    instagramController?.text ?? '',
                    tikTokController?.text ?? '',
                    facebookController?.text ?? '');
              },
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic>? fileUploadParams;

  addFileUploadRequestWithPathString(List<String> paths,
      {required String key}) {
    List<FileUploadTask> uploadTasks = new List.empty(growable: true);
    paths.forEach((element) {
      uploadTasks.add(FileUploadTask.fromPathString(element));
    });
    fileUploadParams = {key: uploadTasks};
  }

  editButtonPressed(List<String> imagePath, String insta, String tikTok,
      String facebook) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');

      AppIndicator.loadingIndicator();
      addFileUploadRequestWithPathString(imagePath, key: 'profile_picture');
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://74.208.150.111/api/profile/update'));
      request.headers.addAll({
        'Authorization': 'Bearer ${token!}',
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data'
      });
      var requestParams = {
        "instagram_handle": insta,
        "tiktok_handle": tikTok,
        "facebook_handle": facebook,
      };
      var fileDetails = fileUploadParams;
      if (fileDetails != null) {
        var fileUploadTasks =
            fileDetails[fileDetails.keys.first] as List<FileUploadTask>;
        if (fileUploadTasks != null) {
          for (int index = 0; index < fileUploadTasks.length; index++) {
            request.files.add(await http.MultipartFile.fromPath(
                fileDetails.keys.first, fileUploadTasks[index].filePath,
                filename: fileUploadTasks[index].filePath));
          }
        }
        requestParams.forEach((key, value) {
          request.fields[key] = value as String;
        });
        var response = await request.send();
        if (response.statusCode == 200) {
          Map<String, dynamic> decoded =
              json.decode(await response.stream.bytesToString());
          ApiResultModel data = ApiResultModel.fromJson(decoded);
          apiResultModel = data;
          AppIndicator.disposeIndicator();
          ToastMessage.message(data.message);
          Navigator.pop(context);
        } else {
          return print("Book list not available");
        }
      }
    } catch (exception) {
      AppIndicator.disposeIndicator();
      print("Please Check Internet");
    }
  }
}
