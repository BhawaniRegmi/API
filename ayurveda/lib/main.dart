import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disease Ayurveda',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Arial',
      ),
      home: const AyurvedaScreen(),
    );
  }
}

class AyurvedaScreen extends StatefulWidget {
  const AyurvedaScreen({super.key});

  @override
  _AyurvedaScreenState createState() => _AyurvedaScreenState();
}

class _AyurvedaScreenState extends State<AyurvedaScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _suggestions = [
    'Asthma',
    'Acid Reflux',
    'Arthritis',
    'Migraine Headache',
    'Anxiety Management',
    'Allergic Rhinitis',
    'Bronchitis',
    'Chronic Fatigue',
  ];
  String _selectedSuggestion = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Ayurveda'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for diseases, remedies, or herbs',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                setState(() {
                  _selectedSuggestion = '';
                });
              },
            ),
            const SizedBox(height: 8),
            if (_searchController.text.isNotEmpty && _selectedSuggestion.isEmpty)
              Expanded(
                child: ListView(
                  children: _suggestions
                      .where((suggestion) => suggestion.toLowerCase().contains(_searchController.text.toLowerCase()))
                      .map((suggestion) => ListTile(
                            title: Text(suggestion),
                            onTap: () {
                              setState(() {
                                _selectedSuggestion = suggestion;
                                _searchController.text = suggestion;
                              });
                            },
                          ))
                      .toList(),
                ),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _getContentForSelection(),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.healing), label: 'Remedies'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Consult'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  List<Widget> _getContentForSelection() {
    if (_selectedSuggestion.isEmpty) {
      return [
        const SectionHeader(title: 'Common Conditions'),
        const SizedBox(height: 16),
        CommonConditionsSection(),
        const SizedBox(height: 24),
        const SectionHeader(title: 'Recently Viewed'),
        const SizedBox(height: 16),
        const RecentlyViewedSection(),
        const SizedBox(height: 24),
        const SectionHeader(title: 'Disease Directory'),
        const SizedBox(height: 16),
        const DiseaseDirectorySection(),
      ];
    } else {
      return [
        SectionHeader(title: _selectedSuggestion),
        const SizedBox(height: 16),
        Text('Details about $_selectedSuggestion will be shown here.',
            style: const TextStyle(fontSize: 16)),
      ];
    }
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
    );
  }
}

class CommonConditionsSection extends StatelessWidget {
  final List<Map<String, String>> conditions = [
    {'title': 'Asthma', 'icon': '🫁'},
    {'title': 'Acid Reflux', 'icon': '🍴'},
    {'title': 'Arthritis', 'icon': '🦴'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: conditions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final condition = conditions[index];
          return Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.teal.withOpacity(0.2),
                child: Text(
                  condition['icon']!,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                condition['title']!,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          );
        },
      ),
    );
  }
}

class RecentlyViewedSection extends StatelessWidget {
  const RecentlyViewedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'title': 'Migraine Headache', 'subtitle': 'Natural remedies and lifestyle changes for migraine relief'},
      {'title': 'Anxiety Management', 'subtitle': 'Herbal solutions and breathing techniques for anxiety'},
    ];

    return Column(
      children: items
          .map((item) => Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(item['subtitle']!),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal),
                ),
              ))
          .toList(),
    );
  }
}

class DiseaseDirectorySection extends StatelessWidget {
  const DiseaseDirectorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'title': 'Allergic Rhinitis', 'subtitle': 'Natural antihistamine treatments and prevention tips'},
      {'title': 'Bronchitis', 'subtitle': 'Herbal remedies to clear airways and reduce inflammation'},
      {'title': 'Chronic Fatigue', 'subtitle': 'Energy-boosting herbs and lifestyle modifications'},
    ];

    return Column(
      children: items
          .map((item) => Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(item['subtitle']!),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal),
                ),
              ))
          .toList(),
    );
  }
}
