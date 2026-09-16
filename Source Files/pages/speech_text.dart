import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _wordsSpoken = "";
  double _confidenceLevel = 0;

  get text => _wordsSpoken; //null;

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _confidenceLevel = 0;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}";
      _confidenceLevel = result.confidence;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Speech To Text',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                _speechToText.isListening
                    ? "listening..."
                    : _speechEnabled
                    ? "Tap the microphone to start listening..."
                    : "Speech not available",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 20), // Add some space
            Center(
              child: ElevatedButton(
                child: const Text('Copy Text'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: text));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Text copied to clipboard')),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  _wordsSpoken,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            if (_speechToText.isNotListening && _confidenceLevel > 0)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 100,
                ),
                child: Text(
                  "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speechToText.isListening ? _stopListening : _startListening,
        tooltip: 'Listen',
        child: Icon(
          _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
