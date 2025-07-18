import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/ui/common/asyncvalue_widget.dart';
import 'package:tliny/src/ui/program/program_state.dart';

import '../common/main_body.dart';

final List<Map<String, dynamic>> program = [
  {'name': 'qwerty', 'disc': 'asdfgh'},
  {'name': 'zxcvbn', 'disc': 'uiop@[]'},
  {'name': 'jkl;:', 'disc': 'm,./_'},
];

final StateProvider<bool> onSearchProvider = StateProvider((ref) => false);
final StateProvider<Set<int>> searchIndexListProvider = StateProvider(
  (ref) => <int>{},
);

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onSearchNotifier = ref.watch(onSearchProvider.notifier);
    final onSearch = ref.watch(onSearchProvider);
    final searchIndexListNotifier = ref.watch(searchIndexListProvider.notifier);

    return AsyncValueWidget(
      value: ref.watch(programsStateProvider),
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child:
                  onSearch
                      ? _searchTextField(ref)
                      : const Text(
                        'Search',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
            ),
            actions: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child:
                    onSearch
                        ? IconButton(
                          key: const ValueKey('clear'),
                          onPressed: () {
                            onSearchNotifier.state = false;
                          },
                          icon: const Icon(Icons.clear),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                        : IconButton(
                          key: const ValueKey('search'),
                          onPressed: () {
                            onSearchNotifier.state = true;
                            searchIndexListNotifier.state = {};
                          },
                          icon: const Icon(Icons.search),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
              ),
            ],
          ),
          body: MainBodyWidget(
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: onSearch ? _searchListView(ref) : _defaultContent(),
            ),
          ),
        );
      },
    );
  }

  Widget _searchTextField(WidgetRef ref) {
    final searchIndexListNotifier = ref.watch(searchIndexListProvider.notifier);

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: TextField(
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Search programs...',
          prefixIcon: Icon(Icons.search, size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: const TextStyle(fontSize: 16),
        onChanged: (String text) {
          searchIndexListNotifier.state = {};
          for (var i = 0; i < program.length; i++) {
            final map = program[i];
            for (final key in map.keys) {
              final value = map[key];
              if (value.toString().toLowerCase().contains(text.toLowerCase())) {
                searchIndexListNotifier.state.add(i);
              }
            }
          }
        },
      ),
    );
  }

  Widget _searchListView(WidgetRef ref) {
    final searchIndexList = ref.watch(searchIndexListProvider);

    if (searchIndexList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: searchIndexList.length,
      itemBuilder: (context, int index) {
        final actualIndex = searchIndexList.toList()[index];
        final item = program[actualIndex];

        return AnimatedContainer(
          duration: Duration(milliseconds: 200 + (index * 50)),
          margin: const EdgeInsets.only(bottom: 12),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             SearchDetailPage(title: wordList[index])));
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.code, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (item['name'] as String?) ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (item['disc'] != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  item['disc'] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _defaultContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search,
              size: 64,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Search Programs',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the search icon to find what you\'re looking for',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
