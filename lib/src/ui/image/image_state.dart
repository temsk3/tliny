import 'package:image_picker/image_picker.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_state.g.dart';

@riverpod
FutureOr<XFile?> tempImage(Ref ref) {
  final image = ImagePicker().pickImage(source: ImageSource.gallery);
  return image;
}
