import 'package:drift/drift.dart';
import '../data/base.dart';

part 'produit_dao.g.dart';

@DriftAccessor(tables: [ProduitsTable])
class ProduitDAO extends DatabaseAccessor<ProduitsDatabase>
    with _$ProduitDAOMixin {
  final ProduitsDatabase db;

  ProduitDAO(this.db) : super(db);

  // Récupérer tous les produits
  Future<List<ProduitsTableData>> getAllProduits() =>
      select(produitsTable).get();

  // Observer tous les produits (Stream)
  Stream<List<ProduitsTableData>> watchAllProduits() =>
      select(produitsTable).watch();

  // Ajouter un produit
  Future<int> insertProduit(ProduitsTableCompanion produit) {
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

  // Supprimer plusieurs produits
  Future<int> deleteProduits(List<ProduitsTableData> produits) async {
    int count = 0;
    for (var produit in produits) {
      count += await delete(produitsTable).delete(produit);
    }
    return count;
  }

  // Récupérer un produit par ID
  Future<ProduitsTableData?> getProduitById(int id) {
    return (select(produitsTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }
}