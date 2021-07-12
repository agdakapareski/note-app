import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:note_app/Page/add_notes_page.dart';
import 'package:note_app/Page/edit_note_page.dart';
import 'package:note_app/constant.dart';
import 'package:note_app/database/database.dart';
import 'package:note_app/model/note.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Note> _notes = [];
  List<Note> _notesForDisplay = [];
  String mainFont = 'Poppins';

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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.menu),
          onTap: () {},
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: Icon(Icons.search),
            ),
          )
        ],
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'My',
                style: title1,
              ),
              TextSpan(
                text: 'Notes',
                style: title2,
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      floatingActionButton: OpenContainer(
        closedColor: yellow,
        openColor: yellow,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
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
        openBuilder: (context, _) => AddNotesPage(),
      ),
      body: Column(children: [
        Container(
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
        ),
        list(),
      ]),
    );
  }

  dataNotes() {
    return ListView(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      children: [
        GridView.builder(
          physics: ScrollPhysics(),
          padding: EdgeInsets.only(
            bottom: 6,
          ),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: _notesForDisplay.length,
          itemBuilder: (context, i) {
            return OpenContainer(
              closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              closedColor: white,
              closedBuilder: (context, callback) {
                return GestureDetector(
                  onTap: callback,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          color: yellow,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _notesForDisplay[i].title,
                                  style: GoogleFonts.getFont(
                                    mainFont,
                                    color: primaryColor,
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            _notesForDisplay[i].description,
                            style: GoogleFonts.getFont(
                              mainFont,
                              color: backgroundColor,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              openBuilder: (context, _) => EditNotePage(
                id: _notesForDisplay[i].id,
                title: _notesForDisplay[i].title,
                description: _notesForDisplay[i].description,
              ),
            );
          },
        ),
      ],
    );
  }

  list() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
        ),
        child: dataNotes(),
      ),
    );
  }
}
