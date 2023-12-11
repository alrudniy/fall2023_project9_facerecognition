import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:my_project/resultPage.dart';
import 'data_manager.dart';
import 'global.dart';

class PhotosPage extends StatefulWidget {
  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  XFile? _image;
  DataManager dataManager = DataManager();
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected.')),
      );
      return;
    }

    var uri = Uri.parse('http://$globalIpAddress:$globalPort/upload');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      _image!.path,
    ));
    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully')),
        );
        final responseString = await response.stream.bytesToString();
        print(responseString);
        final responseData = json.decode(responseString);
        print(responseData[0]);
        dataManager.saveImageAndData(_image!.path, responseData[0]);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              analysisResult: responseData[0],
              imagePath: _image!.path,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image upload failed')),
        );
        final responseString = await response.stream.bytesToString();
        print(responseString);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos Page'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            width: double.infinity,
            height: MediaQuery.of(context).size.width - 30,
            child: Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(File(_image!.path)),
            ),
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: _pickImage,
            tooltip: 'Pick Image',
            child: Icon(Icons.photo_library),
            mini: false,
          ),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () {
                _uploadImage();
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
