import 'package:demo_proj/features/ai/controller/ai_controller.dart';
import 'package:demo_proj/features/ai/screen/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final TextEditingController _questionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _questionController.dispose();
    _scrollController.dispose();
  }

  //we create method for to scroll our chat
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final aiController = context.watch<AiController>();
    _scrollToBottom();
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('AI Plant Assistant'))),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: aiController.messages.isEmpty
                  ? Center(
                      child: (Text(
                        'Ask me anything about plants 🌱',
                        style: TextStyle(fontSize: 16),
                      )),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: aiController.messages.length,
                      itemBuilder: (context, index) {
                        final messages = aiController.messages[index];
                        return Align(
                          alignment: messages.isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 6),
                            padding: EdgeInsets.all(12),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.8,
                            ),
                            decoration: BoxDecoration(
                              color: messages.isUser
                                  ? Colors.green.shade100
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: messages.isUser
                                ? Text(
                                    messages.text,
                                    style: TextStyle(fontSize: 16),
                                  )
                                : MarkdownBody(data: messages.text),
                          ),
                        );
                      },
                    ),
            ),
            if (aiController.isLoading)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: TypingIndicator(),
                ),
              ),
            if (aiController.errorMessage != null)
              Text(
                aiController.errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _questionController,
                    decoration: const InputDecoration(
                      hintText: 'Ask about plants...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: aiController.isLoading
                      ? null
                      : () {
                          final question = _questionController.text.trim();
                          if (question.isNotEmpty) {
                            context.read<AiController>().askAi(question);
                            _questionController.clear();
                          }
                        },
                  icon: Icon(
                    Icons.send,
                    color: aiController.isLoading ? Colors.grey : Colors.green,
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
