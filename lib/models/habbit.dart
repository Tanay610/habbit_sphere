import 'package:isar/isar.dart';

part 'habbit.g.dart';

@Collection()
class Habbit{
  Id id = Isar.autoIncrement;

  late String name;

  List <DateTime> completedDays =[

  ];
}