import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/model/user_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/image_repository.dart';
import '../../data/repository/stripe_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../utils/logger.dart';

part 'user_view_model.g.dart';

// final logger = Logger();

@riverpod
class UserViewModel extends _$UserViewModel {
  late final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  late final UserRepository userRepository = ref.watch(userRepositoryProvider);
  late final ImageRepository imageRepository = ref.watch(
    imageRepositoryProvider,
  );
  late final StripeRepository stripeRepository = ref.watch(
    stripeRepositoryProvider,
  );

  @override
  FutureOr<User> build() {
    return getUser();
  }

  // 取得
  Future<User> getUser() async {
    logger.d('getUser');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      logger.d('Error: $uid', time: DateTime.now());
      throw Error();
      // return User.empty();
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return userRepository.readUser(uid);
    });
    return userRepository.readUser(uid);
    // return state.value!;
  }

  // 追加
  Future<void> addUser(User data) async {
    logger.d('addUser');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final id = await userRepository.createUser(data);
      return data.copyWith(id: id);
    });
  }

  // 更新
  Future<void> updateUser(User data) async {
    logger.d('updateUser');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final id = await userRepository.updateUser(data);
      updateProfile(data);
      return data.copyWith(id: id);
    });
  }

  // 削除
  Future<void> deleteUser(User data) async {
    logger.d('deleteUser');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await userRepository.deleteUser(data.id.toString());
      return User.empty();
    });
  }

  //
  void updateProfile(User user) {
    authRepository
      ..updateDisplayName(user.displayName)
      // ..updateEmail(user.email)
      ..updatePhotoUrl(user.photoUrl);
    // ..updatePhoneNumber(user.phoneNumber);
  }

  //
  Future<String> updatePhoto(String uid, XFile photo) async {
    logger.d('photo');
    final url = await imageRepository.uploadImage(
      image: await photo.readAsBytes(),
      path: 'users/$uid',
      name: photo.name,
    );
    return url;
  }

  Future<String> deletePhoto(String uid, XFile photo) async {
    logger.d('photo');
    final url = await imageRepository.deleteImage(path: uid, name: photo.name);
    return url;
  }

  // Stripe Connect Account
  // Generate ConnectAccountLink
  Future<void> getAccountLink(String email) async {
    try {
      logger.i('getAccountLink');
      final url = await stripeRepository.getAccountLink(email);
      logger.i(url);
      //
      await sendUrl(url);
    } on Exception catch (e, st) {
      logger.e(
        'createAccountLinkError',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  Future<void> createLoginLink() async {
    try {
      logger.i('getLoginLink');
      // final url = await stripeRepository.createLoginLink();
      // logger.i(url);
      const url = 'https://dashboard.stripe.com/';
      await sendUrl(url);
    } on Exception catch (e, st) {
      logger.e(
        'createLoginLinkError',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  Future<void> sendUrl(String url) async {
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url), webOnlyWindowName: '_self');
    // } else {
    //   logger.e('Could not launch URL');
    //   final Error error = ArgumentError('Error launching $url');
    //   throw error;
    // }
    if (!await launchUrl(Uri.parse(url), webOnlyWindowName: '_self')) {
      logger.e('Could not launch URL');
      final Error error = ArgumentError('Error launching $url');
      throw error;
    }
  }
}
