import 'package:drift/drift.dart';
import 'connection_io.dart' if (dart.library.html) 'connection_web.dart';

part 'base.g.dart';

// Définition de la table Produits
class ProduitsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get libelle => text().withLength(min: 1, max: 100)();
  TextColumn get description => text()();
  RealColumn get prix => real()();
  TextColumn get photo => text()();
}

// Database class
@DriftDatabase(tables: [ProduitsTable])
class ProduitsDatabase extends _$ProduitsDatabase {
  ProduitsDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  // Méthode pour obtenir tous les produits
  Future<List<ProduitsTableData>> getAllProduits() =>
      select(produitsTable).get();

  // Stream pour observer les changements
  Stream<List<ProduitsTableData>> watchAllProduits() =>
      select(produitsTable).watch();

  // Ajouter un produit
  Future<int> addProduit(ProduitsTableCompanion produit) {
    return into(produitsTable).insert(produit);
  }

  // Mettre à jour un produit
  Future<bool> updateProduit(ProduitsTableData produit) {
    return update(produitsTable).replace(produit);
  }

  // Supprimer un produit
  Future<int> deleteProduit(ProduitsTableData produit) {
    return delete(produitsTable).delete(produit);
  }

  // Supprimer un produit par ID
  Future<int> deleteProduitById(int id) {
    return (delete(produitsTable)..where((t) => t.id.equals(id))).go();
  }
}