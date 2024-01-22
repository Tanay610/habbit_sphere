
import 'package:isar/isar.dart';

part 'settings.g.dart';

@Collection()
class AppSetting{
  Id id = Isar.autoIncrement;
  DateTime? firstLaunchDate;

}