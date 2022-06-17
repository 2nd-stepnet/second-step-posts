import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //StringのList
    var stringList = <String>["あああ", "いいい"];
    //StringのListをTextウィジェットに変換し、Columnで縦に並べる
    var stringListWidget = Column(
      children: stringList.map((e) => Text(e)).toList(),
    );

    //intのList
    var intList = <int>[123, 456];
    //intのListをTextウィジェットに変換し、Columnで縦に並べる
    var intListWidget = Column(
      children: intList.map((e) => Text(e.toString())).toList(),
    );

    // 自分で作ったクラスのリスト
    // var myClassList = <MyClass>[
    //   MyClass("あああ"),
    //   MyClass("いいい"),
    //   MyClass(123.toString()),
    //   MyClass(456.toString()),
    // ];
    //stringListからMyClassのListを生成
    var myClassList = stringList.map((e) => MyClass("$e to MyClass")).toList();
    //intListからMyClassのIterableを生成
    //*addAllを使用する際は、toList()を使用せずにIterableのままでもOK
    myClassList
        .addAll(intList.map((e) => MyClass("${e.toString()} to MyClass")));

    //① クラスのフィールドにアクセスし、取得したデータをこちらでWidgetに加工する場合
    //MyClassのListをTextに変換し、Columnで縦に並べる
    var myClassTextList = Column(
      children: myClassList.map((e) => Text("${e.myData} to Text")).toList(),
    );
    //②-a クラスに特定のWidgetの生成を任せる場合（ListTile）
    //MyClassのListをListTileに変換し、Columnで縦に並べる
    var myClassListTileList = Column(
      children: myClassList.map((e) => e.buildListTile()).toList(),
    );
    //②-b クラスに特定のWidgetの生成を任せる場合（Button）
    //MyClassのListをButtonに変換し、Columnで縦に並べる
    var myClassButtonList = Column(
      children: myClassList.map((e) => e.buildButton()).toList(),
    );
    //②-c クラスに特定のWidgetの生成を任せる場合（Buttonとそのアクションを指定）
    //MyClassのListをButtonに変換し、Columnで縦に並べる
    var myClassButtonWithActionList = Column(
      children: myClassList
          .map((e) => e.buildButtonWithAction(
              () => print("${e.myData} pressed (from MyApp)")))
          .toList(),
    );

    //もちろん、任意の計算を行うint->intも可能です（以下は50を加算して、さらにTextに変換）
    var taxIncluded = Column(
        children: <int>[100, 200, 300]
            .map((e) => Text("int -> int ${e + 50}"))
            .toList());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              stringListWidget,
              intListWidget,
              myClassTextList,
              myClassListTileList,
              myClassButtonList,
              myClassButtonWithActionList,
              taxIncluded,
            ],
          ),
        ),
      ),
    );
  }
}

class MyClass {
  String myData;
  MyClass(this.myData);

  //myDataをListTile化するメソッド
  Widget buildListTile() {
    return ListTile(
      title: Text("$myData to ListTile"),
      onTap: () => print("$myData tapped"),
    );
  }

  //myDataをButton化するメソッド
  Widget buildButton() {
    return buildButtonWithAction(() => print("$myData pressed"));
  }

  //myDataをButton化するメソッド（Buttonの動作を指定するパターン）
  Widget buildButtonWithAction(VoidCallback action) {
    return OutlinedButton(
      onPressed: action,
      child: Text("$myData to OutlinedButton"),
    );
  }
}
