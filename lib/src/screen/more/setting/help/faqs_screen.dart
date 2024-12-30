import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<Question> questions = [
    Question(
      question:
          'What types of vehicles are suitable for metal recycling pickups?',
      answer:
          "We accept a variety of vehicles for recycling pickups, including trucks, vans, and trailers. Your vehicle should have sufficient capacity to transport the metal materials safely and securely. If you're unsure whether your vehicle meets our requirements, please contact our support team for assistance.",
    ),
    Question(
      question:
          'What safety precautions should I take duringmetal recycling pickups?',
      answer:
          "Safety is our top priority. Before starting a pickup, ensure that you're equipped with the necessary safety gear, such as gloves and safety goggles. Exercise caution when handling heavy or sharp metal objects, and secure your load properly to prevent shifting during transport. If you encounter any safety concerns during a pickup, don't hesitate to contact our support team for assistance.",
    ),
    Question(
      question: "How do I navigate to pickup locations the app?",
      answer:
          "Safety is our top priority. Before starting a pickup, ensure that you're equipped with the necessary safety gear, such as gloves and safety goggles. Exercise caution when handling heavy or sharp metal objects, and secure your load properly to prevent shifting during transport. If you encounter any safety concerns during a pickup, don't hesitate to contact our support team for assistance.",
    ),
    Question(
      question: "What should I do if I encounter any issues during a pickup?",
      answer:
          "Safety is our top priority. Before starting a pickup, ensure that you're equipped with the necessary safety gear, such as gloves and safety goggles. Exercise caution when handling heavy or sharp metal objects, and secure your load properly to prevent shifting during transport. If you encounter any safety concerns during a pickup, don't hesitate to contact our support team for assistance.",
    ),
    Question(
      question:
          "Can I track my earnings and view payment history through the app?",
      answer:
          "Safety is our top priority. Before starting a pickup, ensure that you're equipped with the necessary safety gear, such as gloves and safety goggles. Exercise caution when handling heavy or sharp metal objects, and secure your load properly to prevent shifting during transport. If you encounter any safety concerns during a pickup, don't hesitate to contact our support team for assistance.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'FAQs',
        isBackButtonExist: true,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          return QuestionTile(question: questions[index]);
        },
      ),
    );
  }
}

class QuestionTile extends StatefulWidget {
  final Question question;

  const QuestionTile({super.key, required this.question});

  @override
  _QuestionTileState createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 1.0,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  // Add Expanded here
                  child: Text(
                    widget.question.question,
                    style: AppStyles.text12PxMedium,
                    textAlign: TextAlign.start, // Align text to start
                  ),
                ),
                isExpanded
                    ? const Icon(Icons.keyboard_arrow_up)
                    : const Icon(Icons.keyboard_arrow_down)
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
              color: AppColors.kPrimaryColor.withOpacity(0.10),
            ),
            child: Text(
              widget.question.answer,
              style: AppStyles.text12PxRegular,
            ),
          ),
        Gaps.verticalGapOf(5)
      ],
    );
  }
}

class Question {
  final String question;
  final String answer;

  Question({required this.question, required this.answer});
}
