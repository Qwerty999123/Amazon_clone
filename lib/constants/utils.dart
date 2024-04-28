import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

Future<List<File>> pickImages() async{
  List<File> images = [];
  try{
    var imageFiles = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if(imageFiles != null && imageFiles.files.isNotEmpty){
      for(int i=0; i<imageFiles.files.length; i++){
        images.add(File(imageFiles.files[i].path!));
      }
    }
  }catch(e){
    debugPrint(e.toString());
  }
  return images;
}