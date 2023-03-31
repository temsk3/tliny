import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_router.dart';
import '../../ui/common/main_body.dart';
import '../../ui/product/widget/product_button.dart';
import '../../utils/date_formatter.dart';
import '../image/image_screen.dart';
import 'product_view_model.dart';

final logger = Logger();

@RoutePage()
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
    final appRoute = useRouter();
    // final appMediaQuery = useMediaQuery();
    // final state = ref.watch(productStateProvider(product.id.toString()));
    // final state = ref.watch(productViewModelProvider);
    final viewModel = ref.watch(productViewModelProvider.notifier);
    // final asyncValue = ref.watch(productListStreamProvider);
    //
    // final NumberFormat numFormatter = NumberFormat.simpleCurrency(
    //     locale: Localizations.localeOf(context).toString());
    // final DateFormat dateFormatter =
    //     DateFormat.yMMMEd(Localizations.localeOf(context).toString());

    final form = GlobalKey<FormState>();
    final now = DateTime.now();
    final dateFormatter = DateFormat('yyyy-MM-dd');

    logger.d(product);

    final codeEditingController = useTextEditingController(text: product.code);
    final nameEditingController = useTextEditingController(text: product.name);
    final genre = useState(product.genre);
    final descEditingController = useTextEditingController(text: product.desc);
    final stockEditingController =
        useTextEditingController(text: product.stock.toString());
    final priceEditingController =
        useTextEditingController(text: product.price.toString());
    final expirationFromEditingController = useTextEditingController(
      text: dateFormatter.format(
        product.expirationFrom ?? now,
      ),
    );
    final expirationToEditingController = useTextEditingController(
      text: dateFormatter.format(
        product.expirationTo ?? now,
      ),
    );
    final salesStartEditingController = useTextEditingController(
      text: dateFormatter.format(
        program.salesStart ?? now,
      ),
    );
    final salesEndEditingController = useTextEditingController(
      text: dateFormatter.format(
        program.salesEnd ?? now,
      ),
    );
    final picture = useState(product.pictureURL);
    final isActive = useState(true);
    final isPublish = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.product + l10n.register),
      ),
      body: MainBodyWidget(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
                    InkWell(
                      // onTap: (edit.value)
                      //     ? () async {
                      //         form.currentState!.save();
                      //         final XFile? image = await picker.pickImage(
                      //             source: ImageSource.gallery);
                      //         uint8List.value = await image!.readAsBytes();
                      //       }
                      //     : (oldPicture != null || oldPicture != '')
                      //         ? () {
                      //             showGeneralDialog(
                      //               transitionDuration:
                      //                   const Duration(milliseconds: 1000),
                      //               barrierDismissible: true,
                      //               barrierLabel: '',
                      //               context: context,
                      //               pageBuilder:
                      //                   (context, animation1, animation2) {
                      //                 return DefaultTextStyle(
                      //                   style: Theme.of(context)
                      //                       .primaryTextTheme
                      //                       .bodyLarge!,
                      //                   child: Center(
                      //                     child: SizedBox(
                      //                       height: 500,
                      //                       width: 500,
                      //                       child: SingleChildScrollView(
                      //                         child: Stack(
                      //                           children: [
                      //                             InteractiveViewer(
                      //                               minScale: 0.1,
                      //                               maxScale: 5,
                      //                               child: Container(
                      //                                 child:
                      //                                     CachedNetworkImage(
                      //                                   imageUrl:
                      //                                       oldPicture.text,
                      //                                   placeholder: (context,
                      //                                           url) =>
                      //                                       const CircularProgressIndicator(),
                      //                                   errorWidget: (context,
                      //                                           url, error) =>
                      //                                       const Icon(
                      //                                           Icons.error),
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                             SafeArea(
                      //                               child: IconButton(
                      //                                 onPressed: () {
                      //                                   Navigator.of(context)
                      //                                       .pop();
                      //                                 },
                      //                                 icon: const Icon(
                      //                                     Icons.close),
                      //                               ),
                      //                             )
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 );
                      //               },
                      //             );
                      //           }
                      //         : null,
                      // child: PictureDetail(
                      //   picture: uint8List.value,
                      //   oldPicture: oldPicture.text,
                      // ),
                      child: PictureEditView(picture: picture.value),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            enabled: product.code != null,
                            controller: codeEditingController,
                            decoration:
                                const InputDecoration(labelText: 'code'),
                            onSaved: (value) {
                              codeEditingController.text = value.toString();
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        GenreDropdownButton(
                          product: product,
                          value: genre.value,
                          onChanged: (value) => {genre.value = value},
                          onSaved: (value) => {genre.value = value},
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    TextFormField(
                      // enabled: edit.value,
                      controller: nameEditingController,
                      decoration: const InputDecoration(labelText: 'name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        nameEditingController.text = value.toString();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    TextFormField(
                      controller: descEditingController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'desc',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        descEditingController.text = value.toString();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: stockEditingController,
                            decoration:
                                const InputDecoration(labelText: 'stock'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              stockEditingController.text = value.toString();
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: priceEditingController,
                            decoration:
                                const InputDecoration(labelText: 'price'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              priceEditingController.text = value.toString();
                            },
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    //
                    Row(
                      children: [
                        ElevatedButton(
                          child: const Text(
                            '有効期間',
                          ),
                          onPressed: () async {
                            final dateRange = await showDateRangePicker(
                              context: context,
                              initialDateRange: DateTimeRange(
                                start: now,
                                end: now,
                              ),
                              firstDate: now,
                              lastDate: DateTime(now.year + 3),
                              // builder:(context, child) {
                              //         return Theme(
                              //           data: theme.data.copyWith(
                              //             colorScheme: theme
                              //                 .data.colorScheme
                              //                 .copyWith(
                              //               surface:
                              //                   theme.appColors.primary,
                              //             ),
                              //           ),
                              //           child: child as Widget,
                              //         );
                              // },
                            );
                            if (dateRange != null) {
                              expirationFromEditingController.text =
                                  dateFormatter.format(dateRange.start);
                              expirationToEditingController.text =
                                  dateFormatter.format(dateRange.end);
                            }
                          },
                        ),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (startDayFormatter(value).isAfter(
                                endDayFormatter(
                                  expirationToEditingController.text,
                                ),
                              )) {
                                return 'Please enter a date after the specified date';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              expirationFromEditingController.text =
                                  value.toString();
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              expirationToEditingController.text =
                                  value.toString();
                            },
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CancelElevatedButton(),
                        const SizedBox(
                          width: 16,
                        ),
                        RegisterProductElevatedButton(
                          onPressed: () {
                            form.currentState!.save();

                            final data = product.copyWith(
                              code: codeEditingController.text,
                              name: nameEditingController.text,
                              genre: genre.value,
                              desc: descEditingController.text,
                              stock: int.parse(stockEditingController.text),
                              price: int.parse(priceEditingController.text),
                              expirationFrom: startDayFormatter(
                                expirationFromEditingController.text,
                              ),
                              expirationTo: endDayFormatter(
                                expirationToEditingController.text,
                              ),
                              isActive: isActive.value,
                              isPublish: isPublish.value,
                              // expirationLink: ,
                              salesStart: startDayFormatter(
                                salesStartEditingController.text,
                              ),
                              salesEnd: endDayFormatter(
                                salesEndEditingController.text,
                              ),
                            );

                            logger.d(data);

                            viewModel.registerProduct(program, data);

                            appRoute.pop();
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
