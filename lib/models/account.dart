import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class AccountModel {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? type;

  @HiveField(2)
  String? currency;

  @HiveField(3)
  double? amount;

  @HiveField(4)
  int? iconID;

  AccountModel({
    this.title,
    this.type,
    this.currency,
    this.amount,
    this.iconID,
  });
}
