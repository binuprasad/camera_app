import 'dart:convert';
import 'dart:io';
import 'package:camera_app2/functions.dart';
import 'package:camera_app2/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  void initState() {
    getAllimages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: imagenotifier,
          builder: (BuildContext context, List<ImageModel> imagelist,
              Widget? child) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, index) {
                final data = imagelist[index];
                return Card(
                  child: Image(
                    image: MemoryImage(
                      const Base64Decoder().convert(
                        data.image,
                      ),
                    ),
                  ),
                );
              },
              itemCount: imagelist.length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          picker();
        },
        child: const Icon(Icons.photo_camera),
      ),
    );
  }

  String _image = '';
  picker() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path).readAsBytesSync();
      setState(() {
        _image = base64Encode(imageTemporary);
      });
      final photo = ImageModel(image: _image);
      addimage(photo);
    }
  }
}
