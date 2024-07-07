import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:allia_health/ApiManager.dart';
import 'package:allia_health/AuthenticationManager.dart';

class SubmitAnswersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> answers;

  SubmitAnswersScreen(this.answers);

  void _submitAnswers(BuildContext context) async {
    try {
      final apiManager = Provider.of<ApiManager>(context, listen: false);
      final headers = {
        'Authorization':
            'Bearer ${Provider.of<AuthenticationManager>(context, listen: false).accessToken}'
      };
      final response = await apiManager.post(
          '/api/client/self-report/answer', {'answers': answers},
          headers: headers);

      // Handle success response and navigation
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit Answers')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _submitAnswers(context),
          child: Text('Submit Answers'),
        ),
      ),
    );
  }
}
