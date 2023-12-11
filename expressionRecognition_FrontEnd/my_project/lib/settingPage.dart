import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'global.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late TextEditingController _ipController;
  late TextEditingController _portController;
  final _formKey = GlobalKey<FormState>();
  String _connectionStatus = 'unconnected';

  @override
  void initState() {
    super.initState();
    _ipController = TextEditingController(text: globalIpAddress);
    _portController = TextEditingController(text: globalPort);
    _testConnection1();
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }

  void _testConnection() async {
    try {
      var response = await http
          .get(Uri.parse('http://$globalIpAddress:$globalPort/connectionTest'));
      print("http://$globalIpAddress:$globalPort/connectionTest");
      if (response.statusCode == 200) {
        setState(() {
          _connectionStatus = 'Connection successful';
        });
      } else {
        setState(() {
          _connectionStatus = 'Connection failure';
        });
      }
    } catch (e) {
      print('Error messages：' + e.toString());
      setState(() {
        _connectionStatus = 'Connection exception';
      });
    }
  }

  void _testConnection1() async {
    try {
      var response = await http.get(Uri.parse('https://www.baidu.com'));
      if (response.statusCode == 200) {
        print("Connection successful");
      } else {
        print("Connection failure");
      }
    } catch (e) {
      print('Error messages：' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setting'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _ipController,
                decoration: InputDecoration(
                  labelText: 'IP Address',
                ),
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  globalIpAddress = value ?? '';
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: _portController,
                decoration: InputDecoration(
                  labelText: 'Port',
                ),
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  globalPort = value ?? '';
                },
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _testConnection();
                  }
                },
                child: Text('test connection'),
              ),
              Text('connection status: $_connectionStatus'),
            ],
          ),
        ),
      ),
    );
  }
}
