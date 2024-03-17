import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Math Quiz',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<HomePage> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, dynamic>> _questions = const [
    {
      'questionText': 'Berapakah hasil dari penjumlahan 504 + 1043?',
      'answers': [
        {'text': '1547', 'score': 1},
        {'text': '1047', 'score': 0},
        {'text': '1507', 'score': 0},
        {'text': '1447', 'score': 0},
      ],
    },
    {
      'questionText': 'Manakah bilangan berikut yang merupakan bilangan prima?',
      'answers': [
        {'text': '64', 'score': 0},
        {'text': '99', 'score': 0},
        {'text': '43', 'score': 1},
        {'text': '78', 'score': 0},
      ],
    },
    {
      'questionText': 'Berapakah hasil dari akar 225?',
      'answers': [
        {'text': '5', 'score': 0},
        {'text': '25', 'score': 0},
        {'text': '55', 'score': 0},
        {'text': '15', 'score': 1},
      ],
    },
        {
      'questionText': 'Berapakah besar volume kubus jika memiliki panjang sisi 7 cm?',
      'answers': [
        {'text': '49 cm^3', 'score': 0},
        {'text': '343 cm^3', 'score': 1},
        {'text': '21 cm^3', 'score': 0},
        {'text': '98 cm^3', 'score': 0},
      ],
    },
            {
      'questionText': 'Berapakah jumlah sisi yang terdapat pada limas segitiga',
      'answers': [
        {'text': '2', 'score': 0},
        {'text': '4', 'score': 1},
        {'text': '3', 'score': 0},
        {'text': '5', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    _score += score;

    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Math Quiz'),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              questionIndex: _questionIndex,
              questions: _questions,
              answerQuestion: _answerQuestion,
            )
          : Result(_score, _resetQuiz),
    );
  }
}

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, dynamic>> questions;
  final Function answerQuestion;

  Quiz({
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['questionText']),
        ...(questions[questionIndex]['answers'] as List<Map<String, dynamic>>)
            .map((answer) {
          return Answer(
            answerText: answer['text'],
            selectHandler: () => answerQuestion(answer['score']),
          );
        }).toList(),
      ],
    );
  }
}

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final String answerText;
  final VoidCallback selectHandler;

  Answer({
    required this.answerText,
    required this.selectHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
        onPressed: selectHandler,
        child: Text(answerText),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (resultScore >= 5) {
      resultText = 'Kemampuan yang sangat hebat!';
    } else if (resultScore >= 4) {
      resultText = 'Diatas rata-rata!';
    } else if (resultScore >= 3) {
      resultText = 'Sudah cukup bagus!';
    } else if (resultScore >= 2) {
      resultText = 'Lebih semangat belajar!';
    } else {
      resultText = 'Asah kemampuan lebih giat!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: resetHandler,
            child: Text('Ulangi Kuis'),
          ),
        ],
      ),
    );
  }
}