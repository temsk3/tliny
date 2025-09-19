import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/model/ticket_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_snackbar.dart';
import '../../ui/common/error_handler.dart';
import '../../ui/common/main_body.dart';
import '../../utils/logger.dart';
import '../../utils/security.dart';
import 'qrcode_scanner_view_model.dart';

class QRCodeScannerPage extends HookConsumerWidget {
  const QRCodeScannerPage({super.key, required this.currentEventID});
  final String currentEventID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final snackBar = useSnackBar();
    final errorHandler = useErrorHandler();
    // モバイルスキャナーコントローラー
    final mobileScannerController = useMemoized(MobileScannerController.new);
    final viewModel = ref.read(qRCodeScannerViewModelProvider.notifier);
    // スキャン済みチケットのリスト
    final scannedTickets = useState<Set<Ticket>>({});
    // スキャン成功状態
    final showSuccess = useState(false);
    // 処理中フラグ
    final isScanning = useState(false);
    // ダイアログ表示中フラグ
    final isDialogShowing = useState(false);
    // 最後にスキャンしたコード（重複スキャン防止用）
    final lastScannedCode = useState<String>('');

    // スキャン開始と同時にアニメーションを開始
    final animationController = useAnimationController(
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // スキャン線を往復させる

    Future<Map<String, String>?> decodeQrCode(
      String code,
      SnackBarController snackBar,
    ) async {
      try {
        final decryptedData = Security().decrypt(code);
        final parts = decryptedData.split('|');

        if (parts.length < 3) {
          snackBar.showAlertSnackBar(l10n.invalidQrCodeFormat);
          return null; // フォーマットエラーの場合はnullを返す
        }

        return {'prefix': parts[0], 'eventId': parts[1], 'uuid': parts[2]};
      } on Exception catch (e) {
        snackBar.showAlertSnackBar(l10n.failedToDecryptQrCode(e.toString()));
        return null; // 復号エラーの場合はnullを返す
      }
    }

    // QRコードスキャン処理
    Future<void> handleScan(String code) async {
      // 空のコード、ダイアログ表示中、処理中、同じコードの重複スキャンの場合は早期リターン
      if (code.isEmpty ||
          isDialogShowing.value ||
          isScanning.value ||
          lastScannedCode.value == code) {
        return;
      }

      try {
        isScanning.value = true;
        lastScannedCode.value = code;

        final qrData = await decodeQrCode(code, snackBar);
        if (qrData == null) {
          return; // 復号またはフォーマットエラーの場合は早期リターン
        }

        final prefix = qrData['prefix']!;
        final eventId = qrData['eventId']!;
        final uuid = qrData['uuid']!;

        if (eventId != currentEventID) {
          snackBar.showAlertSnackBar(l10n.accessDeniedWrongEvent);
          return; // イベントID不一致の場合は早期リターン
        }

        final newTickets = await viewModel.findTicketsByUuid(prefix, uuid);
        if (newTickets.isNotEmpty) {
          // 重複チェックのみ（isUsedは問わない）
          for (final newTicket in newTickets) {
            if (!scannedTickets.value.any(
              (ticket) => ticket.id == newTicket.id,
            )) {
              scannedTickets.value.add(newTicket);
            }
          }
        }

        showSuccess.value = true;
        animationController.stop();
        await Future.delayed(const Duration(seconds: 1));
        showSuccess.value = false;
        animationController.repeat(reverse: true);

        snackBar.showSuccessSnackBar(l10n.ticketScannedSuccessfully);
      } on Exception catch (e) {
        logger.e('Failed to handle QR code scan: $e');
        snackBar.showAlertSnackBar(l10n.failedToProcessQrCode(e.toString()));
      } finally {
        isScanning.value = false;
        // 少し遅延を入れてからlastScannedCodeをクリア（連続スキャン防止のため）
        Timer(const Duration(milliseconds: 500), () {
          lastScannedCode.value = '';
        });
      }
    }

    useEffect(() {
      return null;
    }, [mobileScannerController, animationController]);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.scanQrCodes),
        actions: [
          IconButton(
            onPressed:
                isDialogShowing.value
                    ? null
                    : mobileScannerController.switchCamera,
            icon: ValueListenableBuilder(
              valueListenable: mobileScannerController,
              builder: (context, state, child) {
                return Icon(
                  state.cameraDirection == CameraFacing.front
                      ? Icons.camera_front
                      : Icons.camera_rear,
                );
              },
            ),
          ),
        ],
      ),
      body: MainBodyWidget(
        width: 500,
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      MobileScanner(
                        controller: mobileScannerController,
                        scanWindowUpdateThreshold: 10,
                        onDetect:
                            isDialogShowing.value
                                ? null
                                : (capture) => handleScan(
                                  capture.barcodes.firstOrNull?.rawValue ?? '',
                                ), // ダイアログ表示中は無効化
                      ),
                      ScannerOverlay(
                        animationController: animationController,
                        showSuccess: showSuccess.value,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.scannedTicketsCount(scannedTickets.value.length),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (scannedTickets.value.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              l10n.usedTickets(
                                scannedTickets.value
                                    .where((t) => t.isUsed)
                                    .length,
                              ),
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child:
                          scannedTickets.value.isEmpty
                              ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.qr_code_scanner_outlined,
                                      size: 64,
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      l10n.noTicketsScannedYet,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.outline,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      l10n.scanQrCodesToSeeTickets,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline
                                            .withValues(alpha: 0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : ListView.builder(
                                itemCount: scannedTickets.value.length,
                                itemBuilder: (context, index) {
                                  final ticket =
                                      scannedTickets.value.toList()[index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color:
                                            ticket.isUsed
                                                ? Colors.green.withValues(
                                                  alpha: 0.3,
                                                )
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .outline
                                                    .withValues(alpha: 0.2),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.05,
                                          ),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          // チケットアイコン
                                          Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primaryContainer,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons
                                                  .confirmation_number_outlined,
                                              color:
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .onPrimaryContainer,
                                              size: 24,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          // チケット情報
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ticket.name ??
                                                      l10n.unknownTicket,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                if (ticket.desc != null &&
                                                    ticket.desc!.isNotEmpty)
                                                  Text(
                                                    ticket.desc!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color: Theme.of(
                                                                context,
                                                              )
                                                              .colorScheme
                                                              .onSurface
                                                              .withValues(
                                                                alpha: 0.7,
                                                              ),
                                                        ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            ticket.isUsed
                                                                ? Colors.green
                                                                    .withValues(
                                                                      alpha:
                                                                          0.1,
                                                                    )
                                                                : Theme.of(
                                                                      context,
                                                                    )
                                                                    .colorScheme
                                                                    .secondaryContainer,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              6,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        ticket.isUsed
                                                            ? l10n.used
                                                            : l10n.unused,
                                                        style: Theme.of(
                                                          context,
                                                        ).textTheme.bodySmall?.copyWith(
                                                          color:
                                                              ticket.isUsed
                                                                  ? Colors.green
                                                                  : Theme.of(
                                                                        context,
                                                                      )
                                                                      .colorScheme
                                                                      .onSecondaryContainer,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    if (ticket.price != null)
                                                      Container(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 4,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiaryContainer,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                6,
                                                              ),
                                                        ),
                                                        child: Text(
                                                          '¥${ticket.price!.toStringAsFixed(0)}',
                                                          style: Theme.of(
                                                            context,
                                                          ).textTheme.bodySmall?.copyWith(
                                                            color:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .colorScheme
                                                                    .onTertiaryContainer,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          scannedTickets.value.any((t) => !t.isUsed)
              ? FloatingActionButton(
                heroTag: 'qr_scanner_fab',
                onPressed: () async {
                  try {
                    debugPrint('FloatingActionButton onPressed'); // 追加
                    isDialogShowing.value = true;
                    await mobileScannerController.stop();

                    // Check if widget is still mounted before using context
                    if (!context.mounted) return;

                    bool? confirmed = false;
                    // 使用済みチケットを除外
                    final tickets =
                        scannedTickets.value.where((t) => !t.isUsed).toList();

                    await showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder:
                          (context) => AlertDialog(
                            title: Text(l10n.scannedTicketsTitle),
                            content: Text(viewModel.ticketCounts(tickets)),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(l10n.ok),
                              ),
                            ],
                          ),
                    );

                    // Check if widget is still mounted before second dialog
                    if (!context.mounted) return;

                    confirmed = await showDialog<bool>(
                      context: context,
                      barrierDismissible: false,
                      builder:
                          (context) => AlertDialog(
                            title: Text(l10n.confirmAction),
                            content: Text(l10n.markTicketsAsUsed),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text(l10n.cancel),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text(l10n.confirm),
                              ),
                            ],
                          ),
                    );

                    if (confirmed == true) {
                      try {
                        debugPrint('Updating database tickets...');
                        await viewModel.updateDatabaseTickets(tickets);
                        debugPrint('Tickets updated successfully.');
                        await Future.delayed(const Duration(milliseconds: 5));

                        // Check if widget is still mounted before updating UI
                        if (!context.mounted) return;

                        viewModel.resetUserId();
                        scannedTickets.value = {};
                        errorHandler.showSuccessSnackBar(
                          l10n.ticketsUpdatedSuccessfully,
                        );
                      } on AppException catch (e, st) {
                        logger.e(
                          'Failed to update tickets AppException: ${e.message}',
                          stackTrace: st,
                        );
                        // Check if widget is still mounted before showing error
                        if (!context.mounted) return;
                        errorHandler.showError(
                          e,
                          errorContext: l10n.ticketUpdateError,
                        );
                      } on Exception catch (e, st) {
                        logger.e(
                          'Failed to update tickets Exception: $e',
                          stackTrace: st,
                        );
                        // Check if widget is still mounted before showing error
                        if (!context.mounted) return;
                        final appException = GeneralException(
                          message: 'チケットの更新に失敗しました。',
                          stackTrace: st,
                        );
                        errorHandler.showError(
                          appException,
                          errorContext: l10n.ticketUpdateError,
                        );
                      }
                    }
                  } catch (e) {
                    // Check if widget is still mounted before showing error
                    if (!context.mounted) return;
                    errorHandler.showError(
                      e,
                      errorContext: l10n.qrScannerOperationError,
                    );
                  } finally {
                    isDialogShowing.value = false;
                    await mobileScannerController.start();
                  }
                },
                child: const Icon(Icons.check),
              )
              : null,
    );
  }
}

class ScannerOverlay extends HookWidget {
  const ScannerOverlay({
    super.key,
    required this.animationController,
    required this.showSuccess,
  });

  final AnimationController animationController;
  final bool showSuccess;

  @override
  Widget build(BuildContext context) {
    final scanLineAnimation = useAnimation(
      Tween<double>(begin: 0, end: 250).animate(animationController),
    );
    return Stack(
      children: [
        Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: showSuccess ? 0 : 1,
            child: ScannerFrame(
              showSuccess: showSuccess,
              scanLinePosition: scanLineAnimation,
            ),
          ),
        ),
        if (showSuccess) // AnimatedOpacityで表示・非表示を切り替える
          const Center(child: SuccessOverlay()),
      ],
    );
  }
}

class ScannerFrame extends StatelessWidget {
  const ScannerFrame({
    super.key,
    required this.showSuccess,
    required this.scanLinePosition,
  });
  final bool showSuccess;
  final double scanLinePosition;

  @override
  Widget build(BuildContext context) {
    final frameColor = showSuccess ? Colors.green : Colors.green[400]!;

    return Stack(
      children: [
        // メインフレーム
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: frameColor.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
        ),

        // コーナーマーカー
        SizedBox(
          width: 250,
          height: 250,
          child: Stack(
            children: [
              // 左上のコーナー
              _buildPositionedCorner(frameColor, top: 0, left: 0, angle: 0),

              // 右上のコーナー
              _buildPositionedCorner(
                frameColor,
                top: 0,
                right: 0,
                angle: 3.14159 / 2,
              ),

              // 左下のコーナー
              _buildPositionedCorner(
                frameColor,
                bottom: 0,
                left: 0,
                angle: -3.14159 / 2,
              ),

              // 右下のコーナー
              _buildPositionedCorner(
                frameColor,
                bottom: 0,
                right: 0,
                angle: 3.14159,
              ),
            ],
          ),
        ),

        // スキャンライン
        if (!showSuccess)
          Positioned(
            top: scanLinePosition,
            left: 12,
            right: 12,
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    frameColor.withValues(alpha: 0),
                    frameColor.withValues(alpha: 0.5),
                    frameColor.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPositionedCorner(
    Color color, {
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double angle,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.rotate(angle: angle, child: _buildCorner(color)),
    );
  }

  Widget _buildCorner(Color color) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: color, width: 4),
          top: BorderSide(color: color, width: 4),
        ),
      ),
    );
  }
}

class SuccessOverlay extends StatelessWidget {
  const SuccessOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1,
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
            ),
            const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 80,
            ),
          ],
        ),
      ),
    );
  }
}
