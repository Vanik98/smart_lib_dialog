import 'package:flutter/material.dart';
import 'package:smart_lib_dialog/dialog/smart_dialog_params.dart';
import 'package:smart_lib_dialog/smart_dialog_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: SmartDialogManager.init(),
      title: 'Flutter Smart Dialog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            FilledButton(onPressed: (){
              SmartDialogManager.showLoading();
            }, child: Text("Open Loading")),
            SizedBox(height: 100),
            FilledButton(onPressed: (){
              SmartDialogManager.showDialog(params: SmartDialogParams(
                title: "Hello dialog!",
                description: "This is smart dialog",
                positiveButtonText: "Yes",
                onOnClose: (){
                  SmartDialogManager.dismiss();
                },
                onPositiveButtonPressed: (){
                  SmartDialogManager.dismiss();
                }
              ));
            }, child: Text("Open Dialog"))
          ],),
        ),
      ),
    );
  }
}
