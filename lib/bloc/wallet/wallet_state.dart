
import 'package:crypto_fake/data/models/WalletLine.dart';

abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoaded extends WalletState {
  final List<WalletLine> lines;

  WalletLoaded(this.lines);
}