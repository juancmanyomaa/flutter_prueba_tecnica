import 'package:flutter/material.dart';
import 'package:flutter_project/shared/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../shared/icons.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onSearch;

  const SearchBarWidget({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  onChanged: onSearch,
                  decoration: InputDecoration(
                    filled: true,
                    hintStyle: const TextStyle(color: AppColors.background, fontSize: 14),
                    fillColor: AppColors.onSecondary,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Buscar productos...",
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const SizedBox(width: 8),
              IconBtnWithCounter(
                svgSrc: bellIcon,
                numOfitem: 3,
                press: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    super.key,
    required this.svgSrc,
    this.numOfitem = 0,
    required this.press,
  });
  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF979797),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.string(svgSrc),
          ),
          if (numOfitem != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: const Color(0x00ffef53),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
