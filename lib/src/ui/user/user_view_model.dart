import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/model/user_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/image_repository.dart';
import '../../data/repository/stripe_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';
import 'email_change_view_model.dart';
import 'password_change_view_model.dart';

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
    // メールアドレス変更とパスワード変更の状態を監視
    ref.watch(emailChangeViewModelProvider);
    ref.watch(passwordChangeViewModelProvider);
    return _getUserDirectly();
  }

  // 直接ユーザー情報を取得（buildメソッド用）
  Future<User> _getUserDirectly() async {
    logger.d('_getUserDirectly');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      logger.d('Error: $uid', time: DateTime.now());
      throw Error();
    }
    try {
      return await userRepository.readUser(uid);
    } on AppException catch (e, st) {
      logger.e('_getUserDirectly: AppException - ${e.message}', stackTrace: st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('_getUserDirectly: Exception - $e', stackTrace: st);
      rethrow;
    }
  }

  // 取得（ローディング付き）
  Future<User> getUser() async {
    logger.d('getUser');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      logger.d('Error: $uid', time: DateTime.now());
      throw Error();
    }
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final user = await loading.guardFuture(() async {
        return userRepository.readUser(uid);
      });
      state = AsyncValue.data(user);
      return user;
    } on AppException catch (e, st) {
      logger.e('getUser: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('getUser: Exception - $e', stackTrace: st);
      state = AsyncValue.error(
        GeneralException(message: e.toString(), stackTrace: st),
        st,
      );
      rethrow;
    }
  }

  // 追加
  Future<void> addUser(User data) async {
    logger.d('addUser');
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final id = await loading.guardFuture(() async {
        return userRepository.createUser(data);
      });
      final updatedUser = data.copyWith(id: id);
      state = AsyncValue.data(updatedUser);
    } on AppException catch (e, st) {
      logger.e('addUser: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('addUser: Exception - $e', stackTrace: st);
      state = AsyncValue.error(
        GeneralException(message: e.toString(), stackTrace: st),
        st,
      );
      rethrow;
    }
  }

  // 更新
  Future<void> updateUser(User data) async {
    logger.d('updateUser');
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final id = await loading.guardFuture(() async {
        return userRepository.updateUser(data);
      });
      final updatedUser = data.copyWith(id: id);
      await updateProfile(data);

      // PublicUsersも更新
      await ref.read(publicUserRepositoryProvider).updateUser(data);

      state = AsyncValue.data(updatedUser);
    } on AppException catch (e, st) {
      logger.e('updateUser: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('updateUser: Exception - $e', stackTrace: st);
      state = AsyncValue.error(
        GeneralException(message: e.toString(), stackTrace: st),
        st,
      );
      rethrow;
    }
  }

  // 削除
  Future<void> deleteUser(User data) async {
    logger.d('deleteUser');
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      await loading.guardFuture(() async {
        await userRepository.deleteUser(data.id.toString());
      });
      state = AsyncValue.data(User.empty());
    } on AppException catch (e, st) {
      logger.e('deleteUser: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('deleteUser: Exception - $e', stackTrace: st);
      state = AsyncValue.error(
        GeneralException(message: e.toString(), stackTrace: st),
        st,
      );
      rethrow;
    }
  }

  //
  Future<void> updateProfile(User user) async {
    await authRepository.updateDisplayName(user.displayName);
    await authRepository.updatePhotoUrl(user.photoUrl);
    // メールアドレスは専用ページで変更するため、ここでは更新しない
    // await authRepository.updateEmail(user.email)
    // await authRepository.updatePhoneNumber(user.phoneNumber);
  }

  //
  Future<String> updatePhoto(String uid, XFile photo) async {
    logger.d('photo');
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      return await loading.guardFuture(() async {
        return imageRepository.uploadImage(
          image: await photo.readAsBytes(),
          path: 'users/$uid',
          name: photo.name,
        );
      });
    } on AppException catch (e, st) {
      logger.e('updatePhoto: AppException - ${e.message}', stackTrace: st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('updatePhoto: Exception - $e', stackTrace: st);
      rethrow;
    }
  }

  Future<void> deletePhoto(String uid, XFile photo) async {
    logger.d('photo');
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      await loading.guardFuture(() async {
        await imageRepository.deleteImage(path: uid, name: photo.name);
      });
    } on AppException catch (e, st) {
      logger.e('deletePhoto: AppException - ${e.message}', stackTrace: st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('deletePhoto: Exception - $e', stackTrace: st);
      rethrow;
    }
  }

  // Stripe Connect Account
  // Generate ConnectAccountLink
  Future<void> getAccountLink(String email) async {
    try {
      logger.i('getAccountLink');
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final url = await loading.guardFuture(() async {
        return stripeRepository.getAccountLink(email);
      });
      logger.i(url);
      await sendUrl(url);
    } on AppException catch (e, st) {
      logger.e('getAccountLink: AppException - ${e.message}', stackTrace: st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e(
        'getAccountLink: Exception - $e',
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
    } on AppException catch (e, st) {
      logger.e('createLoginLink: AppException - ${e.message}', stackTrace: st);
      rethrow;
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
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), webOnlyWindowName: '_self');
    } else {
      logger.e('Could not launch URL');
      final Error error = ArgumentError('Error launching $url');
      throw error;
    }
  }
}
