import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/repository/stripe/stripe_test_repository_impl.dart';

final logger = Logger();

final stripeAccountViewModelProvider = Provider(StripeAccountViewModel.new);

class StripeAccountViewModel {
  StripeAccountViewModel(this._ref);
  final Ref _ref;

  Future<void> sendUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), webOnlyWindowName: '_self');
    } else {
      logger.e('Could not launch URL');
      final Error error = ArgumentError('Error launching $url');
      throw error;
    }
  }

  //
  // Generate ConnectAccountLink
  Future<void> getAccountLink(String email) async {
    try {
      logger.i('getAccountLink');
      final url =
          await _ref.read(stripeRepositoryProvider).getAccountLink(email);
      logger.i(url);
      //
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), webOnlyWindowName: '_self');
      } else {
        logger.e('Could not launch URL');
        final Error error = ArgumentError('Error launching $url');
        throw error;
      }
    } catch (e, st) {
      logger.e('createAccountLinkError', [e, st]);
      rethrow;
    }
  }
}
