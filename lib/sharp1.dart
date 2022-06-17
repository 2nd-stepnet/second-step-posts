//[pubspec.yaml]
//  environment:
//    sdk: ">=2.17.1 <3.0.1"

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

enum DeviceType {
  iPhoneSE(9.0 / 16.0, 16.0 / 9.0), //0.5625 , 1.7777
  iPhone13(9.0 / 19.5, 19.5 / 9.0), //0.4615 , 2.1666
  iPad(3.0 / 4.0, 4.0 / 3.0); //0.75 , 1.3333

  final double aspectRatioV; //縦アスペクト比
  final double aspectRatioH; //横アスペクト比
  const DeviceType(this.aspectRatioV, this.aspectRatioH);

  //アスペクト比から最も近いデバイスタイプを計算して返すメソッド
  static DeviceType nearest(double aspectRatio) {
    //各アスペクト比との差を絶対値で計算する
    var iPhoneSEabs =
        ((aspectRatio > 1 ? iPhoneSE.aspectRatioH : iPhoneSE.aspectRatioV) -
                aspectRatio)
            .abs();
    var iPhone13abs =
        ((aspectRatio > 1 ? iPhone13.aspectRatioH : iPhone13.aspectRatioV) -
                aspectRatio)
            .abs();
    var iPadabs = ((aspectRatio > 1 ? iPad.aspectRatioH : iPad.aspectRatioV) -
            aspectRatio)
        .abs();

    // print("iPhoneSEabs: $iPhoneSEabs");
    // print("iPhone13abs: $iPhone13abs");
    // print("iPadabs: $iPadabs");

    //enumと同じ順番でリストに格納する
    var list = <double>[iPhoneSEabs, iPhone13abs, iPadabs];

    //最大値を取得する
    var minValue = list.reduce(min);
    //print("minvalue: $minValue");

    //最大値から要素番号を取得する
    var index = list.indexOf(minValue);
    //print("index: $index");

    //enumのvaluesリストのindex番目を返す
    return DeviceType.values[index];
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Material());
  }
}

class Material extends StatelessWidget {
  const Material({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //MediaQuery.of(context).sizeで画面サイズを取得できる
    Size size = MediaQuery.of(context).size;

    //size.aspectRatioで画面のアスペクト比を取得できる
    //上記enumのnearestを呼び出し、最も近い画面比のデバイスを特定する
    DeviceType deviceType = DeviceType.nearest(size.aspectRatio);

    //アスペクト比が1を超えていれば横画面、そうでなければ縦画面
    String rotation = size.aspectRatio > 1 ? "横" : "縦";

    return Scaffold(
        body: Center(
      child: Text("$deviceType $rotation画面  横:${size.width} 縦:${size.height}"),
    ));
  }
}
