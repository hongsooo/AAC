// APK 파일 경로:

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '삐뽀삐뽀 Talk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: '삐뽀삐뽀 Talk'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// TODO
// 1. 1(초기화면), 2(안내문구) 페이지 추가 - 페이지에 앞뒤 버튼(<- ->) 존재 - 완료
// 2. 증상 가이드 텍스트 추가 - 완료
//     1. 어디가 아픈가요?
//     2. 어떻게 아픈가요?
//     3. 얼마나 아픈가요?
// 3. 3단계 (얼마나 아픈가요) 이미지 및 로직 적용 - 완료

class _MyHomePageState extends State<MyHomePage> {
  // itemType: 1
  final items = ['머리', '목', '배', '감기', '눈', '코', '입', '귀'];

  // itemType: 2
  final subItems = [
    ['열나요', '어지러워요', '머리가 아파요'],
    ['목이 부었어요', '목이 아파요', '목이 간지러워요', '목이 따끔 거려요'],
    ['체했어요', '차가워요', '토를 해요', '설사를 해요', '변비가 심해요', '배가 아파요'],
    ['몸이 아파요', '욱신욱신해요', '열나요'],
    ['눈물이 나요', '눈이 간지러워요', '눈이 따끔거려요'],
    ['콧물이 나요', '재채기를 해요', '코가 막혔어요'],
    ['기침나요', '입안이 깔깔해요'],
    ['귀가 먹먹해요', '귀가 간지러워요', '귀가 아파요']
  ];

  // itemType: 3
  final levelItems = ['가끔 아파요', '조금 아파요', '많이 아파요', '증세가 심해지고 있어요'];

  int currentPage = 1;
  int currentItemType = 1;
  int selectedItemIndex = -1;
  int selectedSubItemIndex = -1;
  int selectedSubItemSubIndex = -1;
  int selectedLevelItemIndex = -1;

  String getQuestion() {
    if (currentItemType == 1) {
      return '어디가 아픈가요?';
    } else if (currentItemType == 2) {
      return '어떻게 아픈가요?';
    } else if (currentItemType == 3) {
      return '얼마나 아픈가요?';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: currentPage == 1 || currentPage == 2
          ? Container(
              color: const Color(0xFFFFEBB6),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset('images/intro.jpg'),
                  ),
                  currentPage == 2
                      ? const Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 230),
                            child: Text(
                              '화면을 보면서, 원하는 그림을 눌러주세요.',
                              style: TextStyle(
                                color: Color(0xFF9ADDD6),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          currentPage == 2
                              ? InkWell(
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 100,
                                    color: Color(0xFF9ADDD6),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      currentPage = 1;
                                    });
                                  },
                                )
                              : const SizedBox(width: 100),
                          InkWell(
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 100,
                              color: Color(0xFF9ADDD6),
                            ),
                            onTap: () {
                              setState(() {
                                currentPage = currentPage == 1 ? 2 : 3;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
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
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8,
                      direction: Axis.vertical,
                      children: [
                        Text('어디가 아픈가요? ${selectedItemIndex > -1 ? items[selectedItemIndex] : ''}'),
                        Text(
                            '어떻게 아픈가요? ${selectedSubItemIndex > -1 && selectedSubItemSubIndex > -1 ? subItems[selectedSubItemIndex][selectedSubItemSubIndex] : ''}'),
                        Text('얼마나 아픈가요? ${selectedLevelItemIndex > -1 ? levelItems[selectedLevelItemIndex] : ''}'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(getQuestion(), style: const TextStyle(fontSize: 18)),
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
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('images/1-$i.JPG', width: 70),
                                          Text(e),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedItemIndex = i;
                                      selectedSubItemIndex = i;
                                      selectedSubItemSubIndex = -1;
                                      selectedLevelItemIndex = -1;
                                      currentItemType++;
                                    });
                                  },
                                ),
                              ),
                            )
                            .values
                            .toList()
                        : currentItemType == 2
                            ? subItems[selectedSubItemIndex]
                                .asMap()
                                .map(
                                  (i, e) => MapEntry(
                                    i,
                                    InkWell(
                                      child: Card(
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset('images/2-$selectedSubItemIndex-$i.JPG', width: 70),
                                              Text(e.toString()),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedSubItemSubIndex = i;
                                          selectedLevelItemIndex = -1;
                                          currentItemType++;
                                        });
                                      },
                                    ),
                                  ),
                                )
                                .values
                                .toList()
                            : levelItems
                                .asMap()
                                .map(
                                  (i, e) => MapEntry(
                                    i,
                                    InkWell(
                                      child: Card(
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset('images/3-$i.JPG', width: 70),
                                              Text(e.toString()),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedLevelItemIndex = i;
                                        });
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
