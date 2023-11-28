// dialog_utils.dart

import 'package:flutter/material.dart';

import '../modal/info_store.dart';

Future<void> showDeleteConfirmationDialog(
    BuildContext context, InfoStore infoStore, String info) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirmação de Exclusão'),
      content: const Text('Deseja realmente excluir esta informação?'),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text('Deletar'),
          onPressed: () {
            infoStore.removeInfo(info);
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

void showAlert(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Erro de validação'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
