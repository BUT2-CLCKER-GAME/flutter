import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/upgrades/upgrade_model.dart';
import '../services/player_service.dart';
import 'upgrade_widget.dart';
import '../viewmodels/player_view_model.dart';
import '../viewmodels/upgrade_view_model.dart';

class ShopWidget extends StatefulWidget {
  const ShopWidget({super.key});

  @override
  _ShopWidgetState createState() => _ShopWidgetState();
}

class _ShopWidgetState extends State<ShopWidget> {
  Future<List<Map<String, dynamic>>?>? _futureUpgradeTypes;

  @override
  void initState() {
    super.initState();
    _futureUpgradeTypes = PlayerService.getInstance().upgradeService.fetchUpgradeTypes();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: FutureBuilder<List<Map<String, dynamic>>?>(
        future: _futureUpgradeTypes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text("Erreur de chargement des améliorations"));
          }

          List<Map<String, dynamic>> upgradeTypes = snapshot.data!;

          return DefaultTabController(
            length: upgradeTypes.length,
            child: Column(
              children: [
                TabBar(
                  tabs: upgradeTypes.map((type) => Tab(text: type["name"])).toList(),
                ),
                Expanded(
                  child: TabBarView(
                    children: upgradeTypes.map((type) {
                      PlayerViewModel player = context.watch<PlayerViewModel>();

                      int typeId = type["id"];
                      List<UpgradeModel> upgrades = player.upgrades
                          .where((upgrade) => upgrade.isType(typeId))
                          .toList();

                      return ListView.builder(
                        itemCount: upgrades.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: UpgradeViewModel(upgrades[index]),
                            child: UpgradeWidget(),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
