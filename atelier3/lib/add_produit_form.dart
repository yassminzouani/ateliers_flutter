import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'model/produit.dart';

class AddProduitForm extends StatefulWidget {
  final Function(Produit) onAddProduit;

  AddProduitForm({required this.onAddProduit});

  @override
  _AddProduitFormState createState() => _AddProduitFormState();
}

class _AddProduitFormState extends State<AddProduitForm> {
  final _formKey = GlobalKey<FormState>();

  // a) Produit initialisé vide
  Produit _produit = Produit(
    libelle: '',
    description: '',
    prix: 0.0,
    photo: '',
  );

  // b) Chemin image sélectionnée
  String? _pickedImagePath;

  // c) Méthode pour sélectionner image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImagePath = pickedFile.path;
        _produit.photo = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un produit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              // Champ libelle
              TextFormField(
                decoration: InputDecoration(labelText: "Nom du produit"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Champ obligatoire" : null,
                onSaved: (value) => _produit.libelle = value!,
              ),

              // Champ description
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Champ obligatoire" : null,
                onSaved: (value) => _produit.description = value!,
              ),

              // Champ prix
              TextFormField(
                decoration: InputDecoration(labelText: "Prix"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Champ obligatoire" : null,
                onSaved: (value) =>
                    _produit.prix = double.tryParse(value!) ?? 0.0,
              ),

              SizedBox(height: 20),

              // Bouton image
              ElevatedButton(
                onPressed: _pickImage,
                child: Text("Sélectionner une image"),
              ),

              if (_pickedImagePath != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.file(
                    File(_pickedImagePath!),
                    height: 100,
                  ),
                ),

              SizedBox(height: 20),

              // Bouton valider
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    widget.onAddProduit(_produit);
                    Navigator.pop(context);
                  }
                },
                child: Text("Ajouter"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
