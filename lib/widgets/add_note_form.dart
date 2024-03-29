import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_states.dart';
import 'package:notes_app/models/note_model.dart';

import '../constants.dart';
import 'custom_action_button.dart';
import 'custom_text_field.dart';
import 'note_colors_list_view.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key});

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextField(
            onSaved: (data) {
              title = data;
            },
            hintText: 'Title',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            onSaved: (data) {
              subTitle = data;
            },
            hintText: 'content',
            maxLines: 5,
          ),
          const SizedBox(
            height: 20,
          ),
          const NoteColorsListView(),
          const SizedBox(
            height: 32,
          ),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            buildWhen: (previous, current) =>
                previous is AddNoteLoading != current is AddNoteLoading,
            builder: (context, state) {
              return CustomActionButton(
                isLoading: state is AddNoteLoading,
                title: 'Add',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    var noteModel = NoteModel(
                      title: title!,
                      subTitle: subTitle!,
                      date: formatDate(time: DateTime.now()),
                      color: Colors.green.value,
                    );
                    BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                backGroundColor: kPrimaryColor,
              );
            },
          ),
        ],
      ),
    );
  }

  String formatDate({required DateTime time}) {
    final year = time.year.toString();

    final String month = time.month.toString();

    final String day = time.day.toString();

    return '$day/$month/$year';
  }
}
