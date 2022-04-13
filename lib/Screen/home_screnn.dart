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
    TapData("Inch", TapType.inch, TextEditingController()),
    TapData("Meter", TapType.meter, TextEditingController()),
    TapData("Foot", TapType.foot, TextEditingController()),
    TapData("Centimeter", TapType.centimeter, TextEditingController()),
  ];

  Widget textInputWithIcon(
      {required String text,
      required TapType tapType,
      required TextEditingController? textEditingController}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextField(
                  style: const TextStyle(
                    fontSize: 22.0,
                    height: 2.0,
                  ),
                  controller: setController(tapType),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(hintText: text),
                  onSubmitted: (String text) {
                    doCalculation(tapType);
                  },
                )
              ]),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              text,
              style: const TextStyle(fontSize: 22),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 26),
              height: 90,
              child: Image.asset(
                "asset/image/app_icon.png",
              )),
          // FlutterLogo(size: 88),
        ],
      ),
    );
  }

  String truncateString(String data, int length) {
    return (data.length >= length) ? '${data.substring(0, length)}...' : data;
  }

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

        centimeterController.text = truncateString(cm.toString(), 5);
        footController.text = truncateString(foot.toString(), 5);
        inchController.text = truncateString(inch.toString(), 5);

        break;
      case TapType.foot:
        var cm = givenValue * forFoot;
        var meter = givenValue / 3.281;
        var inch = givenValue * 12;

        centimeterController.text = truncateString(cm.toString(), 5);
        meterController.text = truncateString(meter.toString(), 5);
        inchController.text = truncateString(inch.toString(), 5);

        break;
      case TapType.inch:
        var cm = givenValue * 2.54;
        var foot = givenValue / 12;
        var meeter = givenValue / 39.37;

        centimeterController.text = truncateString(cm.toString(), 5);
        footController.text = truncateString(foot.toString(), 5);
        meterController.text = truncateString(meeter.toString(), 5);

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
                maxCrossAxisExtent: 200,
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
