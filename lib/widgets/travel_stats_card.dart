import 'package:flutter/material.dart';

class TravelStatsCard extends StatelessWidget {
  final int visitedCount;
  final int wishlistCount;
  
  const TravelStatsCard({
    super.key,
    required this.visitedCount,
    required this.wishlistCount,
  });

  @override
  Widget build(BuildContext context) {
    const totalCountries = 195; // Approximate number of countries
    final visitedPercentage = (visitedCount / totalCountries * 100).round();
    
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Travel Progress',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    Icons.flag,
                    '$visitedCount',
                    'Countries Visited',
                    Colors.green,
                  ),
                ),
                Container(
                  width: 1,
                  height: 50,
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    Icons.favorite,
                    '$wishlistCount',
                    'On Wishlist',
                    Colors.orange,
                  ),
                ),
                Container(
                  width: 1,
                  height: 50,
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    Icons.public,
                    '$visitedPercentage%',
                    'World Explored',
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: visitedCount / totalCountries,
              backgroundColor: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$visitedCount of $totalCountries countries visited',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color iconColor,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 28,
          color: iconColor,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
} 