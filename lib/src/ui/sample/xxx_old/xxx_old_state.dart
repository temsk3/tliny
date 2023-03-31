import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/model/xxx/xxx_model.dart';

part 'xxx_old_state.freezed.dart';

@freezed
class XxxState with _$XxxState {
  const factory XxxState({
    @Default(<Xxx>[]) List<Xxx> xxxList,
  }) = _XxxState;
}
