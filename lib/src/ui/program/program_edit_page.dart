import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../data/model/program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/theme/app_theme.dart';
import '../../ui/common/main_body.dart';
import '../../utils/date_formatter.dart';
import '../image/image_screen.dart';
import 'program_view_model.dart';
import 'widget/program_button.dart';

final logger = Logger();

@RoutePage()
class ProgramEditPage extends HookConsumerWidget {
  const ProgramEditPage({super.key, required this.program});
  final Program program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();

    final viewModel = ref.watch(programViewModelProvider.notifier);

    final form = GlobalKey<FormState>();
    final now = DateTime.now();
    final dateFormat = DateFormat('yyyy-MM-dd');

    // logger.d(program);

    final id = program.id;
    final organizerId = program.organizerId;
    final nameEditingController = useTextEditingController(text: program.name);
    final messageEditingController =
        useTextEditingController(text: program.message);
    final salesStartEditingController = useTextEditingController(
      text: dateFormat.format(
        program.salesStart ?? now,
      ),
    );
    final salesEndEditingController = useTextEditingController(
      text: dateFormat.format(
        program.salesEnd ?? now,
      ),
    );
    final eventFromEditingController = useTextEditingController(
      text: dateFormat.format(
        program.eventFrom ?? now,
      ),
    );
    final eventToEditingController = useTextEditingController(
      text: dateFormat.format(
        program.eventTo ?? now,
      ),
    );
    final placeEditingController =
        useTextEditingController(text: program.place);
    final picture = useState(program.pictureURL);
    final isActive = useState(true);
    final isPublish = useState(false);
    final staffCodeEditingController =
        useTextEditingController(text: program.staffCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.event + l10n.register),
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    //
                    PictureEditView(picture: picture.value),
                    //
                    const SizedBox(height: 40),
                    TextFormField(
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
                      onChanged: (value) {
                        // _name.text = value.toString();
                      },
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
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
                      onChanged: (value) {
                        // _name.text = value.toString();
                      },
                    ),
                    const SizedBox(height: 40),
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
                              salesStartEditingController.text =
                                  dateFormat.format(dateRange.start);
                              salesEndEditingController.text =
                                  dateFormat.format(dateRange.end);
                            }
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                        ),
                        Flexible(
                          child: TextFormField(
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
                              salesEndEditingController.text = value.toString();
                            },
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
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
                              firstDate: DateTime(now.year, now.month, now.day),
                              lastDate: DateTime(now.year + 3),
                              // builder: (context, child) {
                              //   ThemeData data;
                              //   data = theme.data.copyWith(
                              //     colorScheme: ColorScheme.light(
                              //       primary: theme.appColors
                              //           .primary, // header background color
                              //       onPrimary: theme.appColors
                              //           .onPrimary, // header text color
                              //       onSurface: theme
                              //           .appColors.onSurface, // body text color
                              //     ),
                              //     textButtonTheme: TextButtonThemeData(
                              //       style: TextButton.styleFrom(
                              //         foregroundColor: theme.appColors
                              //             .primary, // button text color
                              //       ),
                              //     ),
                              //   );
                              //   return Theme(data: data, child: child!);
                              // },
                            );
                            if (dateRange != null) {
                              eventFromEditingController.text =
                                  dateFormat.format(dateRange.start).toString();
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
                                // return l10n
                                //     .pleaseEnterADateAfterTheSpecifiedDate;
                                return 'Please enter a date after the specified date';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              eventToEditingController.text = value.toString();
                            },
                          ),
                        ),
                      ],
                    ),
                    //
                    TextFormField(
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
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: staffCodeEditingController,
                      maxLength: 10,
                      decoration: InputDecoration(labelText: l10n.staffCode),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.pleaseEnterSomeText;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        staffCodeEditingController.text = value.toString();
                      },
                      onChanged: (value) {
                        // _name.text = value.toString();
                      },
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CancelElevatedButton(),
                        const SizedBox(width: 16),
                        RegisterProgramElevatedButton(
                          onPressed: () {
                            form.currentState!.save();

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
                            );

                            logger.d(data);

                            ref
                                .watch(programViewModelProvider.notifier)
                                .registerProgram(data);

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
