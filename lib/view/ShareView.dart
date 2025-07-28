
import 'package:crypto_fake/bloc/presentation/chart/chandle_data_bloc.dart';
import 'package:crypto_fake/bloc/presentation/chart/chart_event.dart';
import 'package:crypto_fake/bloc/presentation/chart/chart_state.dart';
import 'package:crypto_fake/bloc/presentation/datacust/datacust_bloc.dart';
import 'package:crypto_fake/bloc/presentation/datacust/datacust_event.dart';
import 'package:crypto_fake/bloc/presentation/datacust/datacust_state.dart';
import 'package:crypto_fake/bloc/theme/theme_bloc.dart';
import 'package:crypto_fake/bloc/theme/theme_event.dart';
import 'package:crypto_fake/bloc/theme/theme_state.dart';
import 'package:crypto_fake/widgets/MAChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:intl/intl.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyBtcData = [
      {"harga": 97122, "jumlah": 0.0012},
      {"harga": 98122, "jumlah": 0.0045},
      {"harga": 101000, "jumlah": 0.0021},
      {"harga": 102350, "jumlah": 0.0050},
      {"harga": 99890, "jumlah": 0.0034},
      {"harga": 101230, "jumlah": 0.0067},
      {"harga": 101000, "jumlah": 0.0021},
      {"harga": 102350, "jumlah": 0.0050},
      {"harga": 99890, "jumlah": 0.0034},
    ];

    final List<String> orderTypes = ['Limit Order', 'Market Order'];

    return BlocBuilder<ChartBloc, ChartState>(
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Bitcoin (BTCUSD) \n101000"),
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
            child: state.candles.length < 3
                ? const Center(
              child: Text("Data candle kurang dari 3."),
            )
                : SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 470,
                          bottom: 0,
                          left: 0,
                          right: 170,
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
                                    Text('(BTC)'),
                                  ],
                                ),
                                Expanded(
                                  child: BlocConsumer<DataCustBloc, DataCustState>(
                                    listener: (context, state) {
                                      if (state.hasError && !state.isLoading) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(state.error!),
                                            duration: const Duration(seconds: 3),
                                            action: SnackBarAction(
                                              label: 'Retry',
                                              onPressed: () {
                                                context.read<DataCustBloc>().add(LoadDataCust());
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state.isLoading && state.isEmpty) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (state.hasError && state.isEmpty) {
                                        return Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.error_outline, size: 48, color: Colors.red),
                                              const SizedBox(height: 16),
                                              Text(
                                                'Failed to load data',
                                                style: Theme.of(context).textTheme.titleMedium,
                                              ),
                                              const SizedBox(height: 8),
                                              ElevatedButton(
                                                onPressed: () => context.read<DataCustBloc>().add(LoadDataCust()),
                                                child: const Text('Retry'),
                                              ),
                                            ],
                                          ),
                                        );
                                      }

                                      if (state.isEmpty) {
                                        return Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.info_outline, size: 48, color: Colors.blue),
                                              const SizedBox(height: 16),
                                              Text(
                                                'No customer data available',
                                                style: Theme.of(context).textTheme.titleMedium,
                                              ),
                                              const SizedBox(height: 8),
                                              ElevatedButton(
                                                onPressed: () => context.read<DataCustBloc>().add(LoadDataCust()),
                                                child: const Text('Load Data'),
                                              ),
                                            ],
                                          ),
                                        );
                                      }

                                      return RefreshIndicator(
                                        onRefresh: () async {
                                          context.read<DataCustBloc>().add(RefreshDataCust());
                                        },
                                        child: ListView.separated(
                                          padding: const EdgeInsets.all(8),
                                          itemCount: state.customers.length,
                                          separatorBuilder: (context, index) => const Divider(height: 1),
                                          itemBuilder: (context, index) {
                                            final customer = state.customers[index];
                                            //debugPrint('Customer $index: ${customer.name} - ${customer.nBrutto}');
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                    customer.cKdC ?? 'No Name',
                                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${NumberFormat('#,##0').format(customer.nBrutto ?? 0)}',
                                                    style: Theme.of(context).textTheme.bodyMedium,
                                                  ),
                                              ],
                                            );
                                          },
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
                                candles: state.candles,
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
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                            //   child: BlocBuilder<OrderBloc, OrderState>(
                            //     builder: (context, state) {
                            //       return SizedBox(
                            //         width: double.infinity, // membuat dropdown selebar mungkin
                            //         child: DropdownButton<String>(
                            //           value: state.selectedOrderType,
                            //           isExpanded: true, // supaya isi dropdown tidak terpotong
                            //           items: orderTypes.map((String type) {
                            //             return DropdownMenuItem<String>(
                            //               value: type,
                            //               child: Text(type),
                            //             );
                            //           }).toList(),
                            //           onChanged: (String? newValue) {
                            //             if (newValue != null) {
                            //               context.read<OrderBloc>().add(SelectOrderType(newValue));
                            //             }
                            //           },
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),

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

