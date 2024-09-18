import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/constants/app_dimensions.dart';
import 'package:tractian_challenge/app/core/constants/app_font_size.dart';
import 'package:tractian_challenge/app/core/ui/themes/thme_ligth.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/controllers/tree_node_controller.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/entities/asset_entity.dart';
import 'package:tractian_challenge/app/modules/assets/ui/widgets/button_radios.dart';

class Filter extends StatefulWidget {
  final TreeNodeController? controller;
  const Filter({super.key, required this.controller});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  Timer? _debounce;
  var id = -1;

  @override
  void dispose() {
    _debounce?.cancel();
    widget.controller?.dispose();
    super.dispose();
  }

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
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 700), () async {
                if (widget.controller != null) {
                  widget.controller!
                      .filterAssetsByName(value)
                      .then((filteredAssets) async {
                    if (filteredAssets.isNotEmpty) {
                      widget.controller!
                          .loadChildrenForFilteredAssets(filteredAssets);
                    }else{
                      widget.controller!.loadTreeData();
                    }
                  });
                }
              });
            },
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
              onChanged: (value) async {
                setState(() {
                  id = value;
                });
                if (1 == id && widget.controller != null) {
                  List<AssetEntity> filteredAssets = await widget.controller!
                      .filterAssetsBySensorType(name: 'energy');
                  widget.controller!
                      .loadChildrenForFilteredAssets(filteredAssets);
                }else if(id == -1 && widget.controller != null){
                  widget.controller!.loadTreeData();
                }
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
              onChanged: (value) async {
                setState(() {
                  id = value;
                });

                if (2 == id && widget.controller != null) {
                  List<AssetEntity> filteredAssets = await widget.controller!
                      .filterAssetsByStatus(name: 'alert');
                  widget.controller!
                      .loadChildrenForFilteredAssets(filteredAssets);
                }else if(id == -1 && widget.controller != null){
                  widget.controller!.loadTreeData();
                }
              },
              value: id,
            ),
          ],
        )
      ],
    );
  }
}
