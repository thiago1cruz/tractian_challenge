import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/constants/app_dimensions.dart';
import 'package:tractian_challenge/app/core/ui/themes/thme_ligth.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/controllers/assets_controller.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/states/companie_state.dart';
import 'package:tractian_challenge/app/modules/assets/ui/widgets/company_card.dart';

class ChooseCompanyPage extends StatefulWidget {
  final AssetsController controller;
  const ChooseCompanyPage({super.key, required this.controller});

  @override
  State<ChooseCompanyPage> createState() => _ChooseCompanyPageState();
}

class _ChooseCompanyPageState extends State<ChooseCompanyPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.getCompanies();
    widget.controller.addListener(updateState);
  }

  @override
  void dispose() {
    widget.controller.removeListener(updateState);
    super.dispose();
  }

  void updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final color = TractianColors.of(context);
     final states = widget.controller.companiesState;
    // final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/img/logo.png',
              color: color.white, width: 200),
        ),
        body: switch (states) {
          InitialCompaniesState() => const SizedBox(),
          LoadingCompaniesState() =>
            const Center(child: CircularProgressIndicator()),
          ErrorCompaniesState(exception: final e) =>
            Center(child: Text(e.message)),
          SuccessCompaniesState(data: final companies) => ListView.builder(
              itemCount: companies.length,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.largePadding,
                  vertical: AppDimensions.extraLargePadding),
              itemBuilder: (context, index) {
                final company = companies[index];
                return Column(
                  children: [
                    CompanyCard(company: company),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                );
              },
            ),
        });
  }
}
