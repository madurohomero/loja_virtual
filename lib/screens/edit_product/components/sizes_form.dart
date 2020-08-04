import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/item_size.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/screens/edit_product/components/edit_item_size.dart';

class SizesForm extends StatelessWidget {
  SizesForm(this.product);

  final Product product;
  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: product.sizes,
      builder: (state) {
        return Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Tamanhos',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.add,
                  color: Colors.black,
                  onTap: () {
                    state.value.add(ItemSize());
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              children: state.value.map((size) {
                return EditItemSize(
                  key: ObjectKey(size),
                  size: size,
                  onRemove: () {
                    state.value.remove(size);
                    state.didChange(state.value);
                  },
                  onMoveUp: () {
                    final index = state.value.indexOf(size);
                    state.value.remove(size);
                    state.value.insert(index - 1, size);
                    state.didChange(state.value);
                  },
                  onMoveDown: () {
                    final index = state.value.indexOf(size);
                    state.value.remove(size);
                    state.value.insert(index + 1, size);
                    state.didChange(state.value);
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
