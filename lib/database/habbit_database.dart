import 'package:flutter/material.dart';
import 'package:habbit_sphere/models/habbit.dart';
import 'package:habbit_sphere/models/settings.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDataBase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        await Isar.open([HabbitSchema, AppSettingSchema], directory: dir.path);    
  }

  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSetting()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
    notifyListeners();
  }

  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    notifyListeners();
    return settings?.firstLaunchDate;
  }

  //! CREATE -ADD a new habbit

  final List<Habbit> currentHabbits = [];

  Future<void> addHabit(String habitName) async {
    //* create a new habit
    final newHabit = Habbit()..name = habitName;

    //* save to database
    await isar.writeTxn(() => isar.habbits.put(newHabit));

    readHabits();
  }

  Future<void> readHabits() async {
    List<Habbit> fetchedResults = await isar.habbits.where().findAll();

    //* give to current habbits
    currentHabbits.clear();
    currentHabbits.addAll(fetchedResults);

    notifyListeners();
  }

  Future<void> updateHabitCompletion(int id, bool isCOmpleted) async {
    final habit = await isar.habbits.get(id);

    ///* update completion statyus
    if (habit != null) {
      await isar.writeTxn(() async {
        // if habit is completed add the current date to the completedDays list
        if (isCOmpleted && !habit.completedDays.contains(DateTime.now())) {
          final today = DateTime.now();

          //* add currrent date if its not already in the list
          habit.completedDays.add(DateTime(today.year, today.month, today.day));

          //* if habit is not completed => remove the current date from the list
        } else {
          //* remove the current date if the habit is marked as not completed
          habit.completedDays.removeWhere((date) =>
              date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day);
        }

        await isar.habbits.put(habit);
      });
    }
    readHabits();
  }

  //* UPdate - edit habit name

  Future <void> updateHabitName(int id, String newName)async{
    //* find the specific habit
    final habit = await isar.habbits.get(id);

    //* update the habit name
    if(habit != null){
      //* update name
      await isar.writeTxn(() async{
        habit.name = newName;
        //* save updated habit back to the db
        await isar.habbits.put(habit);
      });
    }

    //* re-read from db
    readHabits();
  }

  //* delte habits
  Future<void> deleteHabits(int id)async{
    await isar.writeTxn(()async {
      await isar.habbits.delete(id);

    });
    readHabits();
    }
}
