import 'package:flutter/material.dart';
import 'package:qrreader/pages/pages.dart';
import 'package:qrreader/providers/db_provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/providers/ui_provider.dart';
import 'package:qrreader/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/models/scan_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0, title: const Text('Historial'), actions: [
          IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                    .borrarTodos();
              })
        ]),
        body: _HomePageBody(),
        bottomNavigationBar: const CustomNavagation(),
        floatingActionButton: const ScanButton(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //obtener el selected menu opt

    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectdMenuOpt;

    //leer la base de datos
    // final tempScan = new ScanModel(tipo: 'http', valor: 'http://google.com');
    // DBProvider.db.nuevoScan(tempScan);

//Usar el ScanListProvider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
