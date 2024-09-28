import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);
    return Container(
      width: 300,
      height: 60,
      padding: EdgeInsets.only(left: 16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Your Name',
                hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            width: 5,
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
          ),
          Container(
            height: 60,
            width: 48,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .buttonTheme
                  .colorScheme!
                  .primary, // The orange color
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30)),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_forward,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                // Action when button is pressed
              },
            ),
          ),
        ],
      ),
    );
  }
}
