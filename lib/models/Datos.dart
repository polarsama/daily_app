// Modelo de Usuario para Registro
class UserRegistration {
  final String name;
  final String email;
  final String password;
  final DateTime? registrationDate;

  UserRegistration({
    required this.name,
    required this.email,
    required this.password,
    this.registrationDate
  });

  // Convertir a Map para almacenamiento en base de datos
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password, 
      'registrationDate': registrationDate?.toIso8601String() ?? DateTime.now().toIso8601String()
    };
  }

  // Crear desde un Map (útil para recuperar de base de datos)
  factory UserRegistration.fromMap(Map<String, dynamic> map) {
    return UserRegistration(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      registrationDate: map['registrationDate'] != null 
        ? DateTime.parse(map['registrationDate']) 
        : null
    );
  }
}

// Modelo de Credenciales de Inicio de Sesión
class UserLogin {
  final String email;
  final String password;

  UserLogin({
    required this.email,
    required this.password
  });

  // Convertir a Map para validación
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password
    };
  }
}

// Modelo de Entrada de Diario
class DiaryEntry {
  final String? id; 
  final String userId; 
  final DateTime date;
  final String title;
  final String content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DiaryEntry({
    this.id,
    required this.userId,
    required this.date,
    required this.title,
    required this.content,
    this.createdAt,
    this.updatedAt
  });

  // Convertir a Map para almacenamiento en base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'title': title,
      'content': content,
      'createdAt': createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String()
    };
  }

  // Crear desde un Map (útil para recuperar de base de datos)
  factory DiaryEntry.fromMap(Map<String, dynamic> map) {
    return DiaryEntry(
      id: map['id'],
      userId: map['userId'],
      date: DateTime.parse(map['date']),
      title: map['title'],
      content: map['content'],
      createdAt: map['createdAt'] != null 
        ? DateTime.parse(map['createdAt']) 
        : null,
      updatedAt: map['updatedAt'] != null 
        ? DateTime.parse(map['updatedAt']) 
        : null
    );
  }

  // Método para crear una copia modificada
  DiaryEntry copyWith({
    String? id,
    String? userId,
    DateTime? date,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt
  }) {
    return DiaryEntry(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt
    );
  }
}

// Modelo de Perfil de Usuario
class UserProfile {
  final String userId;
  final String name;
  final String email;
  final String? profileImageUrl;
  final DateTime? lastLogin;

  UserProfile({
    required this.userId,
    required this.name,
    required this.email,
    this.profileImageUrl,
    this.lastLogin
  });

  // Convertir a Map para almacenamiento en base de datos
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'lastLogin': lastLogin?.toIso8601String()
    };
  }

  // Crear desde un Map (útil para recuperar de base de datos)
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userId: map['userId'],
      name: map['name'],
      email: map['email'],
      profileImageUrl: map['profileImageUrl'],
      lastLogin: map['lastLogin'] != null 
        ? DateTime.parse(map['lastLogin']) 
        : null
    );
  }
}

// Enumeración para estado de autenticación
enum AuthStatus {
  unAuthenticated,
  authenticating,
  authenticated,
  error
}