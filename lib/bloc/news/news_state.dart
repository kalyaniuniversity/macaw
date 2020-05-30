import 'package:equatable/equatable.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class InitialNewsState extends NewsState {
  @override
  List<Object> get props => [];
}
