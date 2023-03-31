import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:tliny/src/ui/top/my_program_screen.dart';
import 'package:tliny/src/ui/top/program_screen.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/theme/app_theme.dart';
import '../../ui/common/main_body.dart';
import '../common/search_bar.dart';
import '../program/widget/program_button.dart';

final logger = Logger();

@RoutePage()
class TopPage extends HookConsumerWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();

    return Scaffold(
      appBar: const SearchBar(),
      body: MainBodyWidget(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                EventScreen(),
                SizedBox(
                  height: 32,
                ),
                Divider(),
                MyProgramScreen(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const AddProgramFloatingActionButton(
          // onPressed: () async {
          //   await appRoute.push(ProgramEditRoute(program: Program.empty()));
          // },
          ),
    );
  }
}
