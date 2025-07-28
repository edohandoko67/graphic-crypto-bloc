abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final Map<String, dynamic> loginData;

  LoginSubmitted(this.loginData);
}