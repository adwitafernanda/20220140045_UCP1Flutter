import 'package:flutter/material.dart';
import 'package:ucp1/detaildatabarang.dart';
import 'package:intl/intl.dart';

class DataBarang extends StatefulWidget {
  const DataBarang({super.key});

  @override
  State<DataBarang> createState() => _DataBarangState();
}

class _DataBarangState extends State<DataBarang> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  String? _selectedJenisTransaksi;
  String? _selectedJenisBarang;
  bool _isLoading = false; // <-- Tambahan

  final Map<String, int> _hargaBarang = {
    'FLYBIRD SV SUBS1': 724800,
    'LIGHTSPEED REBORN': 574800,
    'COANDA SV SUBS1': 595000,
    'SPEEDBLAZE 4': 574800,
  };

  final Map<String, String> _indonesianDays = {
    'Monday': 'Senin',
    'Tuesday': 'Selasa',
    'Wednesday': 'Rabu',
    'Thursday': 'Kamis',
    'Friday': 'Jumat',
    'Saturday': 'Sabtu',
    'Sunday': 'Minggu',
  };

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        String englishFormat = DateFormat('EEEE/MM/yyyy').format(picked);
        String englishDay = englishFormat.split('/')[0];
        String indonesianDay = _indonesianDays[englishDay] ?? englishDay;
        _tanggalController.text = englishFormat.replaceFirst(englishDay, indonesianDay);
      });
    }
  }
  @override
  void dispose() {
    _tanggalController.dispose();
    _jumlahController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Start loading
      });

      await Future.delayed(const Duration(seconds: 1)); // Simulasi delay

      int jumlah = int.tryParse(_jumlahController.text) ?? 0;
      int hargaSatuan = int.tryParse(_hargaController.text) ?? 0;
      int totalHarga = jumlah * hargaSatuan;

      setState(() {
        _isLoading = false; // Stop loading
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailDataBarang(
            tanggal: _tanggalController.text,
            jenisTransaksi: _selectedJenisTransaksi ?? '',
            jenisBarang: _selectedJenisBarang ?? '',
            jumlah: jumlah,
            hargaSatuan: hargaSatuan,
            totalHarga: totalHarga,
          ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pendataan Barang', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tanggal Transaksi'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _tanggalController,
                  readOnly: true,
                  onTap: _selectDate,
                  decoration: InputDecoration(
                    hintText: 'Tanggal Transaksi',
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Tanggal tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                const Text('Jenis Transaksi'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedJenisTransaksi,
                  decoration: InputDecoration(
                    hintText: 'Pilih jenis transaksi',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: ['Barang Masuk', 'Barang Keluar']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedJenisTransaksi = value),
                  validator: (value) => value == null ? 'Jenis transaksi tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                const Text('Jenis Barang'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedJenisBarang,
                  decoration: InputDecoration(
                    hintText: 'Pilih jenis barang',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: _hargaBarang.keys
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedJenisBarang = value;
                      _hargaController.text = _hargaBarang[value!]!.toString();
                    });
                  },
                  validator: (value) => value == null ? 'Jenis barang tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Jumlah Barang'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _jumlahController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Jumlah Barang',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            validator: (value) => value == null || value.isEmpty ? 'Jumlah barang tidak boleh kosong' : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Harga Satuan'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _hargaController,
                            readOnly: true,
                            decoration: InputDecoration(
                              prefixText: 'Rp. ',
                              hintText: 'Harga Satuan',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            validator: (value) => value == null || value.isEmpty ? 'Harga satuan tidak boleh kosong' : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _isLoading ? null : _submitForm,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Submit',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


