import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ucp2_paml/controller/restoran_controller.dart';
import 'package:ucp2_paml/model/restoran.dart';
import 'package:ucp2_paml/widget/restoran_form.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final RestoranController _controller = RestoranController();
  @override
  void initState() {
    super.initState();
    _controller.getRestoran();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Restoran"),
      ),
      body: FutureBuilder<List<Restoran>>(
          future: _controller.getRestoran(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    Restoran restoran = snapshot.data![index];
                    return ListTile(
                      title: Text(restoran.nama),
                      subtitle: Text(restoran.lokasi),
                    );
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormRestoran()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
