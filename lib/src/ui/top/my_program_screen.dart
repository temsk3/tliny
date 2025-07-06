import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/ui/my_program/my_program_view_model.dart';
import 'package:tliny/src/ui/program/program_state.dart';

import '../../data/model/my_program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/routes/routes.dart';
import '../common/asyncvalue_widget.dart';

class MyProgramScreen extends HookConsumerWidget {
  const MyProgramScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    // final l10n = useL10n();
    // final appRoute = useRouter();

    final state = ref.watch(myProgramViewModelProvider);

    return AsyncValueButtonWidget(
      value: state,
      data: (data) {
        return data.isNotEmpty
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('My Event'),
                const SizedBox(height: 8),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final myProgram = data[index];
                    return MyProgramCard(myProgram: myProgram);
                  },
                ),
              ],
            )
            : Container();
      },
    );
  }
}

class MyProgramCard extends HookConsumerWidget {
  const MyProgramCard({super.key, required this.myProgram});
  final MyProgram myProgram;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    final state = ref.watch(programsStateProvider);
    return AsyncValueWidget(
      value: state,
      data: (data) {
        if (data.isNotEmpty) {
          final program = data.firstWhere(
            (program) => program.id == myProgram.id,
          );
          return Card(
            child: ListTile(
              title: Text(program.name!),
              subtitle: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topLeft,
                child: Text(
                  '${l10n.date(program.eventFrom!)}〜${l10n.date(program.eventTo!)}',
                  // style: theme.textTheme.h10,
                ),
              ),
              onTap: () {
                // appRoute.push(ProgramDetailsRoute(program: program));
                ProgramDetailRoute($extra: program).push<void>(context);
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
