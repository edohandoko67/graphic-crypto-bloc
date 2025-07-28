import 'package:crypto_fake/bloc/wallet/wallet_bloc.dart';
import 'package:crypto_fake/bloc/wallet/wallet_event.dart';
import 'package:crypto_fake/bloc/wallet/wallet_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FragmentWallet extends StatelessWidget {
  const FragmentWallet({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyBtcData = [
      {'id': 'btc', 'name': 'Bitcoin', 'symbol': 'BTC', 'harga': '0.42', 'rp': '245.241.500', 'icon': 'assets/icons/btc.png'},
      {'id': 'xrp', 'name': 'XRP', 'symbol': 'Ripple', 'harga': '100', 'rp': '4.580.000', 'icon': 'assets/icons/xrp.png'},
    ];

    return BlocProvider(
      create: (_) => WalletBloc()..add(LoadWalletData()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Total Assets")),
        body: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            if (state is WalletInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WalletLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: LineChart(
                          LineChartData(
                            lineBarsData: state.lines.map(
                                  (line) => LineChartBarData(
                                isCurved: true,
                                color: Color(line.colorCode),
                                barWidth: 3,
                                spots: line.spots,
                                dotData: FlDotData(show: true),
                              ),
                            ).toList(),
                            titlesData: const FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true),
                              ),
                            ),
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(show: true),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text("Asset", style: Theme.of(context).textTheme.titleMedium),
                      SizedBox(
                        height: 400,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: dummyBtcData.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = dummyBtcData[index];

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset(item['icon']!, fit: BoxFit.contain),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name']!,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          item['symbol']!,
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  '${item['harga']}',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Rp ${item['rp']}',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text('Error loading data'));
            }
          },
        ),
      ),
    );
  }
}
