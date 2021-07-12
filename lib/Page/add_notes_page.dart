import 'package:flutter/material.dart';
import 'package:note_app/database/database.dart';
import 'package:note_app/model/note.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/constant.dart';

class AddNotesPage extends StatefulWidget {
  AddNotesPage({Key key}) : super(key: key);

  @override
  _AddNotesPageState createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  String mainFont = 'Poppins';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String title;
  String description;

  clearText() {
    titleController.text = '';
    descriptionController.text = '';
  }

  submitNotes() {
    title = titleController.text;
    description = descriptionController.text;
    Note note = Note(null, title, description);

    clearText();
    if (description == '' && title == '') {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('homepage', (route) => false);
    } else {
      Db().save(note);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('homepage', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Add',
                style: title1,
              ),
              TextSpan(
                text: 'Note',
                style: title2,
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: yellow,
                    ),
                    height: 50,
                    padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorColor: white,
                            keyboardType: TextInputType.text,
                            maxLines: 10,
                            controller: titleController,
                            style: GoogleFonts.getFont(
                              mainFont,
                              textStyle: TextStyle(
                                color: backgroundColor,
                              ),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Title...',
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.getFont(
                                mainFont,
                                textStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            child: Icon(
                              Icons.done,
                              color: backgroundColor,
                            ),
                            onTap: () {
                              setState(() {
                                submitNotes();
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: white,
                      ),
                      alignment: Alignment.topLeft,
                      height: 250,
                      margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                      child: TextField(
                        cursorColor: yellow,
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        style: GoogleFonts.getFont(
                          mainFont,
                          textStyle: TextStyle(
                            color: backgroundColor,
                          ),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Write something...',
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.getFont(
                            mainFont,
                            textStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
