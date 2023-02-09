import 'package:excercise_2/models/new_transaction.dart';

import 'package:hive/hive.dart';

class NewBox {
  static Box<NewTransaction> getNewTransaction() =>
      Hive.box<NewTransaction>('NewTransaction');
}
