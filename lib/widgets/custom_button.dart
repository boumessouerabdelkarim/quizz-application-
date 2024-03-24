import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width = 140,
  }) : super(key: key);

  final Function() onPressed;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      // Utilisation du widget FloatingActionButton.extended pour un bouton avec du texte et une icône
      child: FloatingActionButton.extended(
        backgroundColor: KPrimaryColor, // Couleur de fond du bouton
        onPressed: onPressed, // Fonction appelée lorsque le bouton est pressé
        label: Text(
          text, // Texte affiché sur le bouton
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white, // Couleur du texte
                fontWeight: FontWeight.bold, // Gras
              ),
        ),
      ),
    );
  }
}
