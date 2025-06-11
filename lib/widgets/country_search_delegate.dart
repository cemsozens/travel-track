import 'package:flutter/material.dart';
import '../providers/travel_provider.dart';

class CountrySearchDelegate extends SearchDelegate<String> {
  final TravelProvider travelProvider;
  
  // All countries with their codes and names
  static const Map<String, String> _countryNames = {
    // North America
    'us': 'United States',
    'ca': 'Canada',
    'mx': 'Mexico',
    'gt': 'Guatemala',
    'bz': 'Belize',
    'sv': 'El Salvador',
    'hn': 'Honduras',
    'ni': 'Nicaragua',
    'cr': 'Costa Rica',
    'pa': 'Panama',
    'cu': 'Cuba',
    'jm': 'Jamaica',
    'ht': 'Haiti',
    'do': 'Dominican Republic',
    'tt': 'Trinidad and Tobago',
    'bb': 'Barbados',
    'gd': 'Grenada',
    'vc': 'Saint Vincent and the Grenadines',
    'lc': 'Saint Lucia',
    'dm': 'Dominica',
    'ag': 'Antigua and Barbuda',
    'kn': 'Saint Kitts and Nevis',
    'bs': 'Bahamas',
    
    // South America
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
    
    // Europe
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
    'mt': 'Malta',
    'ru': 'Russia',
    'ua': 'Ukraine',
    'by': 'Belarus',
    'md': 'Moldova',
    'lt': 'Lithuania',
    'lv': 'Latvia',
    'ee': 'Estonia',
    'lu': 'Luxembourg',
    'mc': 'Monaco',
    'ad': 'Andorra',
    'sm': 'San Marino',
    'va': 'Vatican City',
    'li': 'Liechtenstein',
    
    // Asia
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
    
    // Africa
    'eg': 'Egypt',
    'ly': 'Libya',
    'tn': 'Tunisia',
    'dz': 'Algeria',
    'ma': 'Morocco',
    'sd': 'Sudan',
    'ss': 'South Sudan',
    'et': 'Ethiopia',
    'er': 'Eritrea',
    'dj': 'Djibouti',
    'so': 'Somalia',
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
    'mr': 'Mauritania',
    'sn': 'Senegal',
    'gm': 'Gambia',
    'gw': 'Guinea-Bissau',
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
    'mu': 'Mauritius',
    'sc': 'Seychelles',
    'km': 'Comoros',
    'cv': 'Cape Verde',
    'st': 'São Tomé and Príncipe',
    'gq': 'Equatorial Guinea',
    'ga': 'Gabon',
    'ao': 'Angola',
    'ls': 'Lesotho',
    'sz': 'Eswatini',
    
    // Oceania
    'au': 'Australia',
    'nz': 'New Zealand',
    'pg': 'Papua New Guinea',
    'fj': 'Fiji',
    'sb': 'Solomon Islands',
    'vu': 'Vanuatu',
    'nc': 'New Caledonia',
    'pf': 'French Polynesia',
    'ck': 'Cook Islands',
    'nu': 'Niue',
    'to': 'Tonga',
    'ws': 'Samoa',
    'ki': 'Kiribati',
    'tv': 'Tuvalu',
    'nr': 'Nauru',
    'mh': 'Marshall Islands',
    'fm': 'Micronesia',
    'pw': 'Palau',
  };

  CountrySearchDelegate(this.travelProvider);

  @override
  String get searchFieldLabel => 'Search countries (e.g., Malta, Monaco)';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Search for any country',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Perfect for finding small countries like Malta, Monaco, Vatican City',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final searchResults = _countryNames.entries
        .where((entry) => 
            entry.value.toLowerCase().contains(query.toLowerCase()) ||
            entry.key.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No countries found for "$query"',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final entry = searchResults[index];
            final countryCode = entry.key;
            final countryName = entry.value;
            
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: _getStatusColor(countryCode),
                child: Text(
                  countryCode.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(countryName),
              subtitle: Text(
                _getStatusText(countryCode),
                style: TextStyle(
                  color: _getStatusColor(countryCode),
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      travelProvider.isCountryVisited(countryCode)
                          ? Icons.check_circle
                          : Icons.add_circle_outline,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      _handleVisitedToggle(context, setState, countryCode, countryName);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      travelProvider.isCountryInWishlist(countryCode)
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      _handleWishlistToggle(context, setState, countryCode, countryName);
                    },
                  ),
                ],
              ),
              onTap: () {
                close(context, countryCode);
                // Show the country modal
                _showCountryModal(context, countryCode, countryName);
              },
            );
          },
        );
      },
    );
  }

  void _handleVisitedToggle(BuildContext context, StateSetter setState, String countryCode, String countryName) {
    final wasVisited = travelProvider.isCountryVisited(countryCode);
    final wasInWishlist = travelProvider.isCountryInWishlist(countryCode);
    
    if (wasVisited) {
      // Remove from visited
      travelProvider.toggleCountryVisited(countryCode, countryName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$countryName removed from visited countries'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      // Add to visited (and remove from wishlist if it was there)
      if (wasInWishlist) {
        travelProvider.toggleCountryWishlist(countryCode, countryName);
      }
      travelProvider.toggleCountryVisited(countryCode, countryName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$countryName added to visited countries!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    
    // Trigger rebuild of the search results
    setState(() {});
  }

  void _handleWishlistToggle(BuildContext context, StateSetter setState, String countryCode, String countryName) {
    final wasInWishlist = travelProvider.isCountryInWishlist(countryCode);
    final wasVisited = travelProvider.isCountryVisited(countryCode);
    
    if (wasInWishlist) {
      // Remove from wishlist
      travelProvider.toggleCountryWishlist(countryCode, countryName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$countryName removed from wishlist'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      // Add to wishlist (and remove from visited if it was there)
      if (wasVisited) {
        travelProvider.toggleCountryVisited(countryCode, countryName);
      }
      travelProvider.toggleCountryWishlist(countryCode, countryName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$countryName added to wishlist!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    
    // Trigger rebuild of the search results
    setState(() {});
  }

  Color _getStatusColor(String countryCode) {
    if (travelProvider.isCountryVisited(countryCode)) {
      return Colors.green.shade400;
    } else if (travelProvider.isCountryInWishlist(countryCode)) {
      return Colors.orange.shade400;
    } else {
      return Colors.grey.shade400;
    }
  }

  String _getStatusText(String countryCode) {
    if (travelProvider.isCountryVisited(countryCode)) {
      return 'Visited';
    } else if (travelProvider.isCountryInWishlist(countryCode)) {
      return 'Wishlist';
    } else {
      return 'Not Visited';
    }
  }

  void _showCountryModal(BuildContext context, String countryCode, String countryName) {
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
                        countryName,
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
                    color: _getStatusColor(countryCode),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusText(countryCode),
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
                      final wasVisited = travelProvider.isCountryVisited(countryCode);
                      final wasInWishlist = travelProvider.isCountryInWishlist(countryCode);
                      
                      if (!wasVisited && wasInWishlist) {
                        // Remove from wishlist before adding to visited
                        travelProvider.toggleCountryWishlist(countryCode, countryName);
                      }
                      travelProvider.toggleCountryVisited(countryCode, countryName);
                      Navigator.pop(context);
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
                      final wasInWishlist = travelProvider.isCountryInWishlist(countryCode);
                      final wasVisited = travelProvider.isCountryVisited(countryCode);
                      
                      if (!wasInWishlist && wasVisited) {
                        // Remove from visited before adding to wishlist
                        travelProvider.toggleCountryVisited(countryCode, countryName);
                      }
                      travelProvider.toggleCountryWishlist(countryCode, countryName);
                      Navigator.pop(context);
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
} 