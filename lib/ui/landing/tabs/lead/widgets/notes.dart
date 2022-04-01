import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/notes.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/widgetHelper/bottomsheet.dart';
import 'package:salessimplify/ui/widgetHelper/custom_alertdialog.dart';
import 'package:salessimplify/ui/widgetHelper/dotted_button.dart';
import 'package:salessimplify/ui/widgetHelper/edit_button.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/tab_loader.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';

class NotesList extends StatefulWidget {
  String idType, id;
  NotesList({Key? key, required this.id, required this.idType})
      : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  Map<String, dynamic> params = {};

  confirmDelete(String id) {
    var baseDialog = BaseAlertDialog(
        title: "Are you sure?",
        content: "Do you want to delete this note?",
        yesOnPressed: () {
          Navigator.pop(context);
          deleteNote(context, id);
        },
        noOnPressed: () {
          Navigator.pop(context);
        },
        yes: "Delete",
        no: "Cancel");
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Repository.getInstance()
          .getNotes(params: {widget.idType: widget.id.toString()}),
      builder: (context, snapshot) {
        List<Notes>? notes;
        if (snapshot.connectionState == ConnectionState.done) {
          notes = snapshot.data as List<Notes>?;
        }
        return snapshot.connectionState == ConnectionState.done
            ? notes!.isEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child: new DottedButton(
                          title: 'Add a new note',
                          onTap: () {
                            customBottomSheet.addNoteBottomDialog(
                                context, widget.idType, widget.id);
                          },
                        ),
                      ),
                      Expanded(
                        child: emptyListHelper.getEmptyList(
                            EmptyListHelper.emptyList, context),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: notes == null ? 1 : notes.length + 1,
                    itemBuilder: (BuildContext context, int i) {
                      if (i == 0) {
                        // return the header
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: new DottedButton(
                            title: 'Add a new note',
                            onTap: () {
                              customBottomSheet.addNoteBottomDialog(
                                  context, widget.idType, widget.id);
                            },
                          ),
                        );
                      }
                      i -= 1;
                      return ListTile(
                        onLongPress: () {},
                        title: Html(data: notes?[i].content ?? ''),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  colors: [redColor, redColor],
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  confirmDelete(notes![i].id);
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.delete,
                                    color: white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            EditButton(
                              colors: [grey, grey],
                              onTap: () {
                                Clipboard.setData(
                                    new ClipboardData(text: notes![i].content));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Copied to Clipboard!'),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.copy,
                                color: white,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                            EditButton(
                              onTap: () {
                                customBottomSheet.updateNoteBottomDialog(
                                    context, notes![i].id, notes[i].content);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  )
            : TabLoader();
      },
    );
  }

  deleteNote(BuildContext context, String id) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess = await context.read<Repository>().deleteNote(id);
    pr.hide().then((isHidden) {
      print(isHidden);
    });

    if (isSuccess is bool && isSuccess) {
      toastHelper.toastWithTitleAndColor("Deleted successfully!", greenColor);
      setState(() {});
      // Navigator.of(context).pop();
    } else {
      toastHelper.toastWithTitleAndColor("Failed to delete!", redColor);
    }
  }
}
