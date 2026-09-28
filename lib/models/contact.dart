import 'user.dart';

class Contact {
  const Contact({
    required this.user,
    this.isFavorite = false,
  });

  final User user;
  final bool isFavorite;
}
