import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeChartWidget extends StatelessWidget {
  const HomeChartWidget({
    super.key,
    required this.postsCount,
    required this.adsCount,
  });

  final int postsCount;
  final int adsCount;

  @override
  Widget build(BuildContext context) {
    final total = postsCount + adsCount;
    final postsValue = postsCount == 0 && adsCount == 0 ? 1.0 : postsCount.toDouble();
    final adsValue = postsCount == 0 && adsCount == 0 ? 1.0 : adsCount.toDouble();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: AppColors.border, blurRadius: 7)],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: AppColors.primary,
                        radius: 22,
                        value: postsValue,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        color: AppColors.secondary,
                        radius: 22,
                        value: adsValue,
                        showTitle: false,
                      ),
                    ],
                    sectionsSpace: 1,
                    centerSpaceRadius: 50,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$total',
                      style: const TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    const Text(
                      'منشور',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(thickness: .2, color: AppColors.grey),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _LegendItem(
                color: AppColors.primary,
                label: 'منشورات عادية',
              ),
              _LegendItem(
                color: AppColors.secondary,
                label: 'منشورات خارجية',
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}
