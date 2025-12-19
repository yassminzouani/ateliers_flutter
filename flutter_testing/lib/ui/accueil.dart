import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_testing/models/favoris_models.dart';
import 'package:flutter_testing/ui/favoris_screen.dart';
class PageAccueil extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title: Text('Liste des Éléments'),
 actions: [
 IconButton(
 icon: Icon(Icons.favorite),
 onPressed: () {
 Navigator.push(
 context,
 MaterialPageRoute(builder: (context) => PageFavoris()),
 );
 },
 ),
 ],
 ),
 body: ListeElements(), 
 );
 }
}
class ListeElements extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
 return ListView.builder(
 itemCount: 50,
 itemBuilder: (context, index) {
 return ElementListe(index);
 },
 );
 }
}
class ElementListe extends StatelessWidget {
 final int numeroElement;
 ElementListe(this.numeroElement);
 @override
 Widget build(BuildContext context) {
 final favoris = context.watch<Favoris>();
 final estFavori = favoris.elements.contains(numeroElement);
 return ListTile(
 title: Text('Élément $numeroElement'),
 trailing: IconButton(
 icon: Icon(
 estFavori ? Icons.favorite : Icons.favorite_border,
 color: estFavori ? Colors.red : null,
 ),
 onPressed: () {
 if (estFavori) {
 favoris.supprimer(numeroElement);
 } else {
 favoris.ajouter(numeroElement);
 }
 },
 ),
 );
 }
} 
