
import 'package:crypto_fake/bloc/presentation/home/home_bloc.dart';
import 'package:crypto_fake/bloc/presentation/home/home_event.dart';
import 'package:crypto_fake/bloc/presentation/home/home_state.dart';
import 'package:crypto_fake/view/ShareView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FragmentHome extends StatefulWidget {
  const FragmentHome({super.key});

  @override
  State<FragmentHome> createState() => _FragmentHomeState();
}

class _FragmentHomeState extends State<FragmentHome> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyBtcData = [
      {'id': 'btc', 'name': 'Bitcoin', 'symbol': 'BTC', 'harga': '1.957.000.000', 'icon': 'assets/icons/btc.png'},
      {'id': 'eth', 'name': 'Ethereum', 'symbol': 'ETH', 'harga': '49.769.000', 'icon': 'assets/icons/eth.png'},
      {'id': 'sol', 'name': 'Solana', 'symbol': 'SOL', 'harga': '2.656.000', 'icon': 'assets/icons/solana.png'},
      {'id': 'xrp', 'name': 'XRP', 'symbol': 'Ripple', 'harga': '50.213', 'icon': 'assets/icons/xrp.png'},
      {'id': 'doge', 'name': 'Doge', 'symbol': 'Doge Coin', 'harga': '3.400', 'icon': 'assets/icons/doge.png'},
    ];

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 15,
                    left: 270,
                    child: SizedBox(
                      width: 115,
                      height: 35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        onPressed: () {
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add, size: 16, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              'Deposit',
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15,),
                      Text('Total Value', style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                      ),),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          if (state.isVisible)
                            Text(
                              'Rp 250.457.890',
                              style: GoogleFonts.poppins(),
                            )
                          else
                            Text(
                              'Rp ••••••••••',
                              style: GoogleFonts.poppins(),
                            ),
                          IconButton(
                            onPressed: () {
                              context.read<HomeBloc>().add(IsVisible());
                            },
                            icon: Icon(
                              state.isVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25,),
                      Text('Whatchlist', style: GoogleFonts.poppins(
                        fontSize: 20,
                      ),),
                      const SizedBox(height: 15,),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: dummyBtcData.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = dummyBtcData[index];

                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => const ChartScreen()));
                              },
                              child: Row(
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
                                    'Rp ${item['harga']}',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

