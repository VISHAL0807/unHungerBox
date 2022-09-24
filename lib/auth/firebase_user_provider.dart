import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class UnHungerBoxFirebaseUser {
  UnHungerBoxFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

UnHungerBoxFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<UnHungerBoxFirebaseUser> unHungerBoxFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<UnHungerBoxFirebaseUser>(
        (user) => currentUser = UnHungerBoxFirebaseUser(user));
