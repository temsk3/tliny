import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../ui/common/main_body.dart';
import '../../ui/staff/widget/staff_card.dart';
import '../common/asyncvalue_widget.dart';
import 'staff_view_model.dart';

// final logger = Logger();

// @RoutePage()
class StaffPage extends HookConsumerWidget {
  const StaffPage({super.key, required this.programId});
  final String programId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    // final l10n = useL10n();
    // final appRoute = useRouter();
    // final appMQ = useMediaQuery();
    // final state = ref.watch(programStateProvider);
    final state = ref.watch(staffViewModelProvider(programId));
    final viewModel = ref.watch(staffViewModelProvider(programId).notifier);

    return AsyncValueWidget(
      value: state,
      data: (data) {
        return Scaffold(
          body: MainBodyWidget(
            body: Center(
              child: data.isNotEmpty
                  ? ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      // itemExtent: 100,
                      itemCount: data.length,
                      itemBuilder: (_, index) {
                        final staff = data[index];
                        return StaffCard(staff: staff);
                      },
                    )
                  : Container(),
            ),
          ),
        );
      },
    );
  }
}
