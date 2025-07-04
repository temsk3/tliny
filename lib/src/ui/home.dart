import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../settings/hooks/use_l10n.dart';
import '../settings/routes/routes.dart';
import '../utils/logger.dart';
import '../utils/router_utils.dart';
import 'drawer/drawer.dart';

enum PageIndex { top, cart, ticket }

class HomePage extends HookConsumerWidget {
  const HomePage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(navigationShell.currentIndex);
    useEffect(() {
      currentIndex.value = navigationShell.currentIndex;
      return null;
    }, [navigationShell.currentIndex]);
    // スプラッシュスクリーン表示終了
    FlutterNativeSplash.remove();
    logger.i('スプラッシュスクリーンを終了しました'); // loggerでログ出力

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: _appBar(context),
        drawer: const CustomDrawer(),
        body: navigationShell,
        bottomNavigationBar: _bottomNavigationBar(context, currentIndex, ref),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: _showLeading(context) ? _leadButton(context) : null,
      title: const Text('TLINY Sample'),
    );
  }

  // 戻るボタン
  Widget _leadButton(BuildContext context) {
    return GestureDetector(
      onTap: () => RouterUtils.safePop(context),
      child: const Icon(Icons.arrow_back),
    );
  }

  // 戻るボタンを表示するかの判定
  bool _showLeading(BuildContext context) {
    return ![
      AppRoutes.topPage,
      AppRoutes.cartPage,
      AppRoutes.ticketPage,
    ].contains(GoRouterState.of(context).uri.toString());
  }

  BottomNavigationBar _bottomNavigationBar(
    BuildContext context,
    ValueNotifier<int> currentIndex,
    WidgetRef ref,
  ) {
    final l10n = useL10n();
    const quantity = 0;
    return BottomNavigationBar(
      currentIndex: currentIndex.value,
      items: <BottomNavigationBarItem>[
        // Top
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          label: l10n.home,
          activeIcon: const Icon(Icons.home),
        ),
        // Cart
        BottomNavigationBarItem(
          icon: Badge(
            isLabelVisible: (quantity == 0) ? false : true,
            label: Text(quantity.toString()),
            child: const Icon(Icons.shopping_cart_outlined),
          ),
          label: l10n.cart,
          activeIcon: Badge(
            isLabelVisible: (quantity == 0) ? false : true,
            label: Text(quantity.toString()),
            child: const Icon(Icons.shopping_cart),
          ),
        ),
        // Ticket
        BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.ticket),
          label: l10n.ticket,
          activeIcon: const FaIcon(FontAwesomeIcons.ticketSimple),
        ),
      ],
      onTap: (int index) {
        currentIndex.value = index;
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
    );
  }
}
