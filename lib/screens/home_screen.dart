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
  // Country code to country name mapping
  static const Map<String, String> _countryNames = {
    'us': 'United States',
    'ca': 'Canada',
    'mx': 'Mexico',
    'br': 'Brazil',
    'ar': 'Argentina',
    'cl': 'Chile',
    'pe': 'Peru',
    'co': 'Colombia',
    've': 'Venezuela',
    'uy': 'Uruguay',
    'py': 'Paraguay',
    'bo': 'Bolivia',
    'ec': 'Ecuador',
    'gy': 'Guyana',
    'sr': 'Suriname',
    'gf': 'French Guiana',
    'gb': 'United Kingdom',
    'fr': 'France',
    'de': 'Germany',
    'it': 'Italy',
    'es': 'Spain',
    'pt': 'Portugal',
    'nl': 'Netherlands',
    'be': 'Belgium',
    'ch': 'Switzerland',
    'at': 'Austria',
    'se': 'Sweden',
    'no': 'Norway',
    'dk': 'Denmark',
    'fi': 'Finland',
    'is': 'Iceland',
    'ie': 'Ireland',
    'pl': 'Poland',
    'cz': 'Czech Republic',
    'sk': 'Slovakia',
    'hu': 'Hungary',
    'ro': 'Romania',
    'bg': 'Bulgaria',
    'rs': 'Serbia',
    'hr': 'Croatia',
    'si': 'Slovenia',
    'ba': 'Bosnia and Herzegovina',
    'me': 'Montenegro',
    'mk': 'North Macedonia',
    'al': 'Albania',
    'gr': 'Greece',
    'tr': 'Turkey',
    'cy': 'Cyprus',
    'ru': 'Russia',
    'ua': 'Ukraine',
    'by': 'Belarus',
    'md': 'Moldova',
    'lt': 'Lithuania',
    'lv': 'Latvia',
    'ee': 'Estonia',
    'cn': 'China',
    'jp': 'Japan',
    'kr': 'South Korea',
    'kp': 'North Korea',
    'mn': 'Mongolia',
    'in': 'India',
    'pk': 'Pakistan',
    'af': 'Afghanistan',
    'ir': 'Iran',
    'iq': 'Iraq',
    'sy': 'Syria',
    'lb': 'Lebanon',
    'jo': 'Jordan',
    'il': 'Israel',
    'ps': 'Palestine',
    'sa': 'Saudi Arabia',
    'ae': 'United Arab Emirates',
    'qa': 'Qatar',
    'kw': 'Kuwait',
    'bh': 'Bahrain',
    'om': 'Oman',
    'ye': 'Yemen',
    'eg': 'Egypt',
    'ly': 'Libya',
    'tn': 'Tunisia',
    'dz': 'Algeria',
    'ma': 'Morocco',
    'sd': 'Sudan',
    'et': 'Ethiopia',
    'ke': 'Kenya',
    'tz': 'Tanzania',
    'ug': 'Uganda',
    'rw': 'Rwanda',
    'bi': 'Burundi',
    'cd': 'Democratic Republic of Congo',
    'cg': 'Republic of Congo',
    'cf': 'Central African Republic',
    'cm': 'Cameroon',
    'td': 'Chad',
    'ne': 'Niger',
    'ng': 'Nigeria',
    'bf': 'Burkina Faso',
    'ml': 'Mali',
    'sn': 'Senegal',
    'gn': 'Guinea',
    'sl': 'Sierra Leone',
    'lr': 'Liberia',
    'ci': 'Ivory Coast',
    'gh': 'Ghana',
    'tg': 'Togo',
    'bj': 'Benin',
    'za': 'South Africa',
    'na': 'Namibia',
    'bw': 'Botswana',
    'zw': 'Zimbabwe',
    'zm': 'Zambia',
    'mw': 'Malawi',
    'mz': 'Mozambique',
    'mg': 'Madagascar',
    'au': 'Australia',
    'nz': 'New Zealand',
    'pg': 'Papua New Guinea',
    'fj': 'Fiji',
    'th': 'Thailand',
    'vn': 'Vietnam',
    'la': 'Laos',
    'kh': 'Cambodia',
    'mm': 'Myanmar',
    'my': 'Malaysia',
    'sg': 'Singapore',
    'id': 'Indonesia',
    'ph': 'Philippines',
    'bn': 'Brunei',
    'tl': 'East Timor',
    'lk': 'Sri Lanka',
    'mv': 'Maldives',
    'bd': 'Bangladesh',
    'bt': 'Bhutan',
    'np': 'Nepal',
    'uz': 'Uzbekistan',
    'kz': 'Kazakhstan',
    'kg': 'Kyrgyzstan',
    'tj': 'Tajikistan',
    'tm': 'Turkmenistan',
    'az': 'Azerbaijan',
    'am': 'Armenia',
    'ge': 'Georgia',
  };

  String _getCountryName(String countryCode) {
    return _countryNames[countryCode.toLowerCase()] ?? countryCode.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TravelProvider>(
        builder: (context, travelProvider, child) {
          return CustomScrollView(
            physics: const ClampingScrollPhysics(),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TravelStatsCard(
                    visitedCount: travelProvider.visitedCount,
                    wishlistCount: travelProvider.wishlistCount,
                  ),
                ),
              ),
              
              // World Map
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 4, bottom: 2),
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
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 320, // Reduced height for tighter fit
                            child: InteractiveViewer(
                              minScale: 0.3,
                              maxScale: 75.0,
                              constrained: true,
                              panEnabled: true,
                              scaleEnabled: true,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: SimpleMap(
                                  instructions: SMapWorld.instructions,
                                  defaultColor: Colors.grey.shade300,
                                  colors: _createCountryColorsMap(travelProvider),
                                  callback: (id, name, tapDetails) {
                                    final countryName = _getCountryName(id);
                                    // Only show modal if country is known (not ocean/unknown area)
                                    if (_countryNames.containsKey(id.toLowerCase())) {
                                      _onCountryTapped(context, travelProvider, id, countryName);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
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
                        'How to use',
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
                            'Pinch to zoom • Drag to pan • Tap to mark',
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
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country header with name and code
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        countryName.isNotEmpty ? countryName : 'Unknown Country',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Country Code: $countryCode',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(travelProvider, countryCode),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusText(travelProvider, countryCode),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      // Check the current state BEFORE toggling
                      final wasVisited = travelProvider.isCountryVisited(countryCode);
                      travelProvider.toggleCountryVisited(countryCode, countryName);
                      Navigator.pop(context);
                      // Show a snackbar with feedback
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            wasVisited
                              ? '$countryName removed from visited countries'
                              : '$countryName added to visited countries!',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: Icon(
                      travelProvider.isCountryVisited(countryCode)
                          ? Icons.remove_circle
                          : Icons.add_circle,
                    ),
                    label: Text(
                      travelProvider.isCountryVisited(countryCode)
                          ? 'Remove Visited'
                          : 'Mark Visited',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Check the current state BEFORE toggling
                      final wasInWishlist = travelProvider.isCountryInWishlist(countryCode);
                      travelProvider.toggleCountryWishlist(countryCode, countryName);
                      Navigator.pop(context);
                      // Show a snackbar with feedback
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            wasInWishlist
                              ? '$countryName removed from wishlist'
                              : '$countryName added to wishlist!',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: Icon(
                      travelProvider.isCountryInWishlist(countryCode)
                          ? Icons.favorite
                          : Icons.favorite_outline,
                    ),
                    label: Text(
                      travelProvider.isCountryInWishlist(countryCode)
                          ? 'Remove Wishlist'
                          : 'Add Wishlist',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
  
  Color _getStatusColor(TravelProvider travelProvider, String countryCode) {
    if (travelProvider.isCountryVisited(countryCode)) {
      return Colors.green.shade400;
    } else if (travelProvider.isCountryInWishlist(countryCode)) {
      return Colors.orange.shade400;
    } else {
      return Colors.grey.shade400;
    }
  }
  
  String _getStatusText(TravelProvider travelProvider, String countryCode) {
    if (travelProvider.isCountryVisited(countryCode)) {
      return 'Visited';
    } else if (travelProvider.isCountryInWishlist(countryCode)) {
      return 'Wishlist';
    } else {
      return 'Not Visited';
    }
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