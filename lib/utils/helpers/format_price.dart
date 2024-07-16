String formatPrice(num prix) {
  if (prix.toString().isEmpty) {
    return prix.toString();
  }
  String prixFormate = prix
      .toStringAsFixed(0); // Convertir le prix en chaîne avec deux décimales

  // Séparer la partie entière de la partie décimale
  List<String> parties = prixFormate.split('.');
  String partieEntiere = parties[0];
  String partieDecimale = parties.length > 1 ? '.${parties[1]}' : '';

  // Ajouter des espaces pour chaque groupe de trois chiffres dans la partie entière
  String partieEntiereFormatee = '';
  for (int i = 0; i < partieEntiere.length; i++) {
    partieEntiereFormatee += partieEntiere[i];
    if ((partieEntiere.length - i - 1) % 3 == 0 &&
        i != partieEntiere.length - 1) {
      partieEntiereFormatee +=
          ' '; // Ajouter un espace après chaque groupe de trois chiffres, sauf pour le dernier groupe
    }
  }

  // Concaténer la partie entière formatée avec la partie décimale
  return '$partieEntiereFormatee$partieDecimale FCFA';
}
