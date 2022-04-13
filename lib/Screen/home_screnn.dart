import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mytap/modal/data_class.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// inch, meter, foot, centimeter
  final inchController = TextEditingController();
  final meterController = TextEditingController();
  final footController = TextEditingController();
  final centimeterController = TextEditingController();

  final int forMeter = 100;
  final int forCM = 100;
  final double forFoot = 30.48;
  final double forInch = 2.54;

  final List<TapData> myProducts = [
    TapData("inch", TapType.inch, TextEditingController()),
    TapData("meter", TapType.meter, TextEditingController()),
    TapData("foot", TapType.foot, TextEditingController()),
    TapData("centimeter", TapType.centimeter, TextEditingController()),
  ];

  Widget textInputWithIcon(
      {required String text,
      required TapType tapType,
      required TextEditingController? textEditingController}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(size: 77),
                TextField(
                  controller: setController(tapType),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(hintText: text),
                  onSubmitted: (String text) {
                    doCalculation(tapType);
                  },
                )
              ]),
        ],
      ),
    );
  }

  String truncateString(String data, int length) {
    return (data.length >= length) ? '${data.substring(0, length)}...' : data;
  }

  // String trimText(int num) {
  //   var char = num.toString();

  //   if (char.length > 5) {
  //    char =  'My Very Long Text'.truncateString(7); // My Very...
  //   }

  //   return "";
  // }

  TextEditingController setController(TapType tapType) {
    switch (tapType) {
      case TapType.centimeter:
        return centimeterController;
      case TapType.meter:
        return meterController;
      case TapType.foot:
        return footController;
      case TapType.inch:
        return inchController;
      default:
        return centimeterController;
    }
  }

  void doCalculation(TapType tapType) {
    //* Update CM to ich
    var givenValue = int.parse(setController(tapType).text);

    switch (tapType) {
      case TapType.centimeter:
        var meter = givenValue / forMeter;
        var foot = givenValue / forFoot;
        var inch = givenValue / forInch;

        meterController.text = truncateString(meter.toString(), 5);
        footController.text = truncateString(foot.toString(), 5);
        inchController.text = truncateString(inch.toString(), 5);

        break;
      case TapType.meter:
        var cm = givenValue * forCM;
        var foot = givenValue * 3.281;
        var inch = givenValue * 39.37;

        centimeterController.text = cm.toString();
        footController.text = foot.toString();
        inchController.text = inch.toString();

        break;
      case TapType.foot:
        var cm = givenValue * forFoot;
        var meter = givenValue / 3.281;
        var inch = givenValue * 12;

        centimeterController.text = cm.toString();
        meterController.text = meter.toString();
        inchController.text = inch.toString();

        break;
      case TapType.inch:
        var cm = givenValue * 2.54;
        var foot = givenValue / 12;
        var meeter = givenValue / 39.37;

        centimeterController.text = cm.toString();
        footController.text = foot.toString();
        meterController.text = meeter.toString();

        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 350,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {
              return Card(
                child: Container(
                  alignment: Alignment.center,
                  child: textInputWithIcon(
                      text: myProducts[index].title,
                      tapType: myProducts[index].tapType,
                      textEditingController:
                          myProducts[index].textEditingController),
                ),
              );
            }),
      ),
    );
  }
}
