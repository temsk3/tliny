import '../../model/xxx/xxx_model.dart';

abstract class XxxRepository {
  // アイテムのリストを返す
  Future<List<Xxx>> readXxx();
  // アイテムを保存する
  Future<String> createXxx({required Xxx xxx});
  // アイテムを更新する
  Future<void> updateXxx({required Xxx xxx});
  // アイテムを削除する
  Future<void> deleteXxx({required String xxxId});
  //
  Stream<List<Xxx>> streamXxx();
}
