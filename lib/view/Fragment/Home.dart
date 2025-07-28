import 'package:crypto_fake/bloc/presentation/home/home_bloc.dart';
import 'package:crypto_fake/bloc/presentation/home/home_event.dart';
import 'package:crypto_fake/bloc/presentation/home/home_state.dart';
import 'package:crypto_fake/view/Fragment/FragmentHome.dart';
import 'package:crypto_fake/view/Fragment/FragmentWallet.dart';
import 'package:crypto_fake/view/ShareView.dart';
import 'package:crypto_fake/view/xrp/xrp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  final controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(LoadHomeData()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: PersistentTabView(
                context,
                controller: controller,
                screens: [
                  RefreshIndicator(
                    onRefresh: () async {
                      context.read<HomeBloc>().add(LoadHomeData());
                    },
                    child: const FragmentHome(),
                  ),
                  const ChartScreen(),
                  RefreshIndicator(
                    onRefresh: () async {
                      context.read<HomeBloc>().add(LoadHomeData());
                    },
                    child: const XRP(),
                  ),
                  const XRP(),
                  const FragmentWallet(),
                ],
                items: [
                  PersistentBottomNavBarItem(
                    icon: state.isLoading
                        ? const CircularProgressIndicator(color: Colors.green)
                        : const Icon(Icons.home),
                    activeColorPrimary: Colors.green,
                    inactiveIcon: const Icon(Icons.home, color: Colors.black),
                  ),
                  PersistentBottomNavBarItem(
                      icon: state.isLoading
                        ? const CircularProgressIndicator(color: Colors.green,)
                        : const Icon(Icons.bar_chart),
                    inactiveIcon: const Icon(Icons.bar_chart, color: Colors.grey,)
                  ),
                  PersistentBottomNavBarItem(
                      icon: state.isLoading
                        ? const CircularProgressIndicator(color: Colors.green,)
                        : const Icon(Icons.transfer_within_a_station_rounded, color: Colors.white,),
                    inactiveIcon: const Icon(Icons.transfer_within_a_station_rounded, color: Colors.grey,)
                  ),
                  PersistentBottomNavBarItem(
                      icon: state.isLoading
                        ? const CircularProgressIndicator(color: Colors.green,)
                        : const Icon(Icons.card_membership,),
                    inactiveIcon: const Icon(Icons.card_membership, color: Colors.grey,),
                  ),
                  PersistentBottomNavBarItem(
                    icon: state.isLoading
                        ? const CircularProgressIndicator(color: Colors.green)
                        : const Icon(Icons.wallet),
                    inactiveIcon: const Icon(Icons.wallet, color: Colors.grey),
                  ),
                ],
                onItemSelected: (index) {
                  context.read<HomeBloc>().add(LoadHomeData());

                  if (index == 1) {
                    context.read<HomeBloc>().add(LoadHomeData());
                  } else if (index == 4) {
                    context.read<HomeBloc>().add(RefreshDataMe());
                  } else if (index == 2) {
                    context.read<HomeBloc>().add(LoadHomeData());
                  }
                },
                navBarStyle: NavBarStyle.style15,
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAbsentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const Text('Isi Modal Absen Di Sini'),
    );
  }
}
