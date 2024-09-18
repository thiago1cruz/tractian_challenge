import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/constants/app_dimensions.dart';
import 'package:tractian_challenge/app/core/constants/app_font_size.dart';
import 'package:tractian_challenge/app/core/ui/themes/thme_ligth.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/controllers/assets_controller.dart';
import 'package:tractian_challenge/app/modules/assets/ui/widgets/button_radios.dart';

class Filter extends StatefulWidget {
  final AssetsController controller;
  const Filter({super.key, required this.controller});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  var id = -1;
  @override
  Widget build(BuildContext context) {
    final color = TractianColors.of(context);
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar Ativo ou Local',
              hintStyle: TextStyle(
                color: color.grey,
                height: 1.5,
                fontSize: AppFontSize.medium,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: color.grey,
              ),
              isDense: true,
           
            ),
            onChanged: (value) {},
          ),
        ),
        const SizedBox(height: AppDimensions.defaultPadding),
        Row(
          children: [
            ButtonRadios(
              id: 1,
              icon: Image.asset(
                'assets/icons/bolt.png',
                color: id == 1 ? color.white : null,
              ),
              text: 'Sensor de Energia',
              onChanged: (value) {
                setState(() {
                  id = value;
                });
              },
              value: id,
            ),
            const SizedBox(width: AppDimensions.smallPadding),
            ButtonRadios(
              id: 2,
              icon: Image.asset(
                'assets/icons/warn.png',
                color: id == 2 ? color.white : null,
              ),
              text: 'Crítico',
              onChanged: (value) {
                setState(() {
                  id = value;
                });
              },
              value: id,
            ),
          ],
        )
      ],
    );
  }
}
