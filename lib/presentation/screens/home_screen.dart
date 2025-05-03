import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<Map<String, String>> _keunggulan = [
    {
      'title': 'Reliable',
      'description': 'LILIK.NET memiliki kecepatan yang tinggi dan stabil.',
    },
    {
      'title': 'Affordable',
      'description': 'LILIK.NET stabil karena routing fiber optik.',
    },
     {
      'title': 'Unlimited',
      'description': 'LILIK.NET menjadi solusi internet unlimited.',
    },
  ];

  final List<Map<String, String>> _paketTop = [
    {
      'title': 'Paket Murah',
      'description': 'Kecepatan hingga 10 Mbps',
    },
    {
      'title': 'Paket Menengah',
      'description': 'Kecepatan hingga 20 Mbps',
    },
     {
      'title': 'Paket Mewah',
      'description': 'Kecepatan hingga 30 Mbps',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LILIK.NET'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Aksi pencarian
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: [
                        _buildSliderItem('assets/images/banner1.png'),
                        _buildSliderItem('assets/images/banner2.png'),
                        _buildSliderItem('assets/images/banner3.png'),
                      ],
                    ),
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentPage == index ? 12 : 8,
                            height: _currentPage == index ? 12 : 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index ? Colors.blue : const Color.fromARGB(255, 0, 0, 0),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Keunggulan LILIK.NET',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Lihat lebih
                      },
                      child: const Text('Lihat lebih'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: _keunggulan.length,
                  itemBuilder: (context, index) {
                    return _buildKeunggulanCard(
                      _keunggulan[index]['title'] ?? '',
                      _keunggulan[index]['description'] ?? '',
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Text(
                  'Paket Top Kami',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: _paketTop.length,
                  itemBuilder: (context, index) {
                    return _buildPaketCard(
                      _paketTop[index]['title'] ?? '',
                      _paketTop[index]['description'] ?? '',
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliderItem(String imagePath) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildKeunggulanCard(String title, String description) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildPaketCard(String title, String description) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 12),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // TODO: Aksi untuk beli/lihat detail paket
            },
            child: const Text('Lihat Detail'),
          ),
        ],
      ),
    );
  }
}
