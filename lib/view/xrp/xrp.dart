
import 'package:crypto_fake/bloc/presentation/chart/chandle_data_bloc.dart';
import 'package:crypto_fake/bloc/presentation/chart/chart_event.dart';
import 'package:crypto_fake/bloc/presentation/chart/chart_state.dart';
import 'package:crypto_fake/bloc/theme/theme_bloc.dart';
import 'package:crypto_fake/bloc/theme/theme_event.dart';
import 'package:crypto_fake/bloc/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_chart/interactive_chart.dart';

class XRP extends StatelessWidget {
  const XRP({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyXrpData = [
      {"harga": 2.78, "jumlah": 202.2},
      {"harga": 2.56, "jumlah": 2.2},
      {"harga": 2.89, "jumlah": 40.7},
      {"harga": 2.57, "jumlah": 500.78},
      {"harga": 2.71, "jumlah": 150},

    ];
    return BlocBuilder<ChartBloc, ChartState>(
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("XRP (RippleUSD) \n2.78"),
            actions: [
              IconButton(
                icon: Icon(
                  context.watch<ThemeBloc>().state.theme == AppTheme.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onPressed: () {
                  context.read<ThemeBloc>().add(ToggleTheme());
                },
              ),
              IconButton(
                icon: Icon(
                  state.showAverage
                      ? Icons.show_chart
                      : Icons.bar_chart_outlined,
                ),
                onPressed: () {
                  context.read<ChartBloc>().add(ToggleAverage());
                },
              ),
            ],
          ),
          body: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: state.candlesXRP.length < 3
                ? const Center(
              child: Text("Data candle kurang dari 3."),
            )
                : SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 415,
                      bottom: 0,
                      left: 250,
                      right: 10,
                      child: Container(
                        color: Colors.black12,
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Harga'),
                                Text('Jumlah'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('(USD)'),
                                Text('(XRP)'),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: dummyXrpData.length,
                                itemBuilder: (context, index) {
                                  final data = dummyXrpData[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data['harga'].toString(),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          data['jumlah'].toStringAsFixed(4),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 400,
                          child: InteractiveChart(
                            candles: state.candlesXRP,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            SizedBox(
                              width: 115,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text('Beli'),
                              ),
                            ),
                            SizedBox(
                              width: 115,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text('Jual'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
