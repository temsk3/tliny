import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'xxx_old_view_model.dart';

class XxxOldPage extends HookConsumerWidget {
  const XxxOldPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    // final l10n = useL10n();
    // final appRoute = useRouter();
    // final appMQ = useMediaQuery();
    final state = ref.watch(xxxOldViewModelProvider);
    final viewModel = ref.watch(xxxOldViewModelProvider.notifier);

    return state.when(data: (data) {
      final item = data.xxxList;
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: item.isNotEmpty
                ? ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    // itemExtent: 100,
                    itemCount: item.length,
                    itemBuilder: (_, index) {
                      final xxx = item[index];
                      return Dismissible(
                        direction: DismissDirection.horizontal,
                        key: UniqueKey(),
                        onDismissed: (direction) => {
                          logger.d('Dismissible'),
                          //delete
                          viewModel.deleteXxx(id: xxx.id.toString()),
                          // if (direction ==
                          //     DismissDirection.endToStart)
                          //   {
                          // 右から左
                          // logger.d('DismissibleEndToStart'),
                          // }
                        },
                        background: Container(
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: ListTile(
                          title: Text(xxx.id.toString()),
                          subtitle: Text(xxx.data),
                          onTap: () {
                            logger.d('onUpdate');
                            //update
                            viewModel.updateXxx(
                              id: xxx.id.toString(),
                              data: "update",
                            );
                          },
                        ),
                      );
                    },
                  )
                : Container(),
          ),
        ),
        floatingActionButton: Visibility(
          child: FloatingActionButton(
            onPressed: () async {
              logger.d('onCreate');
              //add
              viewModel.addXxx(data: "test");
            },
            child: const Icon(Icons.add_sharp),
          ),
        ),
      );
    }, error: (e, st) {
      return Scaffold(
        body: SafeArea(
          child: Center(
              child: Column(children: [
            Text(
              e.toString(),
            ),
            Text(
              st.toString(),
            ),
          ])),
        ),
      );
    }, loading: () {
      return const Scaffold(
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    });
  }
}
