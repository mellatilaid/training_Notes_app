import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/constants.dart';

import '../cubits/add_note_cubit/add_note_cubit.dart';
import 'note_color.dart';

class NoteColorsListView extends StatefulWidget {
  const NoteColorsListView({super.key});

  @override
  State<NoteColorsListView> createState() => _NoteColorsListViewState();
}

class _NoteColorsListViewState extends State<NoteColorsListView> {
  int itemColorIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24 * 2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kColors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                itemColorIndex = index;
              });
              BlocProvider.of<AddNoteCubit>(context)
                  .set(color: kColors[index].value);
            },
            child: NoteColor(
              itemColor: kColors[index],
              isItemSelected: itemColorIndex == index,
            ),
          );
        },
      ),
    );
  }
}
