import 'package:flutter/material.dart';

Widget cwHeadingTitle(BuildContext context, {required String title}) {
  return Text(
    title,
    textAlign: TextAlign.start,
    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
  );
}

