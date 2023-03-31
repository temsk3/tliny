import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/my_program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/theme/app_theme.dart';
import '../../ui/common/main_body.dart';
import '../../ui/my_program/my_program_view_model.dart';
import '../common/asyncvalue_widget.dart';

@RoutePage()
class MyProgramPage extends HookConsumerWidget {
  const MyProgramPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();

    final state = ref.watch(myProgramViewModelProvider);
    final viewModel = ref.watch(myProgramViewModelProvider.notifier);

    return AsyncValueButtonWidget(
      value: state,
      data: (data) {
        return Scaffold(
          body: MainBodyWidget(
            body: data.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final myProgram = data[index];
                          return Text(myProgram.programId!);
                        },
                      ),
                    ],
                  )
                : Container(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              viewModel.addMyProgram(MyProgram.empty());
            },
            child: const Icon(Icons.qr_code),
          ),
        );
      },
    );
  }
}
