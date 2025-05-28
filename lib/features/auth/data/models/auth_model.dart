import 'package:equatable/equatable.dart';
import '../../auth_library.dart';

class AuthModel extends Equatable {
  final String url;
  final String username;
  final String password;

  const AuthModel({
    required this.url,
    required this.username,
    required this.password, 
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }


  factory AuthModel.fromEntity(AuthEntity entity) {
    return AuthModel(
      url: entity.url,
      username: entity.username,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props => [
    url,
    username,
    password,
  ];
}
