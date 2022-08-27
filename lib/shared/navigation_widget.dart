import 'package:flutter/material.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({required this.title, this.child, Key? key})
      : super(key: key);
  final String title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        color: Colors.black.withOpacity(0.1),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                child: const Icon(Icons.arrow_back_ios),
                onTap: () => Navigator.pop(context),
              )),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          child ?? const SizedBox()
        ]));
  }
}
