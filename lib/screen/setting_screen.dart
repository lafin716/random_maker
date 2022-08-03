import 'package:flutter/material.dart';
import 'package:random_maker/component/number_row.dart';
import 'package:random_maker/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int currentMaxNumber;

  const SettingScreen({required this.currentMaxNumber, Key? key})
      : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    super.initState();
    maxNumber = widget.currentMaxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Body(
                maxNumber: maxNumber.toInt(),
              ),
              _Footer(
                maxNumber: maxNumber,
                onPressed: onPressed,
                onSliderChanged: onSliderChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSliderChanged(double value) {
    setState(() {
      maxNumber = value;
    });
  }

  void onPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Body extends StatelessWidget {
  final int maxNumber;

  const _Body({
    required this.maxNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(
        number: maxNumber,
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  double maxNumber = 1000;
  final VoidCallback onPressed;
  final ValueChanged<double>? onSliderChanged;

  _Footer(
      {required this.maxNumber,
      required this.onPressed,
      required this.onSliderChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onSliderChanged,
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(primary: RED_COLOR),
          child: Text('저장'),
        ),
      ],
    );
  }
}
