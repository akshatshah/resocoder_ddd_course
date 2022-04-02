import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resocoder_ddd_course/application/notes/note_watcher/note_watcher_bloc.dart';

class IncompletedSwitch extends HookWidget {
  const IncompletedSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toggleState = useState(false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkResponse(
        onTap: () {
          context.read<NoteWatcherBloc>().add(toggleState.value
              ? const NoteWatcherEvent.watchIncompleteStarted()
              : const NoteWatcherEvent.watchAllStarted());
          toggleState.value = !toggleState.value;
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: toggleState.value
              ? const Icon(
                  Icons.check_box_outline_blank,
                  key: Key('outline'),
                )
              : const Icon(
                  Icons.indeterminate_check_box,
                  key: Key('indeterminate'),
                ),
        ),
      ),
    );
  }
}
