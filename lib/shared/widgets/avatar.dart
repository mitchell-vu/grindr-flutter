import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    this.url,
    this.width,
    this.height,
    this.size = 16,
    this.radius = 4,
    this.rounded = false,
  });

  final double? width;
  final double? height;
  final String? url;
  final double size;
  final double radius;
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? size,
      height: height ?? size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(rounded ? size / 2 : radius),
        child: url != null && url!.isNotEmpty
            ? Image.network(url!, fit: BoxFit.cover)
            : SvgPicture.asset(
                'assets/svgs/blank-avatar.svg',
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
