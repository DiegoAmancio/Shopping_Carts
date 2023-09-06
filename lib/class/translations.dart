import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'total': 'Total',
          'in_the_cart': 'In the cart',
          'lists': 'Lists',
          'name_of_list': 'Name of list',
          'save': 'Save',
          'out_of_cart': 'Out of cart',
          'product_name': 'Product name',
          'quantity': 'Quantity',
          'price_per_unity': 'Price per unity',
          'edit': 'Edit',
          'remove': 'Remove',
          'insert_to_cart': 'Insert to cart'
        },
        'pt_BR': {
          'total': 'Total',
          'in_the_cart': 'No carrinho',
          'lists': 'Listas',
          'name_of_list': 'Nome da lista',
          'salvar': 'Salvar',
          'out_of_cart': 'Fora do carrinho',
          'product_name': 'Nome do produto',
          'quantity': 'Quantidade',
          'price_per_unity': 'Preço por unidade',
          'edit': 'Editar',
          'remove': 'Remover',
          'insert_to_cart': 'Inserir no carrinho'
        }
      };
}
