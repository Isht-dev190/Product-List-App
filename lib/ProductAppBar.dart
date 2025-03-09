import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';




 class ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SvgPicture.asset(
              'assets/icons/search_icon.svg', 
              width: 25,
              height: 25,
            )
          ],
      ),
    );
  }

   @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
