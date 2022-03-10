class Auth {
  const Auth({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });

  /// The current user's id.
  final String uid;

  /// The current user's email address.
  final String? email;

  /// The current user's displayName (display displayName).
  final String? displayName;

  /// Url for the current user's photoURL.
  final String? photoURL;
}
