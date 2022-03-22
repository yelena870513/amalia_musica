import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
              prefixIcon: IconButton(
                  onPressed: () {
                    const snackBar = SnackBar(
                      content: Text('A buscar!!'),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  icon: const Icon(Icons.search)),
              suffixIcon: const Icon(Icons.clear),
              hintText: 'Buscar...',
              border: InputBorder.none),
          onSubmitted: (String value) {
            if (kDebugMode) {
              print(value);
            }
          },
        ),
      ),
    );
  }
}
