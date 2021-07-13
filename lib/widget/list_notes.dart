import 'package:flutter/material.dart';
import 'package:note_app/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import 'package:note_app/page/manage_note_page.dart';
import 'package:note_app/model/note.dart';

class ListNotes extends StatefulWidget {
  ListNotes({
    Key key,
    this.notesForDisplay,
  }) : super(key: key);

  final List<Note> notesForDisplay;

  @override
  _ListNotesState createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
  @override
  Widget build(BuildContext context) {
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
            childAspectRatio: 0.9,
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: widget.notesForDisplay.length,
          itemBuilder: (context, index) {
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
                                  widget.notesForDisplay[index].title,
                                  style: GoogleFonts.poppins(
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
                            widget.notesForDisplay[index].description,
                            style: GoogleFonts.poppins(
                              color: backgroundColor,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              openBuilder: (context, _) => ManageNotePage(
                id: widget.notesForDisplay[index].id,
                title: widget.notesForDisplay[index].title,
                description: widget.notesForDisplay[index].description,
                inputType: "Edit",
              ),
            );
          },
        ),
      ],
    );
  }
}
