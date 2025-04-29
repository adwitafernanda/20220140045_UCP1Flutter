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

