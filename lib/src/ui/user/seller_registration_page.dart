import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../ui/common/error_handler.dart';
import '../../ui/common/main_body.dart';
import '../../utils/logger.dart';
import '../../utils/router_utils.dart';
import '../common/asyncvalue_widget.dart';
import 'components/commercial_transaction_section.dart';
import 'components/seller_action_buttons.dart';
import 'user_view_model.dart';

class SellerRegistrationPage extends HookConsumerWidget {
  const SellerRegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    // final appMediaQuery = useMediaQuery();
    final state = ref.watch(userViewModelProvider);
    final viewModel = ref.watch(userViewModelProvider.notifier);

    return AsyncValueWidget(
      value: state,
      data: (data) {
        logger.d(data);

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.sellerRegistration),
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
              child: Column(
                children: [
                  // 特定商取引法セクション
                  CommercialTransactionSection(user: data),

                  // 出品者アクションボタン
                  SellerActionButtons(
                    user: data,
                    onAccountLinkPressed: () async {
                      try {
                        await viewModel.getAccountLink(data.email ?? '');
                      } catch (e) {
                        if (context.mounted) {
                          ErrorHandler.showErrorSnackBar(context, e, l10n);
                        }
                      }
                    },
                    onAdminSitePressed: () async {
                      try {
                        await viewModel.createLoginLink();
                      } catch (e) {
                        if (context.mounted) {
                          ErrorHandler.showErrorSnackBar(context, e, l10n);
                        }
                      }
                    },
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
