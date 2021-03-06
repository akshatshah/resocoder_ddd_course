import 'package:flutter/material.dart';
import 'package:resocoder_ddd_course/domain/notes/note_failure.dart';

class CricitcalFailureDisplayWidget extends StatelessWidget {
  final NoteFailure failure;
  const CricitcalFailureDisplayWidget({
    Key? key,
    required this.failure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '😱',
            style: TextStyle(
              fontSize: 100,
            ),
          ),
          Text(
            failure.maybeMap(
              orElse: () => 'Unexpected Error \n Please contact support',
              insufficientPermissions: (_) => 'Insufficient Premission',
            ),
            style: const TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
          TextButton(
              onPressed: () {
                print('Sending Email');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.mail),
                  SizedBox(
                    width: 4,
                  ),
                  Text('I NEED HELP'),
                ],
              )),
        ],
      ),
    );
  }
}
