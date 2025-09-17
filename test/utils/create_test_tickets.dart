import 'package:cloud_firestore/cloud_firestore.dart';

class TestTicketCreator {
  TestTicketCreator(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> createTestTickets() async {
    try {
      // 現在のユーザーID（ログから取得）
      const userId = '2qYNpcGl9NKbQ7p11dRAOF2jpwzC';
      const productId = 'ab2WcpDX3rJmxlAI5anY'; // 商品「asd」のID
      const eventId = '3hj99jSIfuJzZkvAOfnp'; // イベントID

      // テスト用のチケットデータ（現在のデータ構造に合わせて）
      final testTickets = [
        {
          'name': 'asd',
          'eventId': eventId,
          'uuid': 'test_uuid_1',
          'ownerId': userId,
          'ownerName': 'c',
          'productId': productId,
          'isUsed': false,
          'isActive': true,
          'purchaseTime': DateTime.now().subtract(const Duration(days: 2)),
          'createdAt': DateTime.now().subtract(const Duration(days: 2)),
          'updatedAt': DateTime.now().subtract(const Duration(days: 2)),
          'deletedAt': null,
        },
        {
          'name': 'asd',
          'eventId': eventId,
          'uuid': 'test_uuid_2',
          'ownerId': userId,
          'ownerName': 'c',
          'productId': productId,
          'isUsed': false,
          'isActive': true,
          'purchaseTime': DateTime.now().subtract(const Duration(days: 1)),
          'createdAt': DateTime.now().subtract(const Duration(days: 1)),
          'updatedAt': DateTime.now().subtract(const Duration(days: 1)),
          'deletedAt': null,
        },
        {
          'name': 'asd',
          'eventId': eventId,
          'uuid': 'test_uuid_3',
          'ownerId': userId,
          'ownerName': 'c',
          'productId': productId,
          'isUsed': true,
          'register': userId,
          'registerName': 'c',
          'isActive': true,
          'purchaseTime': DateTime.now().subtract(const Duration(hours: 2)),
          'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
          'updatedAt': DateTime.now().subtract(const Duration(hours: 1)),
          'deletedAt': null,
        },
      ];

      // バッチ処理でチケットを作成
      final batch = _firestore.batch();

      for (var i = 0; i < testTickets.length; i++) {
        final ticketData = testTickets[i];
        final docRef =
            _firestore
                .collection('v/1/customers')
                .doc(userId)
                .collection('tickets')
                .doc();

        batch.set(docRef, {
          'name': ticketData['name'],
          'eventId': ticketData['eventId'],
          'uuid': ticketData['uuid'],
          'ownerId': ticketData['ownerId'],
          'ownerName': ticketData['ownerName'],
          'productId': ticketData['productId'],
          'isUsed': ticketData['isUsed'],
          'isActive': ticketData['isActive'],
          'purchaseTime': Timestamp.fromDate(
            ticketData['purchaseTime']! as DateTime,
          ),
          'createdAt': Timestamp.fromDate(ticketData['createdAt']! as DateTime),
          'updatedAt': Timestamp.fromDate(ticketData['updatedAt']! as DateTime),
          'deletedAt':
              ticketData['deletedAt'] != null
                  ? Timestamp.fromDate(ticketData['deletedAt']! as DateTime)
                  : null,
          if (ticketData['register'] != null)
            'register': ticketData['register'],
          if (ticketData['registerName'] != null)
            'registerName': ticketData['registerName'],
        });
      }

      // 使用済みチケットの利用履歴も作成
      final usageHistoryRef =
          _firestore
              .collection('v/1/customers')
              .doc(userId)
              .collection('use_of_tickets')
              .doc();

      batch.set(usageHistoryRef, {
        'dateOfUse': Timestamp.fromDate(
          DateTime.now().subtract(const Duration(hours: 1)),
        ),
        'eventId': eventId,
        'receptionistId': userId,
        'useTicket': ['test_uuid_3'],
        'createdAt': Timestamp.fromDate(
          DateTime.now().subtract(const Duration(hours: 1)),
        ),
        'updatedAt': Timestamp.fromDate(
          DateTime.now().subtract(const Duration(hours: 1)),
        ),
        'deletedAt': null,
      });

      await batch.commit();
      // print('テスト用チケットの作成が完了しました');
    } catch (e) {
      // print('テスト用チケットの作成に失敗しました: $e');
      rethrow;
    }
  }

  Future<void> deleteTestTickets() async {
    try {
      const userId = '2qYNpcGl9NKbQ7p11dRAOF2jpwzC';

      // テスト用チケットを削除
      final ticketsQuery =
          await _firestore
              .collection('v/1/customers')
              .doc(userId)
              .collection('tickets')
              .where(
                'uuid',
                whereIn: ['test_uuid_1', 'test_uuid_2', 'test_uuid_3'],
              )
              .get();

      final batch = _firestore.batch();
      for (final doc in ticketsQuery.docs) {
        batch.delete(doc.reference);
      }

      // テスト用利用履歴を削除
      final usageHistoryQuery =
          await _firestore
              .collection('v/1/customers')
              .doc(userId)
              .collection('use_of_tickets')
              .where('useTicket', arrayContains: 'test_uuid_3')
              .get();

      for (final doc in usageHistoryQuery.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      // print('テスト用チケットの削除が完了しました');
    } catch (e) {
      // print('テスト用チケットの削除に失敗しました: $e');
      rethrow;
    }
  }
}
