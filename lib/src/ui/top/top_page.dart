import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../l10n/app_localizations.dart';
import '../../data/model/program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/routes/routes.dart';
import '../../ui/common/main_body.dart';
import '../common/asyncvalue_widget.dart';
import '../program/program_state.dart';
import 'program_screen.dart';
import 'widgets/program_search_card.dart';

part 'top_page.g.dart';

// final logger = Logger();

@riverpod
class OnSearch extends _$OnSearch {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void setTrue() => state = true;
  void setFalse() => state = false;
}

@riverpod
class SearchIndexList extends _$SearchIndexList {
  @override
  Set<int> build() => <int>{};

  void clear() => state = <int>{};
  void add(int index) => state = {...state, index};
  void set(Set<int> newState) => state = newState;
}

// @RoutePage()
class TopPage extends HookConsumerWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    // // final appMediaQuery = useMediaQuery();

    final onSearch = ref.watch(onSearchProvider);

    return AsyncValueWidget(
      value: ref.watch(programsStateProvider),
      data: (list) {
        final data = list
            .where(
              (element) =>
                  element.isPublish == true && element.isActive == true,
            )
            .toList();
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            automaticallyImplyLeading: false,
            title: onSearch
                ? _searchTextField(context, ref, l10n, data)
                : null, // const Text('Search'),
            actions: onSearch
                ? [
                    IconButton(
                      onPressed: () {
                        ref.read(onSearchProvider.notifier).setFalse();
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ]
                : [
                    IconButton(
                      onPressed: () {
                        ref.read(onSearchProvider.notifier).setTrue();
                        ref.read(searchIndexListProvider.notifier).clear();
                      },
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      tooltip: l10n.searchEvent,
                    ),
                    IconButton(
                      onPressed: () {
                        ProgramEditRoute($extra: Program.empty()).push(context);
                      },
                      icon: const Icon(Icons.add),
                      tooltip: l10n.createEvent, // 必要に応じてl10nを使って多言語化
                    ),
                  ],
          ),
          body: onSearch
              ? MainBodyWidget(
                  body: Container(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: _searchListView(ref, data),
                  ),
                )
              : const EventScreen(), // TikTok風の全画面表示
        );
      },
    );
  }

  Widget _searchTextField(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    List<Program> data,
  ) {
    return SizedBox(
      height: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: l10n.searchText,
              contentPadding: const EdgeInsets.only(left: 8),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isDense: true,
            ),
            autofocus: true,
            onChanged: (String text) {
              final searchNotifier = ref.read(searchIndexListProvider.notifier);
              searchNotifier.clear();
              for (var i = 0; i < data.length; i++) {
                final map = data[i].toJson();
                for (final key in map.keys) {
                  final value = map[key];
                  if (value.toString().contains(text)) {
                    searchNotifier.add(i);
                  }
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _searchListView(
    WidgetRef ref,
    List<Program> data,
    // StackRouter appRoute,
  ) {
    final searchIndexList = ref.watch(searchIndexListProvider);
    return ListView.builder(
      itemCount: searchIndexList.length,
      itemBuilder: (context, int index) {
        index = searchIndexList.toList()[index];
        final program = data[index];
        return ProgramSearchCard(program: program);
      },
    );
  }

  // Widget _defaultListView(List<Program> data) {
  //   return ListView.builder(
  //     itemCount: data.length,
  //     itemBuilder: (context, index) {
  //       return Card(
  //         child: ListTile(
  //           onTap: () {},
  //           title: Text(data[index].name.toString()),
  //         ),
  //       );
  //     },
  //   );
  // }
}
