import 'package:flutter/material.dart';
import 'add_produit.dart';
import 'produit_box.dart';

class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  final List<Map<String, dynamic>> _produits = [
    {'nom': 'Ordinateur', 'sel': false},
    {'nom': 'Smartphone', 'sel': false},
    {'nom': 'Clavier', 'sel': false},
  ];

  void _onProduitChanged(bool? value, int index) {
    setState(() {
      _produits[index]['sel'] = value!;
    });
  }

  void _delProduit(int index) {
    setState(() {
      _produits.removeAt(index);
    });
  }

  void _ajouterProduit(String nom) {
    setState(() {
      _produits.add({'nom': nom, 'sel': false});
    });
  }

  void _supprimerSelection() {
    setState(() {
      _produits.removeWhere((p) => p['sel'] == true);
    });
  }

  void _ouvrirDialogAjout() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) =>
          AddProduit(nomController: controller, onAdd: _ajouterProduit, nomController: null,, onCancel: () {  },),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
        actions: [
          IconButton(
            onPressed: _supprimerSelection,
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Supprimer les produits sélectionnés',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _produits.length,
        itemBuilder: (context, index) {
          return ProduitBox(
            nomProduit: _produits[index]['nom'],
            selProduit: _produits[index]['sel'],
            onChanged: (val) => _onProduitChanged(val, index),
            delProduit: () => _delProduit(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _ouvrirDialogAjout,
        child: const Icon(Icons.add),
      ),
    );
  }
}

