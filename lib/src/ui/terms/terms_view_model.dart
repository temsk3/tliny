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

part 'terms_view_model.g.dart';

// final logger = Logger();

@riverpod
class TermsViewModel extends _$TermsViewModel {
  late final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  late final UserRepository userRepository = ref.watch(userRepositoryProvider);
  late final ImageRepository imageRepository = ref.watch(
    imageRepositoryProvider,
  );
  late final StripeRepository stripeRepository = ref.watch(
    stripeRepositoryProvider,
  );

  @override
  FutureOr<User> build(String uid) {
    return _readUserDirectly(uid);
  }

  // 直接ユーザー情報を取得（buildメソッド用）
  Future<User> _readUserDirectly(String uid) async {
    logger.d('_readUserDirectly');
    try {
      return await userRepository.readUser(uid);
    } on AppException catch (e, st) {
      logger.e(
        '_readUserDirectly: AppException - ${e.message}',
        stackTrace: st,
      );
      rethrow;
    } on Exception catch (e, st) {
      logger.e('_readUserDirectly: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
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
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  // 取得（ローディング付き）
  Future<User> readUser(String uid) async {
    logger.d('readUser');
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final user = await loading.guardFuture(() async {
        return userRepository.readUser(uid);
      });
      state = AsyncValue.data(user);
      return user;
    } on AppException catch (e, st) {
      logger.e('readUser: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('readUser: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
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
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
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
      updateProfile(data);
      state = AsyncValue.data(updatedUser);
    } on AppException catch (e, st) {
      logger.e('updateUser: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('updateUser: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
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
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
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
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
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
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
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
      //
      await sendUrl(url);

      // 成功メッセージを表示
      logger.i('Account link successfully launched in new tab');
    } on AppException catch (e, st) {
      logger.e('getAccountLink: AppException - ${e.message}', stackTrace: st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e(
        'createAccountLinkError',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      rethrow;
    }
  }

  Future<void> createLoginLink() async {
    try {
      logger.i('getLoginLink');
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final url = await loading.guardFuture(() async {
        return stripeRepository.createLoginLink();
      });
      logger.i(url);
      //
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
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      rethrow;
    }
  }

  Future<void> sendUrl(String url) async {
    logger.i('sendUrl: attempting to launch URL: $url');
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        logger.i('sendUrl: canLaunchUrl returned true, launching URL...');
        final result = await launchUrl(
          Uri.parse(url),
          webOnlyWindowName: '_blank',
        );
        logger.i('sendUrl: launchUrl result: $result');
        if (!result) {
          logger.e('sendUrl: launchUrl returned false');
          throw ArgumentError('Failed to launch URL: $url');
        }
      } else {
        logger.e('sendUrl: canLaunchUrl returned false');
        final Error error = ArgumentError('Cannot launch URL: $url');
        throw error;
      }
    } on Exception catch (e, st) {
      logger.e('sendUrl: Exception occurred: $e', stackTrace: st);
      rethrow;
    }
  }
}
