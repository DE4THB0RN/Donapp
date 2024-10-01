import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DonApp'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: HomeScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: AssetImage('img/imagemgenerica.jpg')),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'DESTAQUES',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seguidos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                NGOCard(
                  title: 'ONG 1',
                  description: 'Somos uma ONG de ajudar animais',
                  imageUrl: 'https://www.example.com/ong1.jpg',
                ),
                NGOCard(
                  title: 'ONG 2',
                  description: 'Doamos alimentos para os pobres',
                  imageUrl: 'https://www.example.com/ong2.jpg',
                ),
                NGOCard(
                  title: 'ONG 3',
                  description: 'Somos uma ONG que doa roupas para os sem teto',
                  imageUrl: 'https://www.example.com/ong3.jpg',
                ),
                NGOCard(
                  title: 'ONG 4',
                  description:
                      'Somos uma ONG que salva crianças em situação de fome e pobreza',
                  imageUrl: 'https://www.example.com/ong4.jpg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NGOCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  NGOCard(
      {required this.title, required this.description, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading:
            Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}
