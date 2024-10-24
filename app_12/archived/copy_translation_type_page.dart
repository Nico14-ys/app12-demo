import 'package:flutter/material.dart';

class TranslationTypePage extends StatefulWidget {
  const TranslationTypePage({super.key});

  @override
  _TranslationTypePageState createState() => _TranslationTypePageState();
}

class _TranslationTypePageState extends State<TranslationTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.35,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 32, 158, 187),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('試解釋以下文句中的粗體字。\n',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 159, 220, 249))),
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Color.fromARGB(255, 142, 202, 230),
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: '然後知吾'),
                                  TextSpan(
                                      text: '嚮',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 159, 220, 249))),
                                  TextSpan(text: '之未始遊，遊於是乎始……'),
                                ],
                              ),
                            ),
                            const Align(
                                alignment: Alignment.bottomRight,
                                child: Text('《始得西山宴遊記》')),
                          ])),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '嚮？',
                          hintStyle: const TextStyle(
                              fontSize: 20.0,
                              color: Color.fromARGB(176, 157, 157, 157)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: const BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(255, 100, 178, 187)),
                          ),
                        ),
                        cursorColor: const Color.fromARGB(255, 100, 178, 187),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                        height: 60.0,
                        minWidth: 60.0,
                        elevation: 0,
                        focusElevation: 0,
                        hoverElevation: 0,
                        highlightElevation: 0,
                        disabledElevation: 0,
                        onPressed: () {},
                        color: const Color.fromARGB(255, 100, 178, 187),
                        child: const Icon(
                          Icons.check,
                          color: Color.fromARGB(255, 2, 71, 83),
                        ))
                  ],
                )
              ],
            )));
  }
}
