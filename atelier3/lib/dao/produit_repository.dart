import 'dart:async';
import 'package:flutter/foundation.dart';
import '../data/base.dart';
import 'produit_dao.dart';

/// Common interface used across the app. Implementations delegate to
/// the Drift DAO on native platforms, or to an in-memory store on the web.
abstract class ProduitRepository {
  Stream<List<ProduitsTableData>> watchAllProduits();
  Future<List<ProduitsTableData>> getAllProduits();
  Future<int> insertProduit(ProduitsTableCompanion produit);
  Future<bool> updateProduit(ProduitsTableData produit);
  Future<int> deleteProduit(ProduitsTableData produit);
  Future<int> deleteProduits(List<ProduitsTableData> produits);
  Future<ProduitsTableData?> getProduitById(int id);
}

class DriftProduitRepository implements ProduitRepository {
  final ProduitDAO _dao;

  DriftProduitRepository(this._dao);

  @override
  Future<int> deleteProduit(ProduitsTableData produit) =>
      _dao.deleteProduit(produit);

  @override
  Future<int> deleteProduits(List<ProduitsTableData> produits) =>
      _dao.deleteProduits(produits);

  @override
  Future<bool> updateProduit(ProduitsTableData produit) =>
      _dao.updateProduit(produit);

  @override
  Stream<List<ProduitsTableData>> watchAllProduits() => _dao.watchAllProduits();

  @override
  Future<int> insertProduit(ProduitsTableCompanion produit) =>
      _dao.insertProduit(produit);

  @override
  Future<List<ProduitsTableData>> getAllProduits() => _dao.getAllProduits();

  @override
  Future<ProduitsTableData?> getProduitById(int id) => _dao.getProduitById(id);
}

class InMemoryProduitRepository implements ProduitRepository {
  final List<ProduitsTableData> _items = [];
  final StreamController<List<ProduitsTableData>> _controller =
      StreamController.broadcast();
  int _nextId = 1;

  InMemoryProduitRepository() {
    _controller.add(_items);
  }

  void _emit() => _controller.add(List.unmodifiable(_items));

  @override
  Future<int> insertProduit(ProduitsTableCompanion produit) async {
    final id = _nextId++;
    final data = ProduitsTableData(
      id: id,
      libelle: produit.libelle.value,
      description: produit.description.value,
      prix: produit.prix.value,
      photo: produit.photo.value,
    );
    _items.add(data);
    _emit();
    return id;
  }

  @override
  Future<int> deleteProduit(ProduitsTableData produit) async {
    _items.removeWhere((p) => p.id == produit.id);
    _emit();
    return 1;
  }

  @override
  Future<int> deleteProduits(List<ProduitsTableData> produits) async {
    final ids = produits.map((e) => e.id).toSet();
    _items.removeWhere((p) => ids.contains(p.id));
    _emit();
    return produits.length;
  }

  @override
  Future<List<ProduitsTableData>> getAllProduits() async =>
      List.unmodifiable(_items);

  @override
  Future<ProduitsTableData?> getProduitById(int id) async {
    final matches = _items.where((p) => p.id == id);
    return matches.isEmpty ? null : matches.first;
  }

  @override
  Stream<List<ProduitsTableData>> watchAllProduits() => _controller.stream;

  @override
  Future<bool> updateProduit(ProduitsTableData produit) async {
    final idx = _items.indexWhere((p) => p.id == produit.id);
    if (idx == -1) return false;
    _items[idx] = produit;
    _emit();
    return true;
  }
}

/// Factory: returns an appropriate repository for the current platform.
ProduitRepository createProduitRepository({ProduitsDatabase? database}) {
  if (kIsWeb) {
    return InMemoryProduitRepository();
  }
  if (database == null) {
    throw ArgumentError('database is required on non-web platforms');
  }
  return DriftProduitRepository(ProduitDAO(database));
}