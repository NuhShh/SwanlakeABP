import 'package:rxdart/rxdart.dart';

import 'custom_auth_manager.dart';

class SwanlakeAuthUser {
  SwanlakeAuthUser({required this.loggedIn, this.uid});

  bool loggedIn;
  String? uid;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<SwanlakeAuthUser> swanlakeAuthUserSubject =
    BehaviorSubject.seeded(SwanlakeAuthUser(loggedIn: false));
Stream<SwanlakeAuthUser> swanlakeAuthUserStream() => swanlakeAuthUserSubject
    .asBroadcastStream()
    .map((user) => currentUser = user);
