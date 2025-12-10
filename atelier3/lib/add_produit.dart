import 'package:flutter/material.dart';

class AddProduit extends StatelessWidget {
  final TextEditingController nomController;
  final void Function()? onAdd;
  final void Function()? onCancel;

  const AddProduit({
    super.key,
    required this.nomController,
    required this.onAdd,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Ajouter un produit"),
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: nomController,
              decoration: const InputDecoration(
                labelText: "Nom du produit",
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: onCancel,
                  color: Colors.grey[300],
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 8),
                MaterialButton(
                  onPressed: onAdd,
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: const Text("Add"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
