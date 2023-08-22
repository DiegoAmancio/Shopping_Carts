import 'package:flutter/material.dart';

import '../class/list_tab_item.dart';
import '../molecules/list.dart';

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final availableHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping list',
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10, // <-- SEE HERE
            ),
            const Text('Listas de produtos',
                style: TextStyle(
                  fontSize: 18,
                )),
            const SizedBox(
              height: 10, // <-- SEE HERE
            ),
            SizedBox(
                height: availableHeight * 0.7,
                child: ListItemTabs(
                  items: [
                    ListTabItem(
                      id: '123',
                      name: 'Geladeira',
                      date: DateTime.now(),
                    ),
                    ListTabItem(
                      id: '123',
                      name: 'Frigobar',
                      date: DateTime.now(),
                    )
                  ],
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
