import 'package:flutter/material.dart';
import 'package:note_app/database/database.dart';
import 'package:note_app/model/note.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/constant.dart';
import 'package:note_app/widget/app_bar_title.dart';

class ManageNotePage extends StatefulWidget {
  ManageNotePage({
    Key key,
    this.id,
    this.title,
    this.description,
    this.inputType,
  }) : super(key: key);

  final int id;
  final String title;
  final String description;
  final String inputType;

  @override
  _ManageNotePageState createState() => _ManageNotePageState();
}

class _ManageNotePageState extends State<ManageNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int id;
  String title;
  String description;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.inputType == "Edit") {
        id = widget.id;
        titleController.text = widget.title;
        descriptionController.text = widget.description;
      }
    });
  }

  clearText() {
    titleController.text = '';
    descriptionController.text = '';
  }

  toHomePage() {
    Navigator.of(context).pushNamedAndRemoveUntil('homepage', (route) => false);
  }

  submitNotes() {
    title = titleController.text;
    description = descriptionController.text;
    if (widget.inputType == "Add") {
      Note note = Note(null, title, description);

      clearText();
      if (description == '' && title == '') {
        toHomePage();
      } else {
        Db().save(note);
        toHomePage();
      }
    } else if (widget.inputType == "Edit") {
      Note note = Note(id, title, description);
      Db().update(note);
      clearText();
      toHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: AppBarTitle(
          title: widget.inputType,
          subtitle: 'Note',
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      color: yellow,
                    ),
                    alignment: Alignment.centerLeft,
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
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: backgroundColor,
                              ),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Title...',
                              border: InputBorder.none,
                              hintStyle: hintTextCustom,
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
                        ),
                        widget.inputType == "Edit"
                            ? iconController()
                            : SizedBox()
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                        color: white,
                      ),
                      alignment: Alignment.topLeft,
                      height: 250,
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                      child: TextField(
                        cursorColor: yellow,
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 23,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: backgroundColor,
                          ),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Write something...',
                          border: InputBorder.none,
                          hintStyle: hintTextCustom,
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

  iconController() {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            child: Icon(
              Icons.delete,
              color: backgroundColor,
            ),
            onTap: () {
              setState(() {
                Db().delete(id);
                toHomePage();
              });
            },
          ),
        ),
      ],
    );
  }
}
