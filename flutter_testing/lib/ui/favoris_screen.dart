import 'package:flutter/material.dart';
import 'package:flutter_testing/models/favoris_models.dart';
import 'package:provider/provider.dart';
class PageFavoris extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
 final favoris = context.watch<Favoris>();
 return Scaffold(
 appBar: AppBar(
 title: Text('Mes Favoris'),
 ),
 body: ListView.builder(
 itemCount: favoris.elements.length,
 itemBuilder: (context, index) {
 final numeroElement = favoris.elements[index];
 return ListTile(
 title: Text('Élément $numeroElement'),
 trailing: IconButton(
 icon: Icon(Icons.delete),
 onPressed: () {
 favoris.supprimer(numeroElement);
 },
 ),
 );
 }, 
 ),
 );
 }
} 