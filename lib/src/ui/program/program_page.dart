import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../ui/common/main_body.dart';
import '../../ui/program/program_state.dart';
import '../../ui/program/widget/program_button.dart';
import '../common/asyncvalue_widget.dart';
import 'program_view_model.dart';
import 'widget/program_card.dart';

// final logger = Logger();

// @RoutePage()
class ProgramPage extends HookConsumerWidget {
  const ProgramPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    // final l10n = useL10n();
    // final appRoute = useRouter();
    // final appMQ = useMediaQuery();
    final state = ref.watch(programsStateProvider);
    // final state = ref.watch(programViewModelProvider);
    final viewModel = ref.watch(programViewModelProvider.notifier);

    // final authState = ref.watch(authViewModelProvider);
    // final uid = authState?.uid;

    return AsyncValueWidget(
      value: state,
      data: (data) {
        final list =
            data.where((program) => program.isActive == true).toList() ?? [];
        // final list = data.programList;
        return Scaffold(
          body: MainBodyWidget(
            body:
                list.isNotEmpty
                    ? ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemExtent: 100,
                      // physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (_, index) {
                        final program = list[index];
                        return EventCard(program: program);
                      },
                    )
                    : Container(),
          ),
          floatingActionButton: AddProgramFloatingActionButton(
            heroTag: 'program_page_fab',
            onPressed: () {
              // プログラム追加画面への遷移はAddProgramFloatingActionButton内で処理
            },
          ),
        );
      },
    );
  }
}
