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

final onSearchProvider = StateProvider((ref) => false);
final StateProvider<Set<int>> searchIndexListProvider =
    StateProvider((ref) => <int>{});

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onSearchNotifier = ref.watch(onSearchProvider.notifier);
    final onSearch = ref.watch(onSearchProvider);
    final searchIndexListNotifier = ref.watch(searchIndexListProvider.notifier);

    return AsyncValueWidget(
      value: ref.watch(programListStateProvider),
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            title: onSearch ? _searchTextField(ref) : const Text('Search'),
            actions: onSearch
                ? [
                    IconButton(
                      onPressed: () {
                        onSearchNotifier.state = false;
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ]
                : [
                    IconButton(
                      onPressed: () {
                        onSearchNotifier.state = true;
                        searchIndexListNotifier.state = {};
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ],
          ),
          body: MainBodyWidget(
            body: SingleChildScrollView(
              child: onSearch ? _searchListView(ref) : Container(),
            ),
          ),
        );
      },
    );
  }

  Widget _searchTextField(WidgetRef ref) {
    final searchIndexListNotifier = ref.watch(searchIndexListProvider.notifier);
    // final searchIndexList = ref.watch(searchIndexListProvider);
    return TextField(
      autofocus: true,
      onChanged: (String text) {
        searchIndexListNotifier.state = {};
        for (var i = 0; i < program.length; i++) {
          final map = program[i];
          for (final key in map.keys) {
            final value = map[key];
            if (value.toString().contains(text)) {
              searchIndexListNotifier.state.add(i);
            }
          }
        }
      },
    );
  }

  Widget _searchListView(WidgetRef ref) {
    final searchIndexListNotifier = ref.watch(searchIndexListProvider.notifier);
    final searchIndexList = ref.watch(searchIndexListProvider);
    return ListView.builder(
      itemCount: searchIndexList.length,
      itemBuilder: (context, int index) {
        index = searchIndexListNotifier.state.toList()[index];
        return Card(
          child: ListTile(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             SearchDetailPage(title: wordList[index])));
            },
            title: Text(program[index].toString()),
          ),
        );
      },
    );
  }

  // Widget _defaultListView() {
  //   return ListView.builder(
  //     itemCount: wordList.length,
  //     itemBuilder: (context, index) {
  //       return Card(
  //         child: ListTile(
  //           onTap: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) =>
  //                         SearchDetailPage(title: wordList[index])));
  //           },
  //           title: Text(wordList[index]),
  //         ),
  //       );
  //     },
  //   );
  // }
}
