import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


final ImagePicker _picker = ImagePicker();

Future<File?> _getImage(ImageSource source) async {
  XFile? image = await _picker.pickImage(source: source);
  if(image!=null) {
    return (File(image.path));
  }
}

Future<File?> _cropImage(XFile? image) async {
  if (image != null) {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      cropStyle: CropStyle.circle,
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: "Modifier l'image",
            toolbarColor: Colors.black,
            cropFrameColor: Colors.white,
            toolbarWidgetColor: Colors.white,
            statusBarColor: Colors.white,
            activeControlsWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
    );
    return File(croppedFile!.path);
  }
  return null;
}

void getImage({required BuildContext context, required Function(File image) onImageSelected}) {
  showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
            title: const Text(
              "Choisissez une image",
              style: TextStyle(fontSize: 30),
            ),
            message: const Text(
              "Sélectionnez la source",
              style: TextStyle(fontSize: 15.0),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: const Text("Galerie"),
                isDefaultAction: true,
                onPressed: () async {
                  File? croppedImage = await _getImage(ImageSource.gallery);
                  if ((croppedImage) != null) {
                    onImageSelected(croppedImage);
                  }

                  Navigator.pop(_);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text("Appareil Photo"),
                isDestructiveAction: true,
                onPressed: () async {
                  File? croppedImage = await _getImage(ImageSource.camera);
                  if ((croppedImage) != null) {
                    onImageSelected(croppedImage);
                  }

                  Navigator.pop(_);
                },
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: const Text("Annuler"),
              onPressed: () {
                Navigator.pop(_);
              },
            ),
          ));
}
