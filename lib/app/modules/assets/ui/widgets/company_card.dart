import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/constants/app_dimensions.dart';
import 'package:tractian_challenge/app/core/ui/themes/thme_ligth.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/entities/company_entity.dart';

class CompanyCard extends StatelessWidget {
  final Company company;
  const CompanyCard({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final color = TractianColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Material(child: InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('./assets', arguments: company.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding, vertical: AppDimensions.defaultPadding),
        margin: const EdgeInsets.symmetric(vertical: AppDimensions.largeMargin),
        decoration: BoxDecoration(
          color: color.secondary,
          borderRadius: BorderRadius.circular(AppDimensions.smallBorderRadius),                 
        ),
        child: Row(
          children: [
            Image.asset('assets/icons/icon_card.png', width: 50,),
            const SizedBox(width: 5,),
            Text(company.name, style: textTheme.bodyMedium!.copyWith(color: color.white),),
          ],
        ),
      ),
    )
    );
  }
}