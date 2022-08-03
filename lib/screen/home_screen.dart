import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_maker/component/number_row.dart';
import 'package:random_maker/constant/color.dart';
import 'package:random_maker/screen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int maxNumber = 1000;
  List<int> randomNumbers = [
    123,
    456,
    678,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                callback: onSettingsPop,
              ),
              _Body(
                randomNumbers: randomNumbers,
              ),
              _Footer(
                callback: callback,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSettingsPop() async {
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SettingScreen(currentMaxNumber: maxNumber,);
        },
      ),
    );

    if (result == null) {
      return;
    }

    setState(() {
      maxNumber = result;
    });
  }

  void callback() {
    final rand = Random();
    final Set<int> newNumbers = {};
    while (newNumbers.length < 3) {
      final number = rand.nextInt(maxNumber);
      newNumbers.add(number);
    }

    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }
}

class _Body extends StatelessWidget {
  List<int> randomNumbers;

  _Body({required this.randomNumbers, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            .asMap()
            .entries
            .map(
              (x) => Padding(
                padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16.0),
                child: NumberRow(
                  number: x.value,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  VoidCallback callback;
  _Header({required this.callback, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '랜덤숫자 생성기',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w700),
        ),
        IconButton(
          onPressed: callback,
          icon: const Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  VoidCallback callback;
  _Footer({required this.callback, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: RED_COLOR,
        ),
        onPressed: callback,
        child: const Text('생성하기'),
      ),
    );
  }
}
