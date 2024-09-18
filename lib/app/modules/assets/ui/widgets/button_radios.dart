import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/constants/app_dimensions.dart';
import 'package:tractian_challenge/app/core/ui/themes/thme_ligth.dart';

class ButtonRadios extends StatefulWidget {
  final int id;
  final Widget icon;
  final String text;
  final Color? inativeColor;
  final Color? activeColor;
  final Function(int) onChanged;
  final int? value;
  
  const ButtonRadios({
    super.key,
    required this.icon,
    required this.text,
    this.inativeColor,
    this.activeColor,
    required this.onChanged,
    required this.id,
    this.value,
  });

  @override
  State<ButtonRadios> createState() => _ButtonRadiosState();
}

class _ButtonRadiosState extends State<ButtonRadios> {
  bool active = false;

  @override
  void initState() {
    super.initState();
    if (widget.value == widget.id) {
      active = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null && widget.value == widget.id) {
      active = true;
    } else {
      active = false;
    }

    final textTheme = Theme.of(context).textTheme;
    final color = TractianColors.of(context);
    return InkWell(
      onTap: () {
        setState(() {
          if (active) {
            active = false;
            widget.onChanged(-1);
          } else {
            active = true;
            widget.onChanged(widget.id);
          }
        });
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: active ? widget.activeColor ?? color.secondary : widget.inativeColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.smallBorderRadius),
          border: active ? const Border() : Border.all(color: color.grey, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.defaultPadding,
              vertical: AppDimensions.mediumSmallPadding),
          child: Row(
            children: [
              widget.icon,
              const SizedBox(width: AppDimensions.smallPadding),
              Text(
                widget.text,
                style: textTheme.titleMedium!.copyWith(
                  color: active ? color.white : color.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
