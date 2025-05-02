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
    return MaterialApp(builder: SmartDialogManager.init(), title: 'Smart Dialog Example', home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Dialog Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                SmartDialogManager.showLoading();
                Future.delayed(const Duration(seconds: 2), SmartDialogManager.dismiss);
              },
              child: const Text('Show Loading'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                SmartDialogManager.showDialog(
                  params: SmartDialogParams(
                    title: 'Are You Sure?',
                    description: 'This action cannot be undone.',
                    positiveButtonText: 'Yes',
                    negativeButtonText: 'No',
                    onPositiveButtonPressed: () {
                      SmartDialogManager.dismiss();
                      _showSuccessDialog(context);
                    },
                    onNegativeButtonPressed: SmartDialogManager.dismiss,
                  ),
                );
              },
              child: const Text('Show Confirmation Dialog'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                SmartDialogManager.showDialog(params: SmartDialogParams(title: 'Custom Dialog', description: 'This one has custom styles.', backgroundColor: Colors.teal[100], foregroundColor: Colors.teal, titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal), positiveButtonText: 'Got it', positiveButtonStyle: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)), onPositiveButtonPressed: SmartDialogManager.dismiss));
              },
              child: const Text('Show Custom Dialog'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    SmartDialogManager.showDialog(params: SmartDialogParams(description: 'Action completed successfully!', positiveButtonText: 'OK', onPositiveButtonPressed: SmartDialogManager.dismiss));
  }
}
