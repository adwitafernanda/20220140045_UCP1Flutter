import 'package:flutter/material.dart';

class DataPiket extends StatefulWidget {
  final String nama;
  
  const DataPiket({super.key, required this.nama});

  @override
  State<DataPiket> createState() => _DataPiketState();
}

class _DataPiketState extends State<DataPiket> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _namaController;
  final TextEditingController _tugasController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();

  List<Map<String, dynamic>> _daftarTugas = [];

  final Map<String, String> _indonesianDays = {
    'Monday': 'Senin',
    'Tuesday': 'Selasa',
    'Wednesday': 'Rabu', 
    'Thursday': 'Kamis',
    'Friday': 'Jumat',
    'Saturday': 'Sabtu',
    'Sunday': 'Minggu',
  };

  final Map<String, String> _indonesianMonths = {
    'January': 'Januari',
    'February': 'Februari',
    'March': 'Maret',
    'April': 'April',
    'May': 'Mei',
    'June': 'Juni',
    'July': 'Juli',
    'August': 'Agustus',
    'September': 'September',
    'October': 'Oktober',
    'November': 'November',
    'December': 'Desember',
  };

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.nama);
  }
  String _formatIndonesianDate(DateTime date) {
    final englishDay = DateFormat('EEEE').format(date);
    final englishMonth = DateFormat('MMMM').format(date);
    
    final indonesianDay = _indonesianDays[englishDay] ?? englishDay;
    final indonesianMonth = _indonesianMonths[englishMonth] ?? englishMonth;
    
    return '$indonesianDay, ${date.day} $indonesianMonth ${date.year}';
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tugasController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _tanggalController.text = _formatIndonesianDate(picked);
      });
    }
  }
  void _tambahTugas() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _daftarTugas.add({
          'nama': _namaController.text,
          'tanggal': _tanggalController.text,
          'tugas': _tugasController.text,
        });
        _tanggalController.clear();
        _tugasController.clear();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Piket Gudang',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nama Anggota",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  hintText: 'Nama Anggota',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pilih Tanggal",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _tanggalController,
                    decoration: InputDecoration(
                      hintText: 'Pilih Tanggal',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tanggal tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tugas Piket",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _tugasController,
                      decoration: InputDecoration(
                        hintText: 'Tugas Piket',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tugas tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: _tambahTugas,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      child: const Text('Tambah',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Align(
                alignment: Alignment.center,
                child: Text(
                  "Daftar Tugas Piket",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const SizedBox(height: 8),

              Expanded(
                child: _daftarTugas.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada data',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _daftarTugas.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: const Color.fromARGB(255, 255, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              title: Text(
                                _daftarTugas[index]['tugas'],
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPiketPage(
                                      nama: _daftarTugas[index]['nama'],
                                      tanggal: _daftarTugas[index]['tanggal'],
                                      tugas: _daftarTugas[index]['tugas'],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

