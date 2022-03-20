import 'package:firebase_auth/firebase_auth.dart';
import 'package:resocoder_ddd_course/domain/auth/user.dart' as user;
import 'package:resocoder_ddd_course/domain/core/value_objects.dart';

extension FirebaseUserDomainX on User {
  user.User toDomain() {
    return user.User(id: UniqueId.fromUniqueString(uid));
  }
}
