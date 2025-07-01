import 'package:flutter_test/flutter_test.dart';

import 'integration/app_integration_test.dart' as app_integration_test;
import 'unit/models/cart_model_test.dart' as cart_model_test;
// Import all test files
import 'unit/models/product_model_test.dart' as product_model_test;
import 'unit/models/user_model_test.dart' as user_model_test;
import 'unit/repositories/auth_repository_test.dart' as auth_repository_test;
import 'unit/viewmodels/product_view_model_test.dart'
    as product_view_model_test;
import 'widget/product_card_test.dart' as product_card_test;
import 'widget/product_list_test.dart' as product_list_test;

void main() {
  group('Unit Tests', () {
    group('Model Tests', () {
      product_model_test.main();
      user_model_test.main();
      cart_model_test.main();
    });

    group('Repository Tests', auth_repository_test.main);

    group('ViewModel Tests', product_view_model_test.main);
  });

  group('Widget Tests', () {
    product_card_test.main();
    product_list_test.main();
  });

  group('Integration Tests', app_integration_test.main);
}
