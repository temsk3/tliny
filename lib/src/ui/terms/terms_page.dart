import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

        // ユーザー情報からメールアドレスと名前を取得
        final email = _getEmail(data);
        final name = _getName(data);

        // 特定商取引法に基づく表記の画面を構築
        return Scaffold(
          appBar: AppBar(title: const Text('特定商取引法に基づく表記')),
          body: MainBodyWidget(
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 販売業社の名称
                      _buildSectionTitle('販売業社の名称'),
                      _buildSectionText(name),
                      // 所在地
                      _buildSectionTitle('所在地'),
                      _buildSectionText('請求があったら遅滞なく開示します'),
                      // 電話番号
                      _buildSectionTitle('電話番号'),
                      _buildSectionText('請求があったら遅滞なく開示します'),
                      // メールアドレス
                      _buildSectionTitle('メールアドレス'),
                      _buildSectionText(email),
                      // 運営統括責任者
                      _buildSectionTitle('運営統括責任者'),
                      _buildSectionText(name),
                      // 追加手数料等の追加料金
                      _buildSectionTitle('追加手数料等の追加料金'),
                      _buildSectionText('なし'),
                      // 交換および返品（返金ポリシー）
                      _buildSectionTitle('交換および返品（返金ポリシー）'),
                      _buildSectionText('＜お客様都合の返品・交換の場合＞'),
                      _buildSectionText('引渡し処理前の商品：メールにてお問い合わせください。'),
                      _buildSectionText('引渡し処理後の商品：原則、返品・交換はお受けしておりません。'),
                      _buildSectionText(' '),
                      _buildSectionText('＜商品に不備がある場合＞'),
                      _buildSectionText('メールにてご連絡ください。'),
                      // 引渡時期
                      _buildSectionTitle('引渡時期'),
                      _buildSectionText('イベント開催期間'),
                      // 受け付け可能な決済手段
                      _buildSectionTitle('受け付け可能な決済手段'),
                      _buildSectionText('クレジットカード'),
                      // 決済期間
                      _buildSectionTitle('決済期間'),
                      _buildSectionText('クレジットカード決済はただちに処理されます。'),
                      // 販売価格
                      _buildSectionTitle('販売価格'),
                      _buildSectionText('各商品ページに記載の金額'),
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
  String _getEmail(User data) {
    return data.email == null ? 'No Email' : data.email!;
  }

  // 名前を取得する関数
  String _getName(User data) {
    return data.name == null ? 'No Name' : data.name!;
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
