class User {
  const User({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.email = '',
    this.phone = '',
    this.bio = '',
    this.isOnline = false,
    this.lastSeen,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final String email;
  final String phone;
  final String bio;
  final bool isOnline;
  final DateTime? lastSeen;

  User copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    String? email,
    String? phone,
    String? bio,
    bool? isOnline,
    DateTime? lastSeen,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}
