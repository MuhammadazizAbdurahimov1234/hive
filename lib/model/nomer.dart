import 'package:hive/hive.dart';

part 'nomer.g.dart';

@HiveType(typeId: 7)
class Nomer {
  @HiveField(0)
  final String ism;
  @HiveField(1)
  final int nomer;

  Nomer(this.ism, this.nomer);
}
