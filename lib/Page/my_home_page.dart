import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:note_app/page/manage_note_page.dart';
import 'package:note_app/constant.dart';
import 'package:note_app/database/database.dart';
import 'package:note_app/model/note.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/widget/app_bar_title.dart';
import 'package:note_app/widget/list_notes.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Variable init to store data from database
  List<Note> _notes = [];

  //Variable init to store data from database, for displaying purpose(search function)
  List<Note> _notesForDisplay = [];

  String inputType = "Add";

  //Init and store data from database to variables
  @override
  void initState() {
    super.initState();
    Db().getNotes().then((value) {
      setState(() {
        _notes.addAll(value);
        _notesForDisplay = _notes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      //Home Page App Bar
      appBar: AppBar(
        elevation: 0,

        //Task list icon in app bar
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: Icon(Icons.list),
            ),
          )
        ],

        //App Bar title
        title: Padding(
          padding: EdgeInsets.only(left: 2.0),
          child: AppBarTitle(
            title: 'My',
            subtitle: 'Notes',
          ),
        ),

        //App Bar background color
        backgroundColor: backgroundColor,
      ),

      //Animation container to handle add note animation
      floatingActionButton: OpenContainer(
        closedColor: yellow,
        openColor: yellow,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),

        //Floating action button to add note
        closedBuilder: (context, callback) {
          return FloatingActionButton(
            backgroundColor: yellow,
            child: Icon(
              Icons.add,
              color: backgroundColor,
            ),
            onPressed: callback,
          );
        },
        openBuilder: (context, _) => ManageNotePage(
          inputType: "Add",
        ),
      ),

      //App Body, contains search bar and notes
      body: Column(children: [
        searchBar(),
        ListNotes(
          notesForDisplay: _notesForDisplay,
        ),
      ]),
    );
  }

  //Search bar widget
  searchBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: white,
          ),
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _notesForDisplay = _notes.where((element) {
              var noteTitle = element.title.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          hintText: "Search the title here. . .",
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
