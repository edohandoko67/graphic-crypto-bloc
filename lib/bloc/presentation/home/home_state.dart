import 'package:equatable/equatable.dart';

class HomeState extends Equatable{
  final int currentIndex;
  final bool isLoading;
  final bool isVisible;

  const HomeState({
    this.currentIndex = 0,
    this.isLoading = false,
    this.isVisible = true,
  });

  HomeState copyWith({
    int? currentIndex,
    bool? isLoading,
    bool? isVisible,
  }) {
    return HomeState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object?> get props => [currentIndex, isLoading, isVisible];
}
