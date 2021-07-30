import 'package:flutter/material.dart';
import 'package:flutter_try_project/pallete.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    VoidCallback onPressed,
    @required this.buttonName,
  }) : super(
          key: key,
        );

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kBlue,
      ),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          buttonName,
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
