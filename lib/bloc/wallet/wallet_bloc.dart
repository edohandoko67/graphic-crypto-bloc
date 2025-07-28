import 'dart:math';

import 'package:crypto_fake/bloc/wallet/wallet_event.dart';
import 'package:crypto_fake/bloc/wallet/wallet_state.dart';
import 'package:crypto_fake/data/models/WalletLine.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<LoadWalletData>((event, emit) {
      final random = Random();
      double y = 1.0;
      final List<WalletLine> dummyLines = [
        WalletLine(
          symbol: 'BTC',
          colorCode: 0xFFFF9900,
          spots: List.generate(7, (i) {
            double y = 1.0 + i * 0.3 + Random().nextDouble(); // Naik terus
            return FlSpot(i.toDouble(), y);
          }),
        ),
        // WalletLine(
        //   symbol: 'ETH',
        //   colorCode: 0xFF3366FF,
        //   spots: List.generate(6, (i) => FlSpot(i.toDouble(), 0.5 + Random().nextDouble())),
        // ),
        // WalletLine(
        //   symbol: 'USDT',
        //   colorCode: 0xFF66BB6A,
        //   spots: List.generate(6, (i) => FlSpot(i.toDouble(), 1.0 + Random().nextDouble() * 0.1)),
        // ),
      ];

      emit(WalletLoaded(dummyLines));
    });
  }
}