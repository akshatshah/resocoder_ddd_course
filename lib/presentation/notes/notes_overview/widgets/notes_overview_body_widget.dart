import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resocoder_ddd_course/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:resocoder_ddd_course/presentation/notes/notes_overview/widgets/critical_failure_display_widget.dart';
import 'package:resocoder_ddd_course/presentation/notes/notes_overview/widgets/error_note_card_widget.dart';
import 'package:resocoder_ddd_course/presentation/notes/notes_overview/widgets/note_card.dart';

class NotesOverviewBody extends StatelessWidget {
  const NotesOverviewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteWatcherBloc, NoteWatcherState>(
      builder: ((context, state) {
        return state.map(
            initial: (_) => Container(),
            loadInProgress: (_) => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
            loadSuccesss: (state) {
              return ListView.builder(
                itemCount: state.notes.size,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  if (note.failureOption.isSome()) {
                    return ErrorNoteCard(
                      note: note,
                    );
                  } else {
                    return NoteCard(
                      note: note,
                    );
                  }
                },
              );
            },
            loadFailure: (state) {
              return CricitcalFailureDisplayWidget(failure: state.noteFailure);
            });
      }),
    );
  }
}
