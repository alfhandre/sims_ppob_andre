import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_andre/models/service_model.dart';
import 'package:sims_ppob_andre/models/user_model.dart';
import 'package:sims_ppob_andre/providers/auth_provider.dart';
import 'package:sims_ppob_andre/providers/balance_provider.dart';
import 'package:sims_ppob_andre/screen/pembayaran_screen.dart';
import 'package:sims_ppob_andre/theme.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';
import 'package:sims_ppob_andre/widget/card_saldo.dart';
import 'package:sims_ppob_andre/providers/service_provider.dart';
import 'package:sims_ppob_andre/providers/banner_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? saldo;
  bool isSaldoVisible = true;
  bool isLoading = true;
  UserData? user;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    setState(() {
      isLoading = true;
    });

    await Provider.of<BalanceProvider>(context, listen: false).fetchBalance();

    await Future.wait([
      Provider.of<ServiceProvider>(context, listen: false).fetchServices(),
      Provider.of<BannerProvider>(context, listen: false).fetchBanners(),
      Provider.of<AuthProvider>(context, listen: false).fetchAccount(),
    ]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        user = Provider.of<AuthProvider>(context, listen: false).user;
        saldo = Provider.of<BalanceProvider>(context, listen: false).balance;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8, horizontal: defaultMargin),
            child: Column(
              children: [
                header(),
                const SizedBox(height: 24),
                if (isLoading) loadingIndicator(),
                if (!isLoading) body(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loadingIndicator() {
    return Center(child: CircularProgressIndicator(color: primaryColor));
  }

  Widget header() {
    final profileImage = user?.profileImage ?? '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Image.asset('assets/pictures/Logo.png', width: 18),
            const SizedBox(width: 8),
            Roboto.bold(text: 'SIMS PPOB', fontSize: 14),
          ],
        ),
        CircleAvatar(
          radius: 14,
          backgroundImage: profileImage.isEmpty
              ? const AssetImage('assets/pictures/Profile Photo-1.png')
                  as ImageProvider<Object>
              : NetworkImage(profileImage),
        ),
      ],
    );
  }

  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Roboto.regular(text: 'Selamat datang,', fontSize: 18),
        greetUser(),
        const SizedBox(height: 24),
        cardSaldo(),
        const SizedBox(height: 16),
        menu(context),
        const SizedBox(height: 12),
        bannerSlide(context),
      ],
    );
  }

  Widget greetUser() {
    final firstName = user?.firstName ?? '';
    final lastName = user?.lastName ?? '';
    return Roboto.bold(text: '$firstName $lastName', fontSize: 20);
  }

  Widget cardSaldo() {
    return SaldoCard(
      viewSaldo: true,
      saldo: saldo ?? 0,
      isSaldoVisible: isSaldoVisible,
      onToggleVisibility: () {
        setState(() {
          isSaldoVisible = !isSaldoVisible;
        });
      },
    );
  }

  Widget menu(BuildContext context) {
    return Consumer<ServiceProvider>(builder: (context, provider, child) {
      final menuItems = provider.services;

      if (menuItems.isEmpty) {
        return const Center(child: Text('No services available'));
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: menuItems.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return iconMenu(item);
        },
      );
    });
  }

  Widget iconMenu(ServiceModel item) {
    List<String> words = item.serviceName.split(' ');

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PembayaranScreen(service: item, saldo: saldo),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(item.serviceIcon, width: 40, height: 40),
          const SizedBox(height: 4),
          Column(
            children: words.map<Widget>((word) {
              return Roboto.regular(text: word, fontSize: 8);
            }).toList(),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget bannerSlide(BuildContext context) {
    return Consumer<BannerProvider>(builder: (context, provider, child) {
      final bannerItems = provider.banners;

      if (bannerItems.isEmpty) {
        return const Center(child: Text('No banners available'));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Roboto.bold(text: 'Temukan Promo Terbaik', fontSize: 14),
          const SizedBox(height: 12),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: bannerItems.length,
              itemBuilder: (context, index) {
                final banner = bannerItems[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.network(
                    banner.bannerImage,
                    width: MediaQuery.of(context).size.width * 0.8,
                    fit: BoxFit.fitWidth,
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
