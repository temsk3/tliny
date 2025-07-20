import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../ui/common/error_handler.dart';
import '../../ui/common/loading_screen.dart';
import '../../ui/common/main_body.dart';
import '../../utils/logger.dart';
import '../../utils/router_utils.dart';
import '../common/asyncvalue_widget.dart';
import 'components/index.dart';
import 'user_view_model.dart';

// final logger = Logger();

// @RoutePage()
class UserEditPage extends HookConsumerWidget {
  const UserEditPage({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final appMediaQuery = useMediaQuery();
    final state = ref.watch(userViewModelProvider);
    final viewModel = ref.watch(userViewModelProvider.notifier);
    final isLoading = ref.watch(globalLoadingControllerProvider);

    return AsyncValueWidget(
      value: state,
      data: (data) {
        logger.d(data);

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(l10n.profile),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => RouterUtils.safePop(context),
              icon: const Icon(Icons.arrow_back_ios_new),
              tooltip: l10n.backButton,
            ),
          ),
          body: MainBodyWidget(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: UserEditForm(
                  user: data,
                  onSave: (updatedUser) async {
                    try {
                      // ユーザー情報を更新
                      await viewModel.updateUser(updatedUser);
                      if (context.mounted) {
                        RouterUtils.safePop(context);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ErrorHandler.showErrorSnackBar(context, e, l10n);
                      }
                    }
                  },
                  onCancel: () => RouterUtils.safePop(context),
                  isLoading: isLoading,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
