import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CatDog extends StatelessWidget {
  final double dogPercent;
  final double catPercent;

  const CatDog({
    Key? key,
    required this.dogPercent,
    required this.catPercent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Dog',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                    fontSize: 18),
              ),
              const VerticalDivider(thickness: 5),
              Expanded(
                child: LinearPercentIndicator(
                  backgroundColor: const Color.fromARGB(38, 3, 168, 244),
                  percent: dogPercent,
                  lineHeight: 35,
                  animation: true,
                  animateFromLastPercent: true,
                  progressColor: Colors.blueAccent,
                  center: Text('${(dogPercent * 100).toStringAsFixed(2)}%'),
                  barRadius: const Radius.circular(5),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Cat',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.orangeAccent,
                    fontSize: 18),
              ),
              const VerticalDivider(thickness: 5),
              Expanded(
                child: LinearPercentIndicator(
                  percent: catPercent,
                  lineHeight: 35,
                  animation: true,
                  animateFromLastPercent: true,
                  backgroundColor: const Color.fromARGB(48, 255, 153, 0),
                  progressColor: Colors.orangeAccent,
                  center: Text('${(catPercent * 100).toStringAsFixed(2)}%'),
                  barRadius: const Radius.circular(5),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
