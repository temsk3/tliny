// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'qrcode_scanner_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// QRコードスキャナーのViewModel

@ProviderFor(QRCodeScannerViewModel)
const qRCodeScannerViewModelProvider = QRCodeScannerViewModelProvider._();

/// QRコードスキャナーのViewModel
final class QRCodeScannerViewModelProvider
    extends $NotifierProvider<QRCodeScannerViewModel, String?> {
  /// QRコードスキャナーのViewModel
  const QRCodeScannerViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'qRCodeScannerViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$qRCodeScannerViewModelHash();

  @$internal
  @override
  QRCodeScannerViewModel create() => QRCodeScannerViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$qRCodeScannerViewModelHash() =>
    r'56f68838a6181ee34fdd52065b0b4911726c2f05';

/// QRコードスキャナーのViewModel

abstract class _$QRCodeScannerViewModel extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
