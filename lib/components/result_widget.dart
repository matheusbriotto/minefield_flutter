import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  dynamic wins;
  final VoidCallback onRestart;
  ResultWidget({Key? key, required this.wins, required this.onRestart})
      : super(key: key);

  Color _getColor() {
    if (wins == null) {
      return Colors.yellow;
    } else if (wins) {
      return Colors.green;
    }

    return Colors.red;
  }

  IconData _getIcon() {
    if (wins == null) {
      return Icons.sentiment_satisfied;
    } else if (wins) {
      return Icons.sentiment_very_satisfied;
    }

    return Icons.sentiment_very_dissatisfied;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: onRestart,
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(120);
}
