import 'package:flutter/material.dart';

class AddInfoBox extends StatelessWidget {
  //final ensures that the variable cannot be changed after initialization
  final TextEditingController controller; // Controller to manage the text input
  final String hintText; //the placeholder text when the field is empty
  final double height; //set the default heaight of 56 pixels and cannot be changed

  const AddInfoBox({
    super.key, //super.key is used to pass the key to the parent class to make sure everything is constant
    required this.controller,// Controller to manage the text input
    required this.hintText,// the placeholder text when the field is empty
    this.height = 56,// the default height of 56 pixels and cannot be changed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),// pad around the text field
      child: SizedBox(
        height: height, // set the default height of the text field
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: const Color(0xFFD9D9D9),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
      ),
    );
  }
}