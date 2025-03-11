import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/enemy_manager_view_model.dart';
import '../widgets/enemy_manager_widget.dart';
import '../widgets/shop_widget.dart';
import '../viewmodels/player_view_model.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<StatefulWidget> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  static const double _buttonHeight = 50;

  final ScrollController _scrollController = ScrollController();
  bool _isAtTop = true;

  void _toggleView(double contentHeight) {
    _scrollController.animateTo(
      _isAtTop ? contentHeight : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      _isAtTop = !_isAtTop;
    });
  }

  Widget displayStats(PlayerViewModel player) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${player.gold} gold'),
          Text('${player.experience} exp'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PlayerViewModel player = context.watch<PlayerViewModel>();
    final double screenHeight = MediaQuery.of(context).size.height;
    final double contentHeight = screenHeight - _buttonHeight;

    return Theme(
      data: Theme.of(context).copyWith(
        scrollbarTheme: ScrollbarThemeData(
          thickness: WidgetStateProperty.all(0),
        ),
      ),
      child: Scaffold(
        body: Scrollbar(
          controller: _scrollController,
          thumbVisibility: false,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [

                // --- TOP SECTION (BATTLE) ---
                SizedBox(
                  height: contentHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              player.name,
                              style: const TextStyle(fontSize: 30),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/settings');
                                  },
                                  child: const Icon(Icons.settings),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/leaderboard');
                                  },
                                  child: const Icon(Icons.leaderboard),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: ChangeNotifierProvider(
                            create: (context) => EnemyManagerViewModel(player),
                            child: const EnemyManagerWidget(),
                          ),
                        ),
                      ),
                      displayStats(player),
                    ],
                  ),
                ),

                // --- BUTTON TOGGLE SECTION ---
                SizedBox(
                  height: _buttonHeight,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () => _toggleView(contentHeight),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, double.infinity),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            _isAtTop ? Icons.arrow_downward : Icons.arrow_upward,
                          ),
                          Text(
                            _isAtTop ? "Go to Shop" : "Go to Battle",
                          ),
                          Icon(
                            _isAtTop ? Icons.arrow_downward : Icons.arrow_upward,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // --- SECOND SECTION (SHOP) ---
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: contentHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          displayStats(player),
                          const Expanded(
                            child: ShopWidget(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}