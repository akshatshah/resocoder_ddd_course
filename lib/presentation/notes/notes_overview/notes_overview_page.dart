import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resocoder_ddd_course/application/auth/auth_bloc.dart';
import 'package:resocoder_ddd_course/application/notes/note_actor/note_actor_bloc.dart';
import 'package:resocoder_ddd_course/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:resocoder_ddd_course/injection.dart';
import 'package:resocoder_ddd_course/presentation/notes/notes_overview/widgets/incompleted_switch.dart';
import 'package:resocoder_ddd_course/presentation/notes/notes_overview/widgets/notes_overview_body_widget.dart';
import 'package:resocoder_ddd_course/presentation/routes/router.dart';

class NotesOverviewPage extends StatelessWidget {
  const NotesOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(const NoteWatcherEvent.watchAllStarted()),
        ),
        BlocProvider<NoteActorBloc>(
          create: (context) => getIt<NoteActorBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: ((context, state) {
            state.maybeMap(
              orElse: () {},
              unauthenticated: (_) => AutoRouter.of(context).replace(
                const SignInPageRoute(),
              ),
            );
          })),
          BlocListener<NoteActorBloc, NoteActorState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  deleteFailure: (state) {
                    FlushbarHelper.createError(
                      message: state.noteFailure.map(
                        unexpected: (_) => 'Unexpected error occured',
                        insufficientPermissions: (_) =>
                            'Insufficient Permissions',
                        unableToUpdate: (_) => 'Impossible error',
                      ),
                      duration: const Duration(seconds: 5),
                    ).show(context);
                  });
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signedOut());
              },
            ),
            actions: const [
              IncompletedSwitch(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.navigateTo(NoteFormPageRoute(editedNote: null));
            },
            child: const Icon(Icons.add),
          ),
          body: const NotesOverviewBody(),
        ),
      ),
    );
  }
}
