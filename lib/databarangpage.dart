import 'package:flutter/material.dart';

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
