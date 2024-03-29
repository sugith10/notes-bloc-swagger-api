import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_note/bloc/note_bloc.dart';
import 'package:new_note/model/note_model/note_model.dart';

// ignore: must_be_immutable
class AddToDoScrn extends StatelessWidget {

  final NoteModel? note;
  AddToDoScrn({super.key, this.note});

  TextEditingController titleCntrl = TextEditingController();
  TextEditingController contentCntrl = TextEditingController();
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
     if (note != null) {
      isEdit = true;
      titleCntrl.text = note!.title;
      contentCntrl.text = note!.description;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEdit ? 'Edit Todo' : 'Add ToDo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: titleCntrl,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(hintText: 'Title'),
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: contentCntrl,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: 'Content',
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
            style:const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              final noteBloc =  BlocProvider.of<NoteBloc>(context); 
              if (isEdit) {
                noteBloc.add(UpdateNote(
                    id: note!.id,
                    title: titleCntrl.text,
                    content: contentCntrl.text));
              } else {
                noteBloc.add(AddNote(
                    title: titleCntrl.text, content: contentCntrl.text));
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(30, 50),
            ),
            child: Text(
              isEdit ? 'Update' : 'Submit',
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22.5,
                  color: Colors.black),
            ),
          ),

        ],
      ),
    );
  }
}
