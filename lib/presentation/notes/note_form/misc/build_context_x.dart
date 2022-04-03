import 'package:flutter/widgets.dart';
import 'package:kt_dart/kt.dart';
import 'package:resocoder_ddd_course/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:provider/provider.dart';

extension FormTodosX on BuildContext {
  KtList<TodoItemPrimitive> get formTodos => read<FormTodos>().value;
  set formTodos(KtList<TodoItemPrimitive> value) =>
      read<FormTodos>().value = value;
}
