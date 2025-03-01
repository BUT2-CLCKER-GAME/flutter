import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/player_view_model.dart';
import '../viewmodels/upgrade_view_model.dart';

class UpgradeWidget extends StatelessWidget {
  const UpgradeWidget({super.key});

  static const int maxLevel = 5;

  @override
  Widget build(BuildContext context) {
    PlayerViewModel player = context.watch<PlayerViewModel>();
    UpgradeViewModel upgrade = context.watch<UpgradeViewModel>();

    bool isUnlocked = player.level >= upgrade.unlockLevel;
    bool canAfford = player.gold >= upgrade.price;
    bool isMaxLevel = upgrade.level >= maxLevel;
    bool isBought = upgrade.level > 0;

    void onClick() {
      upgrade.click(player);
    }

    return Opacity(
      opacity: isUnlocked ? 1.0 : 0.5,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      upgrade.name,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      upgrade.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isBought) Align(
                    alignment: Alignment.centerRight,
                    child: _buildLevelIndicator(upgrade.level),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: (isUnlocked && canAfford && !isMaxLevel) ? onClick : null,
                    icon: Icon(Icons.shopping_cart),
                    label: Text(isMaxLevel ? "Max" : "${isBought ? 'améliorer' : 'acheter'} (${upgrade.price}g)"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelIndicator(int level) {
    return Row(
      children: List.generate(maxLevel, (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Icon(
            index < level ? Icons.circle : Icons.circle_outlined,
            size: 12,
            color: index < level ? Colors.amber : Colors.grey,
          ),
        ),
      ),
    );
  }
}