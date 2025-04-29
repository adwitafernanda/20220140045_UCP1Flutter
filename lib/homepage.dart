import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String nama;

  const HomePage({Key? key, required this.nama}) : super(key: key);
  

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 1, 1),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
              radius: 20,
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  widget.nama,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.logout),
            color: Colors.white,
            
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Center(
                child: Image.asset(
                  'assets/images/banner.jpg',
                  width: 550,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 50),
            GridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1, // 1:1 untuk normal card
              ),
              children: [
                menuCard(
                  icon: Icons.group,
                  title: 'Data Piket',
                  backgroundColor: Color.fromARGB(255, 255, 0, 0),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DataPiket()),
                      );
                  },
                ),
                menuCard(
                  icon: Icons.account_box,
                  title: 'Data Pelanggan',
                  backgroundColor: Color.fromARGB(255, 255, 0, 0),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DataPelanggan()),
                      );
                  },
                ),
              ],
            ),
            SizedBox(height: 12),
            menuCard(
              icon: Icons.warehouse,
              title: 'Barang Masuk/Keluar',
              backgroundColor: Color.fromARGB(255, 255, 0, 0),
              height: 200,
              fullWidth: true,
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DataBarang()),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget menuCard({
    required IconData icon,
    required String title,
    Color backgroundColor = const Color.fromARGB(255, 255, 2, 2),
    double height = 100,
    bool fullWidth = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: fullWidth ? double.infinity : null,
        height: height,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
