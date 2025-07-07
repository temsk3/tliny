import 'package:cloud_firestore/cloud_firestore.dart';

class TestTicketCreator {
  TestTicketCreator(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> createTestTickets() async {
    try {
      // テスト用のチケットデータ
      final testTickets = [
        {
          'id': 'test_ticket_1',
          'userId': 'test_user_1',
          'productId': 'test_product_1',
          'productName': 'テスト商品1',
          'isUsed': false,
          'createdAt': DateTime.now(),
          'deletedAt': null,
        },
        {
          'id': 'test_ticket_2',
          'userId': 'test_user_1',
          'productId': 'test_product_2',
          'productName': 'テスト商品2',
          'isUsed': false,
          'createdAt': DateTime.now(),
          'deletedAt': null,
        },
        {
          'id': 'test_ticket_3',
          'userId': 'test_user_2',
          'productId': 'test_product_1',
          'productName': 'テスト商品1',
          'isUsed': true,
          'createdAt': DateTime.now().subtract(const Duration(days: 1)),
          'deletedAt': null,
        },
      ];

      // バッチ処理でチケットを作成
      final batch = _firestore.batch();

      for (final ticketData in testTickets) {
        final docRef = _firestore
            .collection('tickets')
            .doc(ticketData['id']! as String);
        batch.set(docRef, {
          'userId': ticketData['userId'],
          'productId': ticketData['productId'],
          'productName': ticketData['productName'],
          'isUsed': ticketData['isUsed'],
          'createdAt': Timestamp.fromDate(ticketData['createdAt']! as DateTime),
          'deletedAt':
              ticketData['deletedAt'] != null
                  ? Timestamp.fromDate(ticketData['deletedAt']! as DateTime)
                  : null,
        });
      }

      await batch.commit();
      print('テスト用チケットの作成が完了しました');
    } catch (e) {
      print('テスト用チケットの作成に失敗しました: $e');
      rethrow;
    }
  }

  Future<void> deleteTestTickets() async {
    try {
      final querySnapshot =
          await _firestore
              .collection('tickets')
              .where(
                'id',
                whereIn: ['test_ticket_1', 'test_ticket_2', 'test_ticket_3'],
              )
              .get();

      final batch = _firestore.batch();
      for (final doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      print('テスト用チケットの削除が完了しました');
    } catch (e) {
      print('テスト用チケットの削除に失敗しました: $e');
      rethrow;
    }
  }
}
