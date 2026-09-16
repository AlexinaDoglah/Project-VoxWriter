import 'package:flutter/material.dart';

class FlagButton extends StatelessWidget {
  final String text;
  final String flag;
  final void Function()? onTap;

  const FlagButton({
    super.key,
    required this.text,
    required this.flag,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.green[300],//Color(0xff263238),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Image.asset(
              'assets/$flag',
              width: 50,
            ),

            const SizedBox(width: 20),
            Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

