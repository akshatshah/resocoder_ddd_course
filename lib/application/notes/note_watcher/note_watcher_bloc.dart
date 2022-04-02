import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:resocoder_ddd_course/domain/notes/i_note_repository.dart';
import 'package:resocoder_ddd_course/domain/notes/note.dart';
import 'package:resocoder_ddd_course/domain/notes/note_failure.dart';

part 'note_watcher_event.dart';
part 'note_watcher_state.dart';
part 'note_watcher_bloc.freezed.dart';

@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  final INoteRepository _noteRepository;

  StreamSubscription<Either<NoteFailure, KtList<Note>>>?
      _noteStreamSubscription;

  NoteWatcherBloc(this._noteRepository) : super(const _Initial()) {
    on<NoteWatcherEvent>((event, emit) {
      event.map(watchAllStarted: (e) async {
        emit(const NoteWatcherState.loadInProgress());
        await _noteStreamSubscription?.cancel();
        _noteStreamSubscription = _noteRepository.watchAll().listen(
            (failureOrNotes) =>
                add(NoteWatcherEvent.notesReceivedEvent(failureOrNotes)));
      }, watchIncompleteStarted: (e) async {
        emit(const NoteWatcherState.loadInProgress());
        await _noteStreamSubscription?.cancel();
        _noteStreamSubscription = _noteRepository.watchIncompleted().listen(
            (failureOrNotes) =>
                add(NoteWatcherEvent.notesReceivedEvent(failureOrNotes)));
      }, notesReceivedEvent: (e) async {
        emit(
          e.failureOrNotes.fold(
            (l) => NoteWatcherState.loadFailure(l),
            (r) => NoteWatcherState.loadSuccesss(r),
          ),
        );
      });
    });
  }

  @override
  Future<void> close() async {
    await _noteStreamSubscription?.cancel();
    return super.close();
  }
}
