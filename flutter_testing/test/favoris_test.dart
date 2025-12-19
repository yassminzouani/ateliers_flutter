import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/models/favoris_models.dart';

void main() {
  group('Tests de la classe Favoris', () {
    late Favoris favoris;

    setUp(() {
      favoris = Favoris();
    });

    test('Un élément peut être ajouté aux favoris', () {
      final numeroElement = 42;

      favoris.ajouter(numeroElement);

      expect(favoris.elements.contains(numeroElement), isTrue);
    });
  });
}
