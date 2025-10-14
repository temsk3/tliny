import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/model/program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../ui/common/error_handler.dart';
import '../../utils/date_formatter.dart';
import '../../utils/logger.dart';
import '../../utils/router_utils.dart';
import '../common/loading_screen.dart';
import '../common/main_body.dart';
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
    // // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    // // final appMediaQuery = useMediaQuery();

    // // final viewModel = ref.watch(programViewModelProvider.notifier);
    final imageViewModel = ref.watch(tempImageListViewModelProvider.notifier);
    final errorHandler = useErrorHandler();

    final form = GlobalKey<FormState>();
    // final focusNode = FocusNode();
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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(l10n.event + l10n.register),
      ),
      body: MainBodyWidget(
        width: 400,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // イベント表示設定
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'イベント表示（非表示／表示）',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
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
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 画像アップロード
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: InkWell(
                        child: EditPictureView(
                          imageViewModel: imageViewModel,
                          picture: program.pictureURL,
                          index: 0,
                          imageState: imageState,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // イベント名
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: nameEditingController,
                        decoration: InputDecoration(
                          labelText: l10n.eventName,
                          border: const OutlineInputBorder(),
                        ),
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
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 詳細説明
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: messageEditingController,
                        maxLength: 60,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: l10n.detail,
                          border: const OutlineInputBorder(),
                          helperText: '最大60文字',
                        ),
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
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 販売期間
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '販売期間',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller: salesStartEditingController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: '開始日',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return l10n.pleaseEnterSomeText;
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    salesStartEditingController.text =
                                        value.toString();
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller: salesEndEditingController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: '終了日',
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
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                try {
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
                                    salesStartEditingController.text =
                                        dateFormat.format(dateRange.start);
                                    salesEndEditingController.text = dateFormat
                                        .format(dateRange.end);
                                  }
                                } catch (e) {
                                  errorHandler.showError(
                                    e,
                                    errorContext: '販売期間選択',
                                  );
                                }
                              },
                              icon: const Icon(Icons.calendar_today),
                              label: const Text('期間を選択'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // イベント期間
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'イベント期間',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller: eventFromEditingController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: '開始日',
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
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller: eventToEditingController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: '終了日',
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
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                try {
                                  final dateRange = await showDateRangePicker(
                                    context: context,
                                    initialDateRange: DateTimeRange(
                                      start: DateTime.parse(
                                        eventFromEditingController.text,
                                      ),
                                      end: DateTime.parse(
                                        eventToEditingController.text,
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
                                    eventFromEditingController.text = dateFormat
                                        .format(dateRange.start);
                                    eventToEditingController.text = dateFormat
                                        .format(dateRange.end);
                                  }
                                } catch (e) {
                                  errorHandler.showError(
                                    e,
                                    errorContext: 'イベント期間選択',
                                  );
                                }
                              },
                              icon: const Icon(Icons.calendar_today),
                              label: const Text('期間を選択'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 開催場所
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: placeEditingController,
                        decoration: InputDecoration(
                          labelText: l10n.place,
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.pleaseEnterSomeText;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          placeEditingController.text = value.toString();
                        },
                        focusNode: placeFocusNode,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // スタッフコード
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@_-]'),
                          ),
                        ],
                        textInputAction: TextInputAction.done,
                        controller: staffCodeEditingController,
                        maxLength: 10,
                        decoration: InputDecoration(
                          labelText: l10n.staffCode,
                          border: const OutlineInputBorder(),
                          helperText: '英数字、@、_、- のみ使用可能(最大10文字)',
                        ),
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {
                          staffCodeEditingController.text = value.toString();
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ボタン
                  Row(
                    children: [
                      const Expanded(child: CancelElevatedButton()),
                      const SizedBox(width: 16),
                      Expanded(
                        child: RegisterProgramElevatedButton(
                          onPressed: () async {
                            try {
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
                                    .read(
                                      globalLoadingControllerProvider.notifier,
                                    )
                                    .guardFuture<bool>(
                                      () async => ref
                                          .watch(
                                            programViewModelProvider.notifier,
                                          )
                                          .registerProgram(data),
                                    );
                                if (context.mounted && result) {
                                  RouterUtils.safePop(context);
                                }
                              }
                            } catch (e) {
                              errorHandler.showError(
                                e,
                                errorContext: 'プログラム登録',
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
