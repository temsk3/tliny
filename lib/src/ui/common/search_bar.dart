import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../l10n/app_localizations.dart';
import '../../data/model/program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../utils/logger.dart';
import '../common/error_handler.dart';

part 'search_bar.g.dart';

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

/// 検索バーWidget
class SearchBar extends HookConsumerWidget implements PreferredSizeWidget {
  const SearchBar(this.data, {super.key});
  final List<Program> data;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    // 検索状態のNotifierを取得
    // 検索状態を取得
    final onSearch = ref.watch(onSearchProvider);

    logger.d('SearchBar: build', time: DateTime.now());
    try {
      return AppBar(
        // タイトルを設定
        title: onSearch
            ? _searchTextField(
                context,
                ref,
                data,
                l10n,
              ) // 検索状態の場合、検索テキストフィールドを表示
            : const Text('Search'), // 検索状態でない場合、"Search" テキストを表示
        // アクションボタンを設定
        actions: onSearch
            ? [
                // 検索をクリアするボタン
                IconButton(
                  onPressed: () {
                    logger.d('SearchBar: clear search', time: DateTime.now());
                    // 検索状態を false に設定
                    ref.read(onSearchProvider.notifier).setFalse();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ]
            : [
                // 検索を開始するボタン
                IconButton(
                  onPressed: () {
                    logger.d('SearchBar: start search', time: DateTime.now());
                    // 検索状態を true に設定
                    ref.read(onSearchProvider.notifier).setTrue();
                    // 検索結果のインデックスリストをクリア
                    ref.read(searchIndexListProvider.notifier).clear();
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
      );
    } on Exception catch (e, st) {
      // エラーが発生した場合、エラーログを出力
      logger.e('SearchBar: error=$e, stackTrace=$st', time: DateTime.now());
      // エラーメッセージを表示
      ErrorHandler.showErrorSnackBar(context, e, l10n);
      // エラー画面を表示
      return const Scaffold(body: Center(child: Text('エラーが発生しました')));
    }
  }

  /// 検索テキストフィールドWidget
  Widget _searchTextField(
    BuildContext context,
    WidgetRef ref,
    List<Program> data,
    AppLocalizations l10n,
  ) {
    // 検索結果のインデックスリストのNotifierを取得
    // 検索結果のインデックスリストを取得（未使用のため取得は行わない）

    logger.d('_searchTextField: build', time: DateTime.now());
    try {
      return SizedBox(
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              // ヒントテキストを設定
              decoration: const InputDecoration(
                hintText: 'Search Text',
                contentPadding: EdgeInsets.only(left: 8),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
              ),
              // 自動フォーカスを設定
              autofocus: true,
              // テキスト変更時の処理
              onChanged: (String text) {
                logger.d(
                  '_searchTextField: onChanged, text=$text',
                  time: DateTime.now(),
                );
                try {
                  // 検索結果のインデックスリストをクリア
                  ref.read(searchIndexListProvider.notifier).clear();
                  // データリストをループ処理
                  for (var i = 0; i < data.length; i++) {
                    // 各プログラムのデータをJSONに変換
                    final map = data[i].toJson();
                    // 各キーと値をループ処理
                    for (final key in map.keys) {
                      final value = map[key];
                      // 値が検索テキストを含む場合、インデックスリストに追加
                      if (value.toString().contains(text)) {
                        ref.read(searchIndexListProvider.notifier).add(i);
                      }
                    }
                  }
                } on Exception catch (e, st) {
                  // エラーが発生した場合、エラーログを出力
                  logger.e(
                    '_searchTextField: onChanged: error=$e, stackTrace=$st',
                    time: DateTime.now(),
                  );
                  // エラーメッセージを表示
                  ErrorHandler.showErrorSnackBar(context, e, l10n);
                }
              },
            ),
          ),
        ),
      );
    } on Exception catch (e, st) {
      logger.e(
        '_searchTextField: error=$e, stackTrace=$st',
        time: DateTime.now(),
      );
      ErrorHandler.showErrorSnackBar(context, e, l10n);
      return const Scaffold(body: Center(child: Text('エラーが発生しました')));
    }
  }
}
