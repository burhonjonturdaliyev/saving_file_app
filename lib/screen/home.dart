import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<File> _files = [];
  String _filePathsKey = 'file_paths';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Storage Example'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _files.isEmpty
                  ? Text('No files selected.')
                  : Column(
                      children:
                          _files.map((file) => _buildFileItem(file)).toList(),
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectFile,
                child: Text('Select File'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveFiles,
                child: Text('Save Files'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFileItem(File file) {
    return ListTile(
      title: Text(file.path.split('/').last), // Display file name
      leading: Icon(Icons.insert_drive_file), // Display file icon
    );
  }

  _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _files.add(File(result.files.single.path!));
      });
    }
  }

  _saveFiles() async {
    if (_files.isEmpty) {
      return; // No files selected
    }

    List<String> filePaths = [];

    Directory appDocDir = await getApplicationDocumentsDirectory();

    for (File file in _files) {
      String originalFileName =
          file.path.split('/').last; // Get original filename
      String filePath = '${appDocDir.path}/$originalFileName';

      int suffix = 1;
      while (await File(filePath).exists()) {
        // If file with same name exists, append a suffix to the filename
        filePath = '${appDocDir.path}/${originalFileName}_${suffix}';
        suffix++;
      }

      await file.copy(filePath);
      filePaths.add(filePath);
    }

    // Store file paths in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_filePathsKey, filePaths);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Files saved successfully!')),
    );
  }

  _getFilesFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? filePaths = prefs.getStringList(_filePathsKey);
    if (filePaths != null) {
      setState(() {
        _files = filePaths.map((path) => File(path)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getFilesFromSharedPreferences();
  }
}
