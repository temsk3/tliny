import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'create_test_tickets.dart';

class TestTicketCreatorPage extends StatefulWidget {
  const TestTicketCreatorPage({super.key});

  @override
  State<TestTicketCreatorPage> createState() => _TestTicketCreatorPageState();
}

class _TestTicketCreatorPageState extends State<TestTicketCreatorPage> {
  final TestTicketCreator _ticketCreator = TestTicketCreator(
    FirebaseFirestore.instance,
  );
  var _isLoading = false;
  var _message = '';

  Future<void> _createTestTickets() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      await _ticketCreator.createTestTickets();
      setState(() {
        _message = 'テスト用チケットの作成が完了しました';
      });
    } catch (e) {
      setState(() {
        _message = 'エラー: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteTestTickets() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      await _ticketCreator.deleteTestTickets();
      setState(() {
        _message = 'テスト用チケットの削除が完了しました';
      });
    } catch (e) {
      setState(() {
        _message = 'エラー: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('テスト用チケット作成')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'テスト用チケット管理',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'このページでは、テスト用のチケットを作成・削除できます。',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _createTestTickets,
              child:
                  _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('テスト用チケットを作成'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _isLoading ? null : _deleteTestTickets,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child:
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('テスト用チケットを削除'),
            ),
            const SizedBox(height: 16),
            if (_message.isNotEmpty)
              Card(
                color:
                    _message.contains('エラー')
                        ? Colors.red[100]
                        : Colors.green[100],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _message,
                    style: TextStyle(
                      color:
                          _message.contains('エラー')
                              ? Colors.red[900]
                              : Colors.green[900],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
