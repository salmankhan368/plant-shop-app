import 'package:firebase_ai/firebase_ai.dart';

class AiService {
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-3.5-flash-lite',
    systemInstruction: Content.system('''
You are an expert Plant Care Assistant.

Your job is to help users with:
- Plant care
- Watering advice
- Sunlight requirements
- Temperature and humidity
- Common plant problems
- Plant recommendations

Give simple, clear, and helpful answers.

Keep your answers concise and easy to understand.

If the user asks something completely unrelated to plants,
politely tell them that you are a Plant Care Assistant
and can help with plant-related questions.
'''),
  );

  Future<String> askAi(String question, List<Content> history) async {
    final chat = model.startChat(history: history);

    final response = await chat.sendMessage(Content.text(question));

    return response.text ?? 'No response from AI';
  }
}
