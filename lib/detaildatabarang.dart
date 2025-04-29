import 'package:flutter/material.dart';

class DetailDataBarang extends StatelessWidget {
  final String tanggal;
  final String jenisTransaksi;
  final String jenisBarang;
  final int jumlah;
  final int hargaSatuan;
  final int totalHarga;
  
  const DetailDataBarang({
    super.key,
    required this.tanggal,
    required this.jenisTransaksi,
    required this.jenisBarang,
    required this.jumlah,
    required this.hargaSatuan,
    required this.totalHarga,
  });
