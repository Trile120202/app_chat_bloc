import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      // TODO: Implement actual login logic with your backend
      await Future.delayed(
          const Duration(seconds: 2)); // Simulate network delay

      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError('Email and password cannot be empty'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      // TODO: Implement actual register logic with your backend
      await Future.delayed(const Duration(seconds: 2));

      if (event.email.isNotEmpty &&
          event.password.isNotEmpty &&
          event.username.isNotEmpty) {
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError('All fields are required'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthUnauthenticated());
  }
}
