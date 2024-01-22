//* given a habit list of completion days
//* is the new habit completed tofay

import 'package:flutter/material.dart';
import 'package:habbit_sphere/models/habbit.dart';

bool isHabitCOmpletedToday(List<DateTime> completedDays){
  final today = DateTime.now();
  return completedDays.any((element) => 
  element.year == today.year&&element.month == today.month && element.day == today.day
  );
}


//* prepare heat map dataset

Map<DateTime, int> heatmapDataSet(List<Habbit> habits){
  Map <DateTime, int> dataset = {};

  for (var habit in habits) {
    for(var date in habit.completedDays){
      //* normalize date tp avoid time mismatch
      final normalizeData = DateTime(date.year, date.month, date.day);

      //* if the data already exists in the dataset. increment its count
      if (dataset.containsKey(normalizeData)) {
        dataset[normalizeData] = dataset[normalizeData]! +1;
        
      }else{
        dataset[normalizeData] = 1;
      }
    }
  }
  return dataset;
}