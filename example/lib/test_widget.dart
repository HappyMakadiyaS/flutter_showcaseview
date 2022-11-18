import 'dart:math';

import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import 'helper.dart';

Random random = Random();

extension RandomExtension on Random {
  int fromRange(int min, int max) => nextInt(max - min + 1) + min;

  T fromListRange<T>(List<T> list) =>
      list[random.fromRange(0, list.length - 1)];
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShowCaseWidget(
        builder: Builder(
          builder: (context) => const TestShowcase(),
        ),
      ),
    );
  }
}

class TestShowcase extends StatefulWidget {
  const TestShowcase({Key? key}) : super(key: key);

  @override
  State<TestShowcase> createState() => _TestShowcaseState();
}

class _TestShowcaseState extends State<TestShowcase> {
  List<GlobalKey> keys = List.generate(12, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    startShowcase();
  }

  void startShowcase() =>
      ambiguate(WidgetsBinding.instance)?.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase(keys),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: startShowcase,
        child: const Icon(Icons.play_arrow),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            rowBox(keys.sublist(0, 4)),
            rowBox(keys.sublist(4, 8)),
            rowBox(keys.sublist(8, 12)),
          ],
        ),
      ),
    );
  }

  Widget rowBox(List<GlobalKey> k) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: k.map((e) => RandomBox(showCaseKey: e)).toList(),
    );
  }
}

class RandomBox extends StatelessWidget {
  RandomBox({Key? key, required this.showCaseKey}) : super(key: key);
  final GlobalKey showCaseKey;

  List<bool> boolList = [false, true];

  List<String?> titleList = [
    null,
    "This is Title Of showcase view",
    "There are many variations of passages of Lorem Ipsum available, \nbut the majority"
  ];

  List<String> descList = [
    "Des: This is Description Of showcase view",
    "Desc: There are many variations of passages of Lorem Ipsum available, \nbut the majority have suffered",
    "Desc: We cannot respond to you personally, but please know that your message has been received and will be reviewed by the iPhone Team."
  ];

  @override
  Widget build(BuildContext context) {
    final title = random.fromListRange(titleList);
    final desc = random.fromListRange(descList);
    final isDefaultShowcase = false;
    // final isDefaultShowcase = random.fromListRange(boolList);

    return isDefaultShowcase
        ? Showcase(
            key: showCaseKey,
            title: title,
            // title: titleList[1],
            description: desc,
            onTargetClick: () => ShowCaseWidget.of(context).dismiss(),
            disposeOnTap: true,
            overlayPadding: const EdgeInsets.all(10),
            child: box(),
          )
        : Showcase.withWidget(
            key: showCaseKey,
            child: box(),
            container: Container(
              padding: EdgeInsets.all(20),
              color: Colors.green,
              child: Text(desc),
            ),
            height: 100,
            width: 0,
          );
  }

  Widget box() {
    return Container(
      width: 70,
      height: 70,
      color: Colors.red,
    );
  }
}
