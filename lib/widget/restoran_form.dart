import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ucp2_paml/controller/restoran_controller.dart';
import 'package:ucp2_paml/model/restoran.dart';

import '../screen/home_view.dart';
import '../screen/map_view.dart';

class FormRestoran extends StatefulWidget {
  const FormRestoran({super.key});

  @override
  State<FormRestoran> createState() => _FormRestoranState();
}

class _FormRestoranState extends State<FormRestoran> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();

  String? _lokasi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Masukan Data Restoran')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Nama Restoran",
                        hintText: 'Masukkan Nama Restoran'),
                    controller: _namaController,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Lokasi :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _lokasi == null
                          ? const SizedBox(
                              width: double.infinity,
                              child: Text("Lokasi Kosong"))
                          : Text('$_lokasi'),
                      SizedBox(
                        height: 10,
                      ),
                      _lokasi == null
                          ? TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapView(
                                      onLocationSelected: (selectedAddress) {
                                        setState(() {
                                          _lokasi = selectedAddress;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Pilih Alamat'),
                            )
                          : TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapView(
                                      onLocationSelected: (selectedAddress) {
                                        setState(() {
                                          _lokasi = selectedAddress;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Ubah Alamat'),
                            ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Simpan data atau kirim data ke database
                      print("Nama Restoran: ${_namaController.text}");
                      print("Lokasi: $_lokasi");
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
