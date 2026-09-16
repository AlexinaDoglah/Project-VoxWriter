import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

import 'flag_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  FlutterTts flutterTts = FlutterTts();
  GoogleTranslator translator = GoogleTranslator();
  String inputText = '';
  bool _loading = false;
  List<String> _translatedTexts = [];
  final List<String> _languagesCode = [
    'en',
    'ru',
    'fr',
    'zh-cn',
    'hi',
    'de',
    'it',
    'es',
    'ja'
  ];
  Future translate() async {
    List<String> translatedTexts = [];
    setState(() {
      _loading = true;
    });
    for (String code in _languagesCode) {
      Translation translation = await translator.translate(inputText, to: code);
      String translatedText = translation.text;
      translatedTexts.add(translatedText);
    }
    setState(() {
      _translatedTexts = translatedTexts;
      _loading = false;
    });
  }

  Future speak(String languageCode, String text) async {
    await flutterTts.setLanguage(languageCode);
    await flutterTts.setPitch(1);
    await flutterTts.setVolume(5);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translator'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Column(
        children: [
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(25),
              hintText: 'Enter Text...',
              hintStyle: const TextStyle(color: Colors.white),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.green,
              suffixIcon: _loading
                  ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
                  : IconButton(
                icon: const Icon(
                  Icons.translate,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (inputText.isNotEmpty) translate();
                },
              ),
            ),
            onChanged: (input) {
              inputText = input;
            },
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                FlagButton(
                  text: _translatedTexts.isEmpty
                      ? 'English United States'
                      : _translatedTexts[0],
                  flag: 'united-states.png',
                  onTap: () {
                    if (_translatedTexts.isNotEmpty)
                      speak('en-US', _translatedTexts[0]);
                  },
                ),
                FlagButton(
                  text: _translatedTexts.isEmpty
                      ? 'English United Kingdom'
                      : _translatedTexts[0],
                  flag: 'united-kingdom.png',
                  onTap: () {
                    if (_translatedTexts.isNotEmpty) {
                      speak('en-GB', _translatedTexts[0]);
                    }
                  },
                ),
                FlagButton(
                  text: _translatedTexts.isEmpty
                      ? 'Russian'
                      : _translatedTexts[1],
                  flag: 'russia.png',
                  onTap: () {
                    if (_translatedTexts.isNotEmpty)
                      speak('ru-RU', _translatedTexts[1]);
                  },
                ),
                FlagButton(
                  text:
                  _translatedTexts.isEmpty ? 'French' : _translatedTexts[2],
                  flag: 'france.png',
                  onTap: () {
                    if (_translatedTexts.isNotEmpty)
                      speak('fr-FR', _translatedTexts[2]);
                  },
                ),
                FlagButton(
                  text: _translatedTexts.isEmpty
                      ? 'Chinese'
                      : _translatedTexts[3],
                  flag: 'china.png',
                  onTap: () {
                    if (_translatedTexts.isNotEmpty)
                      speak('zh-CN', _translatedTexts[3]);
                  },
                ),
                FlagButton(
                  text:
                  _translatedTexts.isEmpty ? 'Hindi' : _translatedTexts[4],
                  flag: 'india.png',
                  onTap: () {
                    if (_translatedTexts.isNotEmpty)
                      speak('hi-IN', _translatedTexts[4]);
                  },
                ),
                FlagButton(
                  text:
                  _translatedTexts.isEmpty ? 'German' : _translatedTexts[5],
                  flag: 'germany.png',
                  onTap: () {
                    if (_translatedTexts.isNotEmpty)
                      speak('de-DE', _translatedTexts[5]);
                  },
                ),
                FlagButton(
                  text: _translatedTexts.isEmpty
                      ? 'Italian'
                      : _translatedTexts[6],
                  flag: 'italy.png',
                  onTap: () {
                    if (_translatedTexts.isNotEmpty)
                      speak('it-IT', _translatedTexts[6]);
                  },
                ),
                FlagButton(
                  text: _translatedTexts.isEmpty
                      ? 'Spanish'
                      : _translatedTexts[7],
                  flag: 'spain.png',
                  onTap: () {
                    if (_translatedTexts.isNotEmpty)
                      speak('es-ES', _translatedTexts[7]);
                  },
                ),
                FlagButton(
                  text: _translatedTexts.isEmpty
                      ? 'Japanese'
                      : _translatedTexts[8],
                  flag: 'japan.png',
                  onTap: () {
                    if (_translatedTexts.isNotEmpty)
                      speak('ja-JP', _translatedTexts[8]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}