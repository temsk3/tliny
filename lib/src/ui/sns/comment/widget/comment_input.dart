import 'package:flutter/material.dart';

class CommentInput extends StatefulWidget {
  const CommentInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSubmit;

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final isTyping = widget.controller.text.trim().isNotEmpty;
    if (_isTyping != isTyping) {
      setState(() {
        _isTyping = isTyping;
      });
    }
  }

  void _handleSubmit() {
    final content = widget.controller.text.trim();
    if (content.isNotEmpty) {
      widget.onSubmit(content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.3), width: 0.5),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: 'コメントを入力...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                onSubmitted: (_) => _handleSubmit(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(
                Icons.send,
                color: _isTyping ? Theme.of(context).primaryColor : Colors.grey,
              ),
              onPressed: _isTyping ? _handleSubmit : null,
            ),
          ],
        ),
      ),
    );
  }
}
