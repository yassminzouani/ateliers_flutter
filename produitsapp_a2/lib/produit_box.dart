import 'package:flutter/material.dart';
import 'package:produitsapp/produit_box.dart';
import 'package:produitsapp/add_produit.dart';

class ProduitsList extends StatefulWidget {

  const ProduitsList({super.key});


      @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {

  final TextEditingController nomController = TextEditingController();

  List liste = [
    ["1 Produit", false],
    ["2 produit", true],
    ["3 produit", false],
    ["4 produit", false],
    ["5 Produit", false]
  ];

  void onChanged(bool? value, int index) {
    setState(() {
      liste[index][1] = value;
    });
  }

  void saveProduit() {
    setState(() {
      liste.add([nomController.text, false]);
      nomController.clear();
      Navigator.of(context).pop();
    });
  }

  void delProduits(int index) {
    setState(() {
      liste.removeAt(index);
    });
  }

  void addProduits() {
    showDialog(
      context: context,
      builder: (content) {
        return AddProduit(
          nomController: nomController,
          onAdd: saveProduit,
          onCancel: () {
            Navigator.pop(context);
          },
        );
      }
    );
  }



  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Produits")),
      floatingActionButton: FloatingActionButton(onPressed: addProduits, child: const Icon(Icons.add),),
      body: ListView.builder(
        itemCount: liste.length,
        itemBuilder: (context, index) {
          return ProduitBox(nomProduit: liste[index][0],
          selProduit: liste[index][1],
          onChanged: (value) => onChanged(value, index),
          delProduit: (conttext) => delProduits(index),
          );
        }),
    );
  }
}

ProduitBox({required nomProduit, required selProduit, required void Function(dynamic value) onChanged, required void Function(dynamic conttext) delProduit}) {
}