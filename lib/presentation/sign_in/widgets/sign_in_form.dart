import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resocoder_ddd_course/application/auth/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
        builder: (context, state) {
          return Form(
            child: ListView(
              children: const [
                Text(
                  '📝',
                  style: TextStyle(fontSize: 130),
                )
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
