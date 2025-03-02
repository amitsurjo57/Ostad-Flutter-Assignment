import 'package:e_commerce_project/Main%20Body/create_review_screen.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  static const String route = "review-screen";

  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withAlpha(32),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Reviews (1000)",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, CreateReviewScreen.route);
                },
                child: const CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xFF07ADAE),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    applyTextScaling: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
