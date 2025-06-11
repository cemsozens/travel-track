import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/travel_provider.dart';
import '../models/country_model.dart';

class CountryListSheet extends StatefulWidget {
  final TravelProvider travelProvider;
  
  const CountryListSheet({
    super.key,
    required this.travelProvider,
  });

  @override
  State<CountryListSheet> createState() => _CountryListSheetState();
}

class _CountryListSheetState extends State<CountryListSheet>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Consumer<TravelProvider>(
        builder: (context, travelProvider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Your Travel Lists',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    icon: const Icon(Icons.flag),
                    text: 'Visited (${travelProvider.visitedCount})',
                  ),
                  Tab(
                    icon: const Icon(Icons.favorite),
                    text: 'Wishlist (${travelProvider.wishlistCount})',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildCountryList(
                      context,
                      travelProvider.visitedCountries,
                      true,
                      travelProvider,
                    ),
                    _buildCountryList(
                      context,
                      travelProvider.wishlistCountries,
                      false,
                      travelProvider,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCountryList(
    BuildContext context,
    List<CountryModel> countries,
    bool isVisited,
    TravelProvider travelProvider,
  ) {
    if (countries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isVisited ? Icons.flag_outlined : Icons.favorite_outline,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              isVisited 
                  ? 'No countries visited yet'
                  : 'No countries in wishlist',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isVisited 
                  ? 'Tap on countries in the map to mark them as visited'
                  : 'Tap on countries in the map to add them to your wishlist',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Sort countries alphabetically
    final sortedCountries = List<CountryModel>.from(countries)
      ..sort((a, b) => a.name.compareTo(b.name));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedCountries.length,
      itemBuilder: (context, index) {
        final country = sortedCountries[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isVisited 
                  ? Colors.green.shade100 
                  : Colors.orange.shade100,
              child: Icon(
                isVisited ? Icons.flag : Icons.favorite,
                color: isVisited ? Colors.green : Colors.orange,
              ),
            ),
            title: Text(
              country.name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: isVisited && country.visitedDate != null
                ? Text(
                    'Visited on ${_formatDate(country.visitedDate!)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                : null,
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                if (isVisited) {
                  travelProvider.toggleCountryVisited(
                    country.code,
                    country.name,
                  );
                } else {
                  travelProvider.toggleCountryWishlist(
                    country.code,
                    country.name,
                  );
                }
              },
              tooltip: isVisited ? 'Remove from visited' : 'Remove from wishlist',
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
} 