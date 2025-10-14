import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/model/program_model.dart';
import '../../data/repository/program_repository.dart';
import '../common/loading_screen.dart';

class SecretEventPage extends ConsumerStatefulWidget {
  const SecretEventPage({super.key, required this.secretUrl});

  final String secretUrl;

  @override
  ConsumerState<SecretEventPage> createState() => _SecretEventPageState();
}

class _SecretEventPageState extends ConsumerState<SecretEventPage> {
  Program? _program;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSecretEvent();
  }

  Future<void> _loadSecretEvent() async {
    try {
      final program = await ref
          .read(programRepositoryProvider)
          .getEventBySecretUrl(widget.secretUrl);

      if (mounted) {
        setState(() {
          _program = program;
          _isLoading = false;
          if (program == null) {
            _errorMessage = 'このイベントは存在しないか、URLが無効です。';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'イベントの読み込み中にエラーが発生しました。';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingScreen();
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('エラー')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('戻る'),
              ),
            ],
          ),
        ),
      );
    }

    if (_program == null) {
      return const SizedBox.shrink();
    }

    // シークレットイベントが見つかった場合は、簡易表示
    return Scaffold(
      appBar: AppBar(title: const Text('限定イベント')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _program!.name ?? 'イベント名不明',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    if (_program!.message != null) ...[
                      Text(
                        _program!.message!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (_program!.eventFrom != null &&
                        _program!.eventTo != null) ...[
                      Row(
                        children: [
                          const Icon(Icons.schedule, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '${_program!.eventFrom?.toString().substring(0, 16)} - ${_program!.eventTo?.toString().substring(0, 16)}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (_program!.place != null) ...[
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _program!.place!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(Icons.lock, size: 48, color: Colors.amber),
                    SizedBox(height: 8),
                    Text(
                      'この限定イベント情報',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'このイベントは限定公開されています。\n専用URLをお持ちの方のみアクセスできます。',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
