import 'package:dokkan/core/res/color_manager.dart';
import 'package:flutter/material.dart';

class FilledCartScreen extends StatefulWidget {
  const FilledCartScreen({
    super.key,
    required this.onCartEmptied,
  });

  final VoidCallback onCartEmptied;

  @override
  State<FilledCartScreen> createState() => _FilledCartScreenState();
}

class _FilledCartScreenState extends State<FilledCartScreen> {
  int _quantity = 1;

  static const double _price = 149;

  double get _total => _price * _quantity;

  void _removeProduct() {
    widget.onCartEmptied();
  }

  void _decreaseQuantity() {
    if (_quantity <= 1) {
      _removeProduct();
      return;
    }

    setState(() => _quantity--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorM.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shopping Bag',
                          style: TextStyle(
                            color: ColorM.textPrimaryLight,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          '1 handcrafted item',
                          style: TextStyle(
                            color: ColorM.textSecondaryLight,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _removeProduct,
                    style: TextButton.styleFrom(
                      foregroundColor: ColorM.danger,
                      backgroundColor: ColorM.dangerContainerLight,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    child: const Text(
                      'Clear Bag',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                children: [
                  _buildProductCard(),
                  const SizedBox(height: 12),
                  _buildOrderSummary(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _CartBottomNavigation(),
    );
  }

  Widget _buildProductCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorM.surfaceLight,
        border: Border.all(color: ColorM.borderLight),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 68,
            decoration: BoxDecoration(
              color: ColorM.surfaceLightSubtle,
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.watch_outlined,
              color: ColorM.textSecondaryLight,
              size: 32,
            ),
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Heritage Chronograph Steel',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorM.textPrimaryLight,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Espresso Leather • 42mm',
                  style: TextStyle(
                    color: ColorM.textSecondaryLight,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 11),
                Text(
                  '\$149.00',
                  style: TextStyle(
                    color: ColorM.primaryDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: _removeProduct,
                icon: const Icon(Icons.close, size: 16),
                color: ColorM.textMutedLight,
                constraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 30,
                ),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 6),
              _buildQuantityControl(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControl() {
    return Container(
      height: 28,
      decoration: BoxDecoration(
        color: ColorM.surfaceLightElevated,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _quantityButton(
            icon: Icons.remove,
            onTap: _decreaseQuantity,
          ),
          SizedBox(
            width: 22,
            child: Text(
              '$_quantity',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorM.textPrimaryLight,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _quantityButton(
            icon: Icons.add,
            onTap: () => setState(() => _quantity++),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 27,
        height: 28,
        child: Icon(
          icon,
          size: 13,
          color: ColorM.textSecondaryLight,
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorM.surfaceLight,
        border: Border.all(color: ColorM.borderLight),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              color: ColorM.textPrimaryLight,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 11),
          _summaryRow(
            'Subtotal ($_quantity item${_quantity == 1 ? '' : 's'})',
            '\$${_total.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 8),
          _summaryRow(
            'Standard Insured Shipping',
            'FREE',
            valueColor: ColorM.success,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1, color: ColorM.borderLight),
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Estimated Total',
                  style: TextStyle(
                    color: ColorM.textPrimaryLight,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '\$${_total.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: ColorM.primaryDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Expanded(
                child: Text(
                  '256-bit encrypted checkout & complimentary 30-day returns',
                  style: TextStyle(
                    color: ColorM.textMutedLight,
                    fontSize: 8,
                  ),
                ),
              ),
              Icon(
                Icons.lock_outline,
                size: 12,
                color: ColorM.textMutedLight,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String label,
    String value, {
    Color valueColor = ColorM.textPrimaryLight,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: ColorM.textSecondaryLight,
              fontSize: 10,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _CartBottomNavigation extends StatelessWidget {
  const _CartBottomNavigation();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 62,
        decoration: const BoxDecoration(
          color: ColorM.surfaceLight,
          border: Border(top: BorderSide(color: ColorM.borderLight)),
        ),
        child: const Row(
          children: [
            _NavItem(icon: Icons.home_outlined, label: 'Home'),
            _NavItem(
              icon: Icons.shopping_bag_outlined,
              label: 'Cart',
              selected: true,
            ),
            _NavItem(icon: Icons.person_outline, label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? ColorM.primary : ColorM.textSecondaryLight;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 21, color: color),
          const SizedBox(height: 3),
          Text(label, style: TextStyle(color: color, fontSize: 10)),
        ],
      ),
    );
  }
}