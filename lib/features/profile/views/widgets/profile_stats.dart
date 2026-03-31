import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttr/features/auth/models/user_model.dart';

class QuickStatsStrip extends StatelessWidget {
  final UserModel user;

  const QuickStatsStrip({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return _buildQuickStatsStrip();
  }

  Widget _buildQuickStatsStrip() {
    final bodyStats = [
      user.height,
      user.weight,
      user.bodyType,
    ].whereType<String>().toList();
    final items = <Widget>[];

    if (user.showPosition == true && user.position != null) {
      items.add(
        StatItem(
          icon: Icons.swap_vert,
          text: user.position!,
          iconColor: Colors.white,
          iconSize: 16,
          textStyle: const TextStyle(color: Colors.white, fontSize: 14),
          spacing: 4,
        ),
      );
    }

    if (bodyStats.isNotEmpty) {
      items.add(
        BodyStatsRow(
          icon: Icons.straighten,
          stats: bodyStats,
          iconColor: Colors.grey[400]!,
          iconSize: 16,
          textStyle: const TextStyle(color: Colors.white, fontSize: 14),
          spacing: 8,
          dividerHeight: 12,
        ),
      );
    }

    if (items.isEmpty) return SizedBox.shrink();
    return Row(spacing: 12, children: items);
  }
}

class DetailedStatsSection extends StatelessWidget {
  final UserModel user;

  const DetailedStatsSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return _buildDetailedStats();
  }

  Widget _buildDetailedStats() {
    final bodyStats = [
      user.height,
      user.weight,
      user.bodyType,
    ].whereType<String>().toList();
    final rows = <Widget>[];

    final detailedTextStyle = GoogleFonts.ibmPlexSans(
      color: Colors.white,
      fontSize: 16,
      fontWeight: .w500,
    );

    if (bodyStats.isNotEmpty) {
      rows.add(
        BodyStatsRow(
          icon: Icons.straighten,
          stats: bodyStats,
          iconColor: Colors.white,
          iconSize: 20,
          textStyle: detailedTextStyle,
          spacing: 12,
          dividerHeight: 14,
        ),
      );
    }

    if (user.showPosition == true && user.position != null) {
      rows.add(
        StatItem(
          icon: Icons.swap_vert,
          text: user.position!,
          iconColor: Colors.white,
          iconSize: 20,
          textStyle: detailedTextStyle,
          spacing: 12,
        ),
      );
    }

    if (user.ethnicity != null) {
      rows.add(
        StatItem(
          icon: Icons.public_rounded,
          text: user.ethnicity!,
          iconColor: Colors.white,
          iconSize: 20,
          textStyle: detailedTextStyle,
          spacing: 12,
        ),
      );
    }

    if (user.relationshipStatus != null) {
      rows.add(
        StatItem(
          icon: Icons.people_outline,
          text: user.relationshipStatus!,
          iconColor: Colors.white,
          iconSize: 20,
          textStyle: detailedTextStyle,
          spacing: 12,
        ),
      );
    }

    if (rows.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: .start,
      spacing: 16,
      children: [
        const Text(
          "STATS",
          style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: .bold),
        ),
        ...rows,
      ],
    );
  }
}

class StatItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final double iconSize;
  final TextStyle textStyle;
  final double spacing;

  const StatItem({
    super.key,
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.iconSize,
    required this.textStyle,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: spacing,
      children: [
        Icon(icon, color: iconColor, size: iconSize),
        Text(text, style: textStyle),
      ],
    );
  }
}

class BodyStatsRow extends StatelessWidget {
  final IconData icon;
  final List<String> stats;
  final Color iconColor;
  final double iconSize;
  final TextStyle textStyle;
  final double spacing;
  final double dividerHeight;

  const BodyStatsRow({
    super.key,
    required this.icon,
    required this.stats,
    required this.iconColor,
    required this.iconSize,
    required this.textStyle,
    required this.spacing,
    required this.dividerHeight,
  });

  @override
  Widget build(BuildContext context) {
    final statWidgets = <Widget>[];
    for (int i = 0; i < stats.length; i++) {
      statWidgets.add(Text(stats[i], style: textStyle));
      if (i < stats.length - 1) {
        statWidgets.add(
          SizedBox(
            height: dividerHeight,
            child: VerticalDivider(
              color: Colors.grey[700],
              thickness: 1,
              width: 1,
            ),
          ),
        );
      }
    }

    return Row(
      spacing: spacing,
      crossAxisAlignment: .center,
      children: [
        Icon(icon, color: iconColor, size: iconSize),
        Row(
          spacing: spacing,
          crossAxisAlignment: .center,
          children: statWidgets,
        ),
      ],
    );
  }
}
