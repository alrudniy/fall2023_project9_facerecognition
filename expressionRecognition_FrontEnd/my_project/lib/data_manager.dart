import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DataManager {
  Future<String> saveImageFile(String imagePath) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File originalImage = File(imagePath);
    final String fileName = basename(imagePath);
    final String newImagePath = '$path/$fileName';

    await originalImage.copy(newImagePath);
    return newImagePath;
  }

  Future<void> saveJsonData(String fileName, Map<String, dynamic> data) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = File('$path/$fileName');

    String jsonData = jsonEncode(data);
    await file.writeAsString(jsonData);
  }

  Future<Map<String, dynamic>> readJsonData(String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = File('$path/$fileName');

    if (!await file.exists()) {
      return {};
    }

    String jsonData = await file.readAsString();
    return jsonDecode(jsonData);
  }

  Future<void> saveImageAndData(
      String imagePath, Map<String, dynamic> jsonData) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;

    final File originalImage = File(imagePath);
    final String fileName = basename(imagePath);
    final String newImagePath = '$path/$fileName';
    await originalImage.copy(newImagePath);
    jsonData['imagePath'] = newImagePath;
    final String jsonFileName = '${basenameWithoutExtension(imagePath)}.json';
    final File jsonFile = File('$path/$jsonFileName');
    await jsonFile.writeAsString(jsonEncode(jsonData));
  }

  Future<List<Map<String, dynamic>>> getAllImageData() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final Directory dir = Directory(path);

    List<Map<String, dynamic>> imageList = [];
    List<FileSystemEntity> entries = await dir.list().toList();
    for (var entry in entries) {
      if (entry is File && entry.path.endsWith('.json')) {
        String jsonData = await entry.readAsString();
        Map<String, dynamic> data = jsonDecode(jsonData);
        if (data.containsKey('imagePath') &&
            File(data['imagePath']).existsSync()) {
          imageList.add(data);
        }
      }
    }

    return imageList;
  }
}
