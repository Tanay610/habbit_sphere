import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habbit_sphere/components/drawer_widget.dart';
import 'package:habbit_sphere/components/habit_tile.dart';
import 'package:habbit_sphere/components/heat_map.dart';
import 'package:habbit_sphere/database/habbit_database.dart';
import 'package:habbit_sphere/models/habbit.dart';
import 'package:habbit_sphere/theme/theme_provider.dart';
import 'package:habbit_sphere/util/habit_util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<HabitDataBase>(context, listen: false).readHabits();
    super.initState();
  }

  final TextEditingController textEditingController = TextEditingController();

  void showDialogBox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: "Create a new habit",
                  ),
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    String newhabitName = textEditingController.text;

                    context.read<HabitDataBase>().addHabit(newhabitName);

                    //pop it
                    Navigator.pop(context);

                    //*
                    textEditingController.clear();
                  },
                  child: Text("Save"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);

                    textEditingController.clear();
                  },
                  child: Text("Cancel"),
                )
              ]);
        });
  }

  void checkHabit(bool? val, Habbit habit) {
    //* update the habit completion status
    if (val != null) {
      context.read<HabitDataBase>().updateHabitCompletion(habit.id, val);
    }
  }

  //* edit habbits
  void edihabits(Habbit habit) {
    textEditingController.text = habit.name;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: textEditingController,
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  String newhabitName = textEditingController.text;

                  context
                      .read<HabitDataBase>()
                      .updateHabitName(habit.id, newhabitName);

                  //pop it
                  Navigator.pop(context);

                  //*
                  textEditingController.clear();
                },
                child: Text("Save"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);

                  textEditingController.clear();
                },
                child: Text("Cancel"),
              )
            ],
          );
        });
  }

  void deleteHabits(Habbit habit) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Are you sure you want to delete this habit?",
            style: TextStyle(
              fontSize: 18
            ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  context.read<HabitDataBase>().deleteHabits(
                        habit.id,
                      );

                  //pop it
                  Navigator.pop(context);
                },
                child: Text("Delete"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitDataBase>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          drawer: DrawerWidget(),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add_rounded,
              size: 28,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
              onPressed: () {
                showDialogBox();
              }),
          body: ListView(
            children: [
              //* heatmap build
              buildHeatMap(),
              buildingHabitList(),
              
            ],
          )
        );
      },
    );
  }

  Widget buildHeatMap(){
    // habit database
    final habitdatabase = context.watch<HabitDataBase>();

    //* current habit list
    List<Habbit> currentHabbits = habitdatabase.currentHabbits;

    // heat amp ui
    return FutureBuilder<DateTime?>(future: habitdatabase.getFirstLaunchDate(), builder: (context, snapshot){
      //* once the data is available build heat map
      if (snapshot.hasData) {
        return HeatMapOrigin(startDate: snapshot.data!, datasets: heatmapDataSet(currentHabbits));
      }else{
        return SizedBox();
      }
    });
  }

  Widget buildingHabitList() {
    //* habit db
    final habitDataBase = context.read<HabitDataBase>();

    //* current habbits
    List<Habbit> currentHabbits = habitDataBase.currentHabbits;

    //* return a new list of habits
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
        itemCount: currentHabbits.length,
        itemBuilder: (context, index) {
          final habit = currentHabbits[index];

          //* check is the habit is completed today
          bool isCompletedToday = isHabitCOmpletedToday(habit.completedDays);

          //* rturn a habit list tile ui
          return HabitTile(
            text: habit.name,
            isCompleted: isCompletedToday,
            onChanged: (val) => checkHabit(val, habit),
            editHabits: (BuildContext context) => edihabits(habit),
            deleteHabits: (BuildContext context) => deleteHabits(habit),
          );
        });
  }
}
