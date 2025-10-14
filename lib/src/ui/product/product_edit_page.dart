import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/staff_repository.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../ui/common/error_handler.dart';
import '../../ui/common/main_body.dart';
import '../../ui/product/widget/product_button.dart';
import '../../utils/date_formatter.dart';
import '../../utils/logger.dart';
import '../../utils/router_utils.dart';
import '../common/loading_screen.dart';
import '../image/image_screen.dart';
import '../image/image_view_model.dart';
import 'product_view_model.dart';

// @RoutePage()
class ProductEditPage extends HookConsumerWidget {
  const ProductEditPage({
    super.key,
    required this.program,
    required this.product,
  });
  final Program program;
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final errorHandler = useErrorHandler();
    // final appRoute = useRouter();
    // final appMediaQuery = useMediaQuery();
    // final state = ref.watch(productStateProvider(product.id.toString()));
    // final state = ref.watch(productViewModelProvider);
    final viewModel = ref.watch(productViewModelProvider.notifier);
    final imageViewModel = ref.watch(tempImageListViewModelProvider.notifier);

    final form = GlobalKey<FormState>();
    // final focusNode = FocusNode();
    // final codeFocus = FocusNode();
    // final genreFocus = FocusNode();
    // final nameFocus = FocusNode();
    // final descFocus = FocusNode();
    // final priceFocus = FocusNode();
    // final stockFocus = FocusNode();
    final now = DateTime.now();
    final dateFormatter = DateFormat('yyyy-MM-dd');

    // logger.d(product);

    final codeEditingController = useTextEditingController(text: product.code);
    final nameEditingController = useTextEditingController(text: product.name);
    final genre = useState(product.genre);
    final descEditingController = useTextEditingController(text: product.desc);
    final stockEditingController = useTextEditingController(
      text: product.stock.toString(),
    );
    final priceEditingController = useTextEditingController(
      text: product.price.toString(),
    );
    // 使用期間設定のコントローラー（一時的に無効化中）
    final expirationFromEditingController = useTextEditingController(
      text: dateFormatter.format(program.eventFrom ?? now),
    );
    final expirationToEditingController = useTextEditingController(
      text: dateFormatter.format(program.eventTo ?? now),
    );
    final salesStartEditingController = useTextEditingController(
      text: dateFormatter.format(program.salesStart ?? now),
    );
    final salesEndEditingController = useTextEditingController(
      text: dateFormatter.format(program.salesEnd ?? now),
    );
    // final picture = useState(product.pictureURL);
    final isActive = useState(true);
    final isPublish = useState(false);

    Uint8List? file;
    final imageState = useState(file);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(l10n.product + l10n.register),
      ),
      body: MainBodyWidget(
        width: 400,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                    InkWell(
                      child: EditPictureView(
                        imageViewModel: imageViewModel,
                        picture: product.pictureURL,
                        index: 0,
                        imageState: imageState,
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z0-9_-]'),
                              ),
                            ],
                            enabled: product.code == null || product.code == '',
                            controller: codeEditingController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: l10n.code),
                            onSaved: (value) {
                              codeEditingController.text = value.toString();
                            },
                            textAlign: TextAlign.center,
                            // focusNode: codeFocus,
                            // onFieldSubmitted: (value) =>
                            //     FocusScope.of(context)
                            //         .requestFocus(nameFocus),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        GenreDropdownButton(
                          product: product,
                          value: genre.value,
                          onChanged: (value) {
                            genre.value = value;
                            //   FocusScope.of(context).requestFocus(nameFocus);
                          },
                          onSaved: (value) => {genre.value = value},
                          // focusNode: genreFocus,
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: nameEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: l10n.productName),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.pleaseEnterSomeText;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        nameEditingController.text = value.toString();
                      },
                      // focusNode: nameFocus,
                      // onFieldSubmitted: (value) =>
                      //     FocusScope.of(context).requestFocus(descFocus),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: descEditingController,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: l10n.productDescription,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.pleaseEnterSomeText;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        descEditingController.text = value.toString();
                      },
                      // focusNode: descFocus,
                      // onFieldSubmitted: (value) =>
                      //     FocusScope.of(context).requestFocus(stockFocus),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: stockEditingController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: l10n.stock),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.pleaseEnterSomeNum;
                              }
                              if (int.parse(value) < 0) {
                                return '正数を入力してください';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              stockEditingController.text = value.toString();
                            },
                            textAlign: TextAlign.right,
                            // focusNode: stockFocus,
                            // onFieldSubmitted: (value) =>
                            //     FocusScope.of(context)
                            //         .requestFocus(priceFocus),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        Flexible(
                          child: Consumer(
                            builder: (context, ref, _) {
                              final uid = ref.watch(userIdProvider).value;
                              final staffAsyncValue =
                                  uid != null
                                      ? ref.watch(
                                        staffCheckExistenceProvider(
                                          program.id!,
                                        ),
                                      )
                                      : null;
                              final isStaff = staffAsyncValue?.value ?? false;
                              final isOrganizer = uid == program.organizerId;
                              final isAllowed = isStaff || isOrganizer;
                              if (staffAsyncValue == null ||
                                  staffAsyncValue.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (!isAllowed) {
                                return TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: l10n.price,
                                    helperText: 'スタッフまたは開催者のみ商品登録が可能です',
                                  ),
                                );
                              }
                              return TextFormField(
                                textInputAction: TextInputAction.done,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                controller: priceEditingController,
                                keyboardType: TextInputType.number,
                                enabled: true,
                                decoration: InputDecoration(
                                  labelText: l10n.price,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return l10n.pleaseEnterSomeNum;
                                  }
                                  final price = int.parse(value);
                                  if (!(price == 0 || price >= 50)) {
                                    // スナックバーでエラー表示するため、ここではnullを返す
                                    return null;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  priceEditingController.text =
                                      value.toString();
                                },
                                textAlign: TextAlign.right,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    // 使用期間設定（設定機能は無効化、表示のみ）
                    Row(
                      children: [
                        Text(l10n.validPeriod),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        Flexible(
                          child: TextFormField(
                            enabled: false,
                            controller: expirationFromEditingController,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'From',
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                        ),
                        Flexible(
                          child: TextFormField(
                            enabled: false,
                            controller: expirationToEditingController,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'To',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 12)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CancelElevatedButton(),
                        const SizedBox(width: 16),
                        RegisterProductElevatedButton(
                          onPressed: () async {
                            if (form.currentState!.validate()) {
                              final price =
                                  int.tryParse(priceEditingController.text) ??
                                  0;
                              if (!(price == 0 || price >= 50)) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('0円または50円以上で設定してください'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                                return;
                              }
                              form.currentState!.save();

                              final storageId = await imageViewModel.createUuid;
                              final photo = await imageViewModel.getTempImage(
                                'program/${program.storageId}/product/$storageId',
                                product.pictureURL,
                              );

                              final data = product.copyWith(
                                code: codeEditingController.text,
                                name: nameEditingController.text,
                                genre: genre.value,
                                desc: descEditingController.text,
                                stock: int.parse(stockEditingController.text),
                                price: int.parse(priceEditingController.text),
                                // 使用期間はプログラムの期間に固定
                                expirationFrom: program.eventFrom,
                                expirationTo: program.eventTo,
                                isActive: isActive.value,
                                isPublish: isPublish.value,
                                // expirationLink: ,
                                salesStart: startDayFormatter(
                                  salesStartEditingController.text,
                                ),
                                salesEnd: endDayFormatter(
                                  salesEndEditingController.text,
                                ),
                                pictureURL: photo,
                              );

                              logger.d(data);

                              final result = await ref
                                  .read(
                                    globalLoadingControllerProvider.notifier,
                                  )
                                  .guardFuture<bool>(
                                    () async => viewModel.registerProduct(
                                      program,
                                      data,
                                    ),
                                  );
                              if (context.mounted && result) {
                                errorHandler.showInfoSnackBar(
                                  l10n.processingData,
                                );
                                // await appRoute.pop();
                                // appRoute.popUntilRouteWithName(
                                //   'ProgramDetailsRoute',
                                // );
                                RouterUtils.safePop(context);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
