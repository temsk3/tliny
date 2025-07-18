import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../data/model/user_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../ui/common/main_body.dart';
import '../../ui/terms/terms_view_model.dart';
import '../../utils/logger.dart';
import '../common/asyncvalue_widget.dart';

class TermsPage extends HookConsumerWidget {
  const TermsPage({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logger.d(uid);
    // スプラッシュスクリーン表示終了
    FlutterNativeSplash.remove();

    final l10n = useL10n();
    final appMediaQuery = useMediaQuery();
    final state = ref.watch(termsViewModelProvider(uid));

    return AsyncValueWidget(
      value: state,
      data: (data) {
        logger.d(data);

        // uidがない場合は白紙のページを表示
        if (uid.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.specificCommercialCode)),
            body: const MainBodyWidget(body: Center(child: Text(''))),
          );
        }

        // User.empty()の場合は白紙のページを表示
        if (data.id == null || data.id!.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.specificCommercialCode)),
            body: const MainBodyWidget(body: Center(child: Text(''))),
          );
        }

        // ユーザー情報からメールアドレスと名前を取得
        final email = _getEmail(data, l10n);
        final name = _getName(data, l10n);
        final displayName = _getDisplayName(data, l10n);

        // 特定商取引法に基づく表記の画面を構築
        return Scaffold(
          appBar: AppBar(title: Text(l10n.specificCommercialCode)),
          body: MainBodyWidget(
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 販売業社の名称
                      _buildSectionTitle(l10n.sellerName),
                      _buildSectionText(displayName),
                      // 所在地
                      _buildSectionTitle(l10n.address),
                      _buildSectionText(l10n.disclosureOnRequest),
                      // 電話番号
                      _buildSectionTitle(l10n.phoneNumber),
                      _buildSectionText(l10n.disclosureOnRequest),
                      // メールアドレス
                      _buildSectionTitle(l10n.emailAddress),
                      _buildSectionText(email),
                      // 運営統括責任者
                      _buildSectionTitle(l10n.operatorInCharge),
                      _buildSectionText(name),
                      // 追加手数料等の追加料金
                      _buildSectionTitle(l10n.additionalFees),
                      _buildSectionText(l10n.noAdditionalFees),
                      // 交換および返品（返金ポリシー）
                      _buildSectionTitle(l10n.returnPolicy),
                      _buildSectionText(l10n.customerReturnPolicy),
                      _buildSectionText(l10n.beforeDelivery),
                      _buildSectionText(l10n.afterDelivery),
                      _buildSectionText(' '),
                      _buildSectionText(l10n.defectiveProduct),
                      _buildSectionText(l10n.contactByEmail),
                      // 引渡時期
                      _buildSectionTitle(l10n.deliveryPeriod),
                      _buildSectionText(l10n.eventPeriod),
                      // 受け付け可能な決済手段
                      _buildSectionTitle(l10n.paymentMethods),
                      _buildSectionText(l10n.creditCard),
                      // 決済期間
                      _buildSectionTitle(l10n.paymentPeriod),
                      _buildSectionText(l10n.creditCardProcessing),
                      // 販売価格
                      _buildSectionTitle(l10n.sellingPrice),
                      _buildSectionText(l10n.priceOnProductPage),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // メールアドレスを取得する関数
  String _getEmail(User data, AppLocalizations l10n) {
    return data.email == null ? l10n.noEmail : data.email!;
  }

  // 名前を取得する関数
  String _getName(User data, AppLocalizations l10n) {
    return data.name == null ? l10n.noName : data.name!;
  }

  // 表示名を取得する関数
  String _getDisplayName(User data, AppLocalizations l10n) {
    return data.displayName == null ? l10n.noName : data.displayName!;
  }

  // セクションタイトルを構築する関数
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  // セクションテキストを構築する関数
  Widget _buildSectionText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }
}
