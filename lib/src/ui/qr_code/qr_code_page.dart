import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/theme/app_theme.dart';
import '../../ui/common/asyncvalue_widget.dart';
import '../ticket/ticket_state.dart';

final logger = Logger();

String password = dotenv.get('QR_PASSWORD');

@RoutePage()
class CreateQRCodePage extends HookConsumerWidget {
  const CreateQRCodePage({
    super.key,
    required this.eventId,
    required this.ticketList,
  });
  final String eventId;
  final Set<String> ticketList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();

    final list = ticketList.toList();

    final code = '$eventId-${json.encode(list)}-$password';

    return Scaffold(
      appBar: AppBar(
        title: const Text('QRcode'),
      ),
      body: Column(
        children: [
          _qrCode(
            data: code,
            backgroundColor: theme.appColors.onPrimary,
            foregroundColor: theme.appColors.primary,
          ),
          // Center(
          //   child: IconButton(
          //     icon: const Icon(Icons.camera),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => Scanner()),
          //       );
          //     },
          //   ),
          // ),
          // const Divider(),
          Expanded(
            child: list.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.all(24),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      final id = list.toList()[index];
                      return AsyncValueButtonWidget(
                        value: ref.watch(ticketStateProvider(id)),
                        data: (data) {
                          logger.d(data.id, data);
                          return Row(
                            children: [
                              Text(data.code!),
                              const Spacer(),
                              Text(data.name!),
                            ],
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  Widget _qrCode({
    required String data,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    logger.d(data);
    return Center(
      child: QrImage(
        // data: ticketList.toList().toString(),
        data: data,
        size: 200,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        // embeddedImage: AssetImage(Assets.img.icon32x32.path),
        // embeddedImageStyle: QrEmbeddedImageStyle(
        //   size: const Size(50, 50),
        // ),
      ),
    );
  }
}
