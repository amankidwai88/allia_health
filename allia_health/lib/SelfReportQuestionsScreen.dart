import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:allia_health/ApiManager.dart';
import 'package:allia_health/AuthenticationManager.dart';

class SelfReportQuestionsScreen extends StatefulWidget {
  @override
  _SelfReportQuestionsScreenState createState() =>
      _SelfReportQuestionsScreenState();
}

class _SelfReportQuestionsScreenState extends State<SelfReportQuestionsScreen> {
  List<dynamic>? questions;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  void _fetchQuestions() async {
    try {
      final apiManager = Provider.of<ApiManager>(context, listen: false);
      final headers = {
        'Authorization':
            'Bearer ${Provider.of<AuthenticationManager>(context, listen: false).accessToken}'
      };
      final response = await apiManager.get('/api/client/self-report/question',
          headers: headers);

      setState(() {
        questions = response['questions'];
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Self Report Questions')),
      body: questions == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: questions!.length,
              itemBuilder: (context, index) {
                final question = questions![index];
                return ListTile(
                  title: Text(question['text']),
                  // Implement UI based on question type (single_choice, likert_scale, etc.)
                );
              },
            ),
    );
  }
}
