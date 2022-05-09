import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);
  final Function onSelectImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture(source) async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: source,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    final rlyImageFile = File(imageFile.path);
    setState(() {
      _storedImage = rlyImageFile;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(rlyImageFile.path);
    final savedImage = await rlyImageFile.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                )
              : const Text(
                  "Take A picture",
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(children: [
            ElevatedButton.icon(
              onPressed: () => _takePicture(ImageSource.camera),
              icon: const Icon(Icons.camera),
              label: const Text("Take Picture"),
            ),
            ElevatedButton.icon(
              onPressed: () => _takePicture(ImageSource.gallery),
              icon: const Icon(Icons.storage),
              label: const Text("Open Gallery"),
            ),
          ]),
        ),
      ],
    );
  }
}
