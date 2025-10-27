import 'package:flutter/material.dart';

void main() {
  runApp(MonAppli());
}

class MonAppli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magazine',
      debugShowCheckedModeBanner: false,
      home: pageAccueil(),
    );
  }
}

class pageAccueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magazine Infos'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Center(child: Image.asset('assets/images/magazineInfo.jpg')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Text('Click'),
        onPressed: () {
          print('Tu as cliqué dessus');
        },
      ),
    );
  }
}
