import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/model/program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../ui/common/main_body.dart';
import '../../utils/date_formatter.dart';
import '../common/loading_screen.dart';
import '../image/image_screen.dart';
import '../image/image_view_model.dart';
import 'program_view_model.dart';
import 'widget/program_button.dart';

// final logger = Logger();

// @RoutePage()
class ProgramEditPage extends HookConsumerWidget {
  const ProgramEditPage({super.key, required this.program});
  final Program program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final context = useContext();
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    // final appMediaQuery = useMediaQuery();

    // final viewModel = ref.watch(programViewModelProvider.notifier);
    final imageViewModel = ref.watch(tempImageListViewModelProvider.notifier);

    final form = GlobalKey<FormState>();
    final focusNode = FocusNode();
    final isPublishFocusNode = FocusNode();
    final nameFocusNode = FocusNode();
    final messageFocusNode = FocusNode();
    final placeFocusNode = FocusNode();
    final now = DateTime.now();
    final dateFormat = DateFormat('yyyy-MM-dd');

    // logger.d(program);

    final id = program.id;
    final organizerId = program.organizerId;
    final nameEditingController = useTextEditingController(text: program.name);
    final messageEditingController = useTextEditingController(
      text: program.message,
    );
    final salesStartEditingController = useTextEditingController(
      text: dateFormat.format(program.salesStart ?? now),
    );
    final salesEndEditingController = useTextEditingController(
      text: dateFormat.format(program.salesEnd ?? now),
    );
    final eventFromEditingController = useTextEditingController(
      text: dateFormat.format(program.eventFrom ?? now),
    );
    final eventToEditingController = useTextEditingController(
      text: dateFormat.format(program.eventTo ?? now),
    );
    final placeEditingController = useTextEditingController(
      text: program.place,
    );
    // final picture = useState(program.pictureURL);
    final isActive = useState(program.isActive ?? false);
    final isPublish = useState(program.isPublish ?? false);
    final staffCodeEditingController = useTextEditingController(
      text: program.staffCode,
    );

    Uint8List? file;
    final imageState = useState(file);
    return WidgetWithLoading(
      // child: Focus(
      //   focusNode: focusNode,
      //   child: GestureDetector(
      //     onTap: focusNode.requestFocus,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(l10n.event + l10n.register),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('イベント表示（非表示／表示）'),
                          Switch(
                            value: isPublish.value,
                            onChanged: (bool? value) {
                              logger.d(value);
                              if (value != null) {
                                isPublish.value = value;
                              }
                            },
                            focusNode: isPublishFocusNode,
                          ),
                        ],
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      //
                      InkWell(
                        child: EditPictureView(
                          imageViewModel: imageViewModel,
                          picture: program.pictureURL,
                          index: 0,
                          imageState: imageState,
                        ),
                      ),

                      //
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      TextFormField(
                        // autofocus: true,
                        textInputAction: TextInputAction.next,
                        controller: nameEditingController,
                        decoration: InputDecoration(labelText: l10n.eventName),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseEnterSomeText;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          nameEditingController.text = value.toString();
                        },
                        focusNode: nameFocusNode,
                        onFieldSubmitted:
                            (value) => FocusScope.of(
                              context,
                            ).requestFocus(messageFocusNode),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: messageEditingController,
                        maxLength: 60,
                        maxLines: 2,
                        decoration: InputDecoration(labelText: l10n.detail),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseEnterSomeText;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          messageEditingController.text = value.toString();
                        },
                        focusNode: messageFocusNode,
                        onFieldSubmitted:
                            (value) => FocusScope.of(
                              context,
                            ).requestFocus(placeFocusNode),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      //
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            child: Text(l10n.salesPeriod),
                            onPressed: () async {
                              final dateRange = await showDateRangePicker(
                                context: context,
                                initialDateRange: DateTimeRange(
                                  start: now,
                                  end: now,
                                ),
                                firstDate: now,
                                lastDate: DateTime(DateTime.now().year + 3),
                                // builder: (context, child) {
                                //   return Theme(
                                //     data: theme.data..copyWith(
                                //       colorScheme:
                                //           theme.data.colorScheme.copyWith(
                                //         surface: theme.appColors.primary,
                                //       ),
                                //     ),
                                //     child: child as Widget,
                                //   );
                                // },
                              );
                              if (dateRange != null) {
                                salesStartEditingController.text = dateFormat
                                    .format(dateRange.start);
                                salesEndEditingController.text = dateFormat
                                    .format(dateRange.end);
                              }
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                          ),
                          Flexible(
                            child: TextFormField(
                              enabled: false,
                              controller: salesStartEditingController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'From',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return l10n.pleaseEnterSomeText;
                                }
                                if (startDayFormatter(value).isAfter(
                                  startDayFormatter(
                                    eventFromEditingController.text,
                                  ),
                                )) {
                                  return l10n
                                      .pleaseEnterADateAfterTheSpecifiedDate;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                salesStartEditingController.text =
                                    value.toString();
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                          ),
                          Flexible(
                            child: TextFormField(
                              enabled: false,
                              controller: salesEndEditingController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'To',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return l10n.pleaseEnterSomeText;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                salesEndEditingController.text =
                                    value.toString();
                              },
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            child: Text(l10n.periods),
                            onPressed: () async {
                              final dateRange = await showDateRangePicker(
                                context: context,
                                initialDateRange: DateTimeRange(
                                  start: DateTime.parse(
                                    salesStartEditingController.text,
                                  ),
                                  end: DateTime.parse(
                                    salesEndEditingController.text,
                                  ),
                                ),
                                firstDate: DateTime(
                                  now.year,
                                  now.month,
                                  now.day,
                                ),
                                lastDate: DateTime(now.year + 3),
                              );
                              if (dateRange != null) {
                                eventFromEditingController.text =
                                    dateFormat
                                        .format(dateRange.start)
                                        .toString();
                                eventToEditingController.text =
                                    dateFormat.format(dateRange.end).toString();
                              }
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                          ),
                          Flexible(
                            child: TextFormField(
                              enabled: false,
                              controller: eventFromEditingController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'From',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return l10n.pleaseEnterSomeText;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                eventFromEditingController.text =
                                    value.toString();
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                          ),
                          Flexible(
                            child: TextFormField(
                              enabled: false,
                              controller: eventToEditingController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'To',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return l10n.pleaseEnterSomeText;
                                }
                                if (endDayFormatter(
                                  salesEndEditingController.text,
                                ).isAfter(endDayFormatter(value))) {
                                  return l10n
                                      .pleaseEnterADateAfterTheSpecifiedDate;
                                  // return 'Please enter a date after the specified date';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                eventToEditingController.text =
                                    value.toString();
                              },
                            ),
                          ),
                        ],
                      ),
                      //
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: placeEditingController,
                        decoration: InputDecoration(labelText: l10n.place),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseEnterSomeText;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          placeEditingController.text = value.toString();
                        },
                        onChanged: (value) {
                          // _name.text = value.toString();
                        },
                        focusNode: placeFocusNode,
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@_-]'),
                          ),
                        ],
                        textInputAction: TextInputAction.done,
                        controller: staffCodeEditingController,
                        maxLength: 10,
                        decoration: InputDecoration(labelText: l10n.staffCode),
                        validator: (value) {
                          // if (value == null || value.isEmpty) {
                          //   return l10n.pleaseEnterSomeText;
                          // }
                          return null;
                        },
                        onSaved: (value) {
                          staffCodeEditingController.text = value.toString();
                        },
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CancelElevatedButton(),
                          const SizedBox(width: 16),
                          RegisterProgramElevatedButton(
                            onPressed: () async {
                              if (form.currentState!.validate()) {
                                form.currentState!.save();

                                final storageId =
                                    await imageViewModel.createUuid;
                                final photo = await imageViewModel.getTempImage(
                                  'program/$storageId',
                                  program.pictureURL,
                                );

                                final data = program.copyWith(
                                  id: id,
                                  organizerId: organizerId,
                                  name: nameEditingController.text,
                                  message: messageEditingController.text,
                                  salesStart: startDayFormatter(
                                    salesStartEditingController.text,
                                  ),
                                  salesEnd: endDayFormatter(
                                    salesEndEditingController.text,
                                  ),
                                  eventFrom: startDayFormatter(
                                    eventFromEditingController.text,
                                  ),
                                  eventTo: endDayFormatter(
                                    eventToEditingController.text,
                                  ),
                                  place: placeEditingController.text,
                                  isActive: isActive.value,
                                  isPublish: isPublish.value,
                                  storageId: storageId,
                                  pictureURL: photo,
                                  staffCode: staffCodeEditingController.text,
                                );

                                logger.d(data);
                                final result = await ref
                                    .read(isLoadingProvider.notifier)
                                    .guardFuture<bool>(
                                      () async => ref
                                          .watch(
                                            programViewModelProvider.notifier,
                                          )
                                          .registerProgram(data),
                                    );
                                // await ref
                                //     .watch(programViewModelProvider.notifier)
                                //     .registerProgram(data);
                                if (context.mounted && result) {
                                  context.pop();
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
      ),
      //   ),
      // ),
    );
  }
}
