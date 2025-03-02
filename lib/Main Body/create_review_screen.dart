import 'package:e_commerce_project/App%20Widgets/next_button.dart';
import 'package:flutter/material.dart';

class CreateReviewScreen extends StatelessWidget {
  static const String route = "create-review-screen";

  CreateReviewScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text("Create Review"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
          top: 50,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 24,
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    hintText: "First Name",
                  ),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    hintText: "Last Name",
                  ),
                ),
                TextField(
                  controller: _reviewController,
                  decoration: const InputDecoration(
                    hintText: "Write Review",
                  ),
                  maxLines: 10,
                ),
                MyButton(
                  buttonActionName: "Submit",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
