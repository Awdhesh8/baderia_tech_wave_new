import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../common/widgets/appbar/appbar.dart';

class Training extends StatefulWidget {
  @override
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  final List<String> _items = [
    "Card 1",
    "Card 2",
    "Card 3",
    "Card 4",
    "Card 5",
  ];

  late List<double> _positions;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _positions = List.generate(_items.length, (index) => index * 50.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GAppBar(
        title: Text(
          'Training',
          style: TextStyleClass.appBarTextStyle,
        ),
        showBackArrow: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: _items.map((item) {
                final index = _items.indexOf(item);
                final isOnTop = index == _currentIndex;
                final itemWidget = _buildCard(item);
                return AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: _positions[index],
                  left: 0,
                  right: 0,
                  height: 300,
                  child: GestureDetector(
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity! < 0) {
                        // Swiped up
                        setState(() {
                          _currentIndex = (_currentIndex + 1).clamp(0, _items.length - 1);
                        });
                      } else if (details.primaryVelocity! > 0) {
                        // Swiped down
                        setState(() {
                          _currentIndex = (_currentIndex - 1).clamp(0, _items.length - 1);
                        });
                      }
                    },
                    child: itemWidget,
                  ),
                );
              }).toList(),
            ),
          ),
          // Add other widgets below the swiping cards
        ],
      ),
    );
  }

  Widget _buildCard(String item) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: ListTile(
        title: Text(item),
        leading: Icon(FontAwesomeIcons.solidCircle),
      ),
    );
  }
}



/*
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../common/widgets/appbar/appbar.dart';

class Training extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GAppBar(
        title: Text('Training', style: TextStyleClass.appBarTextStyle,),
        showBackArrow: true,
      ),

    );
  }
}



 */