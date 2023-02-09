import 'package:hive/hive.dart';
part 'new_transaction.g.dart';

@HiveType(typeId: 0)
class NewTransaction extends HiveObject {
  @HiveField(0)
  late int storyId;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String summary;
  @HiveField(3)
  late String modifiedAt;
  @HiveField(4)
  late String image;
}
