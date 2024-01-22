import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabits;
  final void Function(BuildContext)? deleteHabits;
  const HabitTile({super.key, required this.text, required this.isCompleted, required this.onChanged, required this.editHabits, required this.deleteHabits});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(onPressed: editHabits,
          backgroundColor: Colors.grey.shade800,
          icon: Icons.edit,
          borderRadius: BorderRadius.circular(8),
          ),
          SlidableAction(onPressed: deleteHabits,
          backgroundColor: Colors.red,
          icon: Icons.delete,
          borderRadius: BorderRadius.circular(8),
          )
        ]),
        child: GestureDetector(
          onTap: (){
            if (onChanged!=null) {
              onChanged!(!isCompleted);
            }
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isCompleted?Colors.blue:Theme.of(context).colorScheme.secondary,
            ),
            child: ListTile(
              title: Text(text,
              style: TextStyle(
                color: isCompleted?Colors.white:Colors.black
              ),
              ),
              leading: Checkbox(
                activeColor: Colors.blue,
                onChanged: onChanged, value: isCompleted,),
            ),
          ),
        ),
      ),
    );
  }
}

// Theme.of(context).colorScheme.secondary