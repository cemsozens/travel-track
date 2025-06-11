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
    
    // Responsive design based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallDevice = screenWidth < 400;
    final isMediumDevice = screenWidth >= 400 && screenWidth < 600;
    
    // Responsive padding - more generous on larger screens
    final cardPadding = isSmallDevice ? 8.0 : (isMediumDevice ? 16.0 : 24.0);
    
    // Responsive spacing - more generous on larger screens
    final titleSpacing = isSmallDevice ? 6.0 : (isMediumDevice ? 12.0 : 16.0);
    final progressSpacing = isSmallDevice ? 6.0 : (isMediumDevice ? 10.0 : 14.0);
    final bottomSpacing = isSmallDevice ? 3.0 : (isMediumDevice ? 6.0 : 8.0);
    
    // Responsive text styles
    final titleStyle = isSmallDevice 
        ? Theme.of(context).textTheme.titleSmall
        : (isMediumDevice ? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.titleLarge);
    
    final bottomTextSize = isSmallDevice ? 11.0 : (isMediumDevice ? 12.0 : 14.0);
    
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          children: [
            Text(
              'Travel Progress',
              style: titleStyle?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            SizedBox(height: titleSpacing),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    Icons.flag,
                    '$visitedCount',
                    'Countries Visited',
                    Colors.green,
                    isSmallDevice,
                    isMediumDevice,
                  ),
                ),
                Container(
                  width: 1,
                  height: isSmallDevice ? 25.0 : (isMediumDevice ? 45.0 : 60.0),
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    Icons.favorite,
                    '$wishlistCount',
                    'On Wishlist',
                    Colors.orange,
                    isSmallDevice,
                    isMediumDevice,
                  ),
                ),
                Container(
                  width: 1,
                  height: isSmallDevice ? 25.0 : (isMediumDevice ? 45.0 : 60.0),
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    Icons.public,
                    '$visitedPercentage%',
                    'World Explored',
                    Theme.of(context).colorScheme.primary,
                    isSmallDevice,
                    isMediumDevice,
                  ),
                ),
              ],
            ),
            SizedBox(height: progressSpacing),
            LinearProgressIndicator(
              value: visitedCount / totalCountries,
              backgroundColor: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: bottomSpacing),
            Text(
              '$visitedCount of $totalCountries countries visited',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: bottomTextSize,
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
    bool isSmallDevice,
    bool isMediumDevice,
  ) {
    // Responsive icon size - larger on big screens
    final iconSize = isSmallDevice ? 16.0 : (isMediumDevice ? 24.0 : 32.0);
    
    // Responsive spacing - more generous on larger screens
    final iconSpacing = isSmallDevice ? 2.0 : (isMediumDevice ? 6.0 : 8.0);
    
    // Responsive text styles
    final valueStyle = isSmallDevice 
        ? Theme.of(context).textTheme.titleMedium
        : (isMediumDevice ? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.headlineSmall);
    
    final labelSize = isSmallDevice ? 10.0 : (isMediumDevice ? 12.0 : 14.0);
    
    return Column(
      children: [
        Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
        SizedBox(height: iconSpacing),
        Text(
          value,
          style: valueStyle?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: labelSize,
            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
} 