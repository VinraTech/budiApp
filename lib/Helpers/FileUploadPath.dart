import 'package:image_picker/image_picker.dart';

class FileUploadTask {
  String filename = "";
  String? type;
  String? key;
  String filePath = "";
  String completeName = "";
  Map<String, dynamic>? fileUploadParams;

  FileUploadTask(String fName, String fPath, {String? key, String? fType}) {
    this.filename = fName;
    this.type = fType;
    this.key = key;
    this.filePath = fPath;
  }

  FileUploadTask.fromPathString(String path) {
    this.filePath = path;
    this.filename = path.split("/").last.split(".").first;
    this.type = path.split("/").last.split(".").last;
  }

  FileUploadTask.fromFilePath(XFile path) {
    this.filePath = path.path;
    this.completeName = path.path.split("/").last;
    this.filename = path.path.split("/").last.split(".").first;
    this.type = path.path.split("/").last.split(".").last;
  }

  addFileUploadRequest(List<XFile> paths, {required String key}) {
    List<FileUploadTask> uploadTasks = new List.empty(growable: true);
    paths.forEach((element) {
      uploadTasks.add(FileUploadTask.fromFilePath(element));
    });
    fileUploadParams = {key: uploadTasks};
  }
}

class UploadFileResponse {
  String? originalName;
  String? rawName;
  String? fileExt;
  String? fileUrl;

  UploadFileResponse({this.originalName, this.rawName, this.fileExt});

  UploadFileResponse.fromJson(Map<String, dynamic> json) {
    originalName = json['original_name'];
    rawName = json['raw_name'];
    fileExt = json['file_ext'];
    fileUrl = json['fileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original_name'] = this.originalName;
    data['raw_name'] = this.rawName;
    data['file_ext'] = this.fileExt;
    data['fileUrl'] = this.fileUrl;
    return data;
  }
}

class Result<T> {
  Result._();

  factory Result.loading(T msg) = LoadingState<T>;

  factory Result.success(T value) = SuccessState<T>;

  factory Result.error(T msg) = ErrorState<T>;
}

class LoadingState<T> extends Result<T> {
  LoadingState(this.msg) : super._();
  final T msg;
}

class ErrorState<T> extends Result<T> {
  ErrorState(this.msg) : super._();
  final T msg;
}

class SuccessState<T> extends Result<T> {
  SuccessState(this.value) : super._();
  final T value;
}

