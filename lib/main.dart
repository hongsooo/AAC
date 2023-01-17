import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // itemType: 1
  final items = ['머리', '얼굴', '목', '배', '감기'];

  // itemType: 2
  final subItems = [
    ['열나요', '어지러워요', '머리가 아파요'],
    ['눈', '코', '입', '귀'],
    ['목이 부었어요', '목이 아파요', '목이 간지러워요', '목이 따끔 거려요'],
    ['체했어요', '차요', '토를 해요', '설사를 해요', '변비가 심해요', '배가 아파요'],
    ['몸이 아파요', '욱신욱신해요', '열나요']
  ];

  // itemType: 3
  final faceItems = [
    ['눈물이 나요', '눈이 간지러워요', '눈이 따끔거려요'],
    ['콧물이 나요', '재채기를 해요', '코가 막혔어요'],
    ['기침나요', '입안이 깔깔해요'],
    ['귀가 먹먹해요', '귀가 간지러워요', '귀가 아파요']
  ];

  int selectedItemIndex = 0;
  int currentItemType = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              if (currentItemType > 1) {
                setState(() {
                  currentItemType--;
                });
              }
            },
            child: const Text("뒤로가기"),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: currentItemType == 1
                  ? items
                      .asMap()
                      .map(
                        (i, e) => MapEntry(
                          i,
                          InkWell(
                            child: Card(
                              child: Center(child: Text(e)),
                            ),
                            onTap: () {
                              setState(() {
                                selectedItemIndex = i;
                                currentItemType = 2;
                              });
                            },
                          ),
                        ),
                      )
                      .values
                      .toList()
                  : currentItemType == 2
                      ? subItems[selectedItemIndex]
                          .asMap()
                          .map(
                            (i, e) => MapEntry(
                              i,
                              InkWell(
                                child: Card(
                                  child: Center(child: Text(e.toString())),
                                ),
                                onTap: () {
                                  if (selectedItemIndex == 1) {
                                    setState(() {
                                      selectedItemIndex = i;
                                      currentItemType = 3;
                                    });
                                  }
                                },
                              ),
                            ),
                          )
                          .values
                          .toList()
                      : faceItems[selectedItemIndex]
                          .asMap()
                          .map(
                            (i, e) => MapEntry(
                              i,
                              InkWell(
                                child: Card(
                                  child: Center(child: Text(e.toString())),
                                ),
                                onTap: () {
                                  setState(() {});
                                },
                              ),
                            ),
                          )
                          .values
                          .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
