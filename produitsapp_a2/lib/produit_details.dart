import 'package:flutter/material.dart';
import 'model/produit.dart';
import 'dart:io';

class ProduitDetails extends StatelessWidget {
  final Produit produit;

  ProduitDetails({required this.produit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(produit.libelle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Photo
            if (produit.photo.isNotEmpty)
              Center(
                child: Image.file(
                  File(produit.photo),
                  height: 180,
                ),
              ),

            SizedBox(height: 20),

            // Libellé
            Text(
              "Nom du produit :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(produit.libelle, style: TextStyle(fontSize: 16)),

            SizedBox(height: 15),

            // Description
            Text(
              "Description :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(produit.description, style: TextStyle(fontSize: 16)),

            SizedBox(height: 15),

            // Prix
            Text(
              "Prix :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text("${produit.prix} DH", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class Produit {
}
