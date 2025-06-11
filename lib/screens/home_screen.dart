import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import '../providers/travel_provider.dart';
import '../widgets/travel_stats_card.dart';
import '../widgets/country_list_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TravelProvider>(
        builder: (context, travelProvider, child) {
          return CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar.large(
                title: const Text(
                  'Travel Map',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: Theme.of(context).colorScheme.surface,
                foregroundColor: Theme.of(context).colorScheme.onSurface,
                actions: [
                  IconButton(
                    onPressed: () => _showCountryListSheet(context, travelProvider),
                    icon: const Icon(Icons.list_alt),
                    tooltip: 'View Countries',
                  ),
                ],
              ),
              
              // Travel Statistics
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TravelStatsCard(
                    visitedCount: travelProvider.visitedCount,
                    wishlistCount: travelProvider.wishlistCount,
                  ),
                ),
              ),
              
              // World Map
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        color: Theme.of(context).colorScheme.surface,
                        child: SizedBox(
                          height: 400, // Fixed height for the map
                          child: InteractiveViewer(
                            minScale: 0.5,
                            maxScale: 75.0,
                            constrained: true,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.92,
                              child: SimpleMap(
                                instructions: SMapWorld.instructions,
                                defaultColor: Colors.grey.shade300,
                                colors: _createCountryColorsMap(travelProvider),
                                callback: (id, name, tapDetails) {
                                  _onCountryTapped(context, travelProvider, id, name);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ),
              ),
              
              // Legend
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Legend',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildLegendItem(
                            context,
                            Colors.green.shade400,
                            'Visited',
                          ),
                          const SizedBox(width: 20),
                          _buildLegendItem(
                            context,
                            Colors.orange.shade400,
                            'Wishlist',
                          ),
                          const SizedBox(width: 20),
                          _buildLegendItem(
                            context,
                            Colors.grey.shade300,
                            'Not visited',
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.zoom_in,
                            size: 16,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Pinch to zoom • Drag to pan • Tap countries to mark',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildLegendItem(BuildContext context, Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
  
  void _onCountryTapped(
    BuildContext context,
    TravelProvider travelProvider,
    String countryCode,
    String countryName,
  ) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              countryName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      travelProvider.toggleCountryVisited(countryCode, countryName);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      travelProvider.isCountryVisited(countryCode)
                          ? Icons.check_circle
                          : Icons.add_circle_outline,
                    ),
                    label: Text(
                      travelProvider.isCountryVisited(countryCode)
                          ? 'Remove from Visited'
                          : 'Mark as Visited',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      travelProvider.toggleCountryWishlist(countryCode, countryName);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      travelProvider.isCountryInWishlist(countryCode)
                          ? Icons.favorite
                          : Icons.favorite_outline,
                    ),
                    label: Text(
                      travelProvider.isCountryInWishlist(countryCode)
                          ? 'Remove from Wishlist'
                          : 'Add to Wishlist',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _showCountryListSheet(BuildContext context, TravelProvider travelProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => CountryListSheet(travelProvider: travelProvider),
    );
  }
  
  Map<String, Color> _createCountryColorsMap(TravelProvider travelProvider) {
    // Create a map with only visited and wishlist countries to avoid iterating over all countries
    final Map<String, Color> colorMap = {};
    
    // Add visited countries
    for (final country in travelProvider.visitedCountries) {
      colorMap[country.code] = Colors.green.shade400;
    }
    
    // Add wishlist countries
    for (final country in travelProvider.wishlistCountries) {
      colorMap[country.code] = Colors.orange.shade400;
    }
    
    return colorMap;
  }
} 