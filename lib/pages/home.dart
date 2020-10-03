import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 2),
    Band(id: '2', name: 'Queen', votes: 3),
    Band(id: '3', name: 'Héroes del Silencio', votes: 1),
    Band(id: '4', name: 'Bon Jovi', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Center(
          child: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i]),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBand,
        child: Icon(Icons.add),
        elevation: 1,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
        key: Key(band.id),
        child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
      background: Container(
        padding: EdgeInsets.only(right: 10.0),
        color: Colors.red,
        child: Align(child: Text('Delete Band', style: TextStyle(
          color: Colors.white
        ),), alignment: Alignment.centerRight,),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        // TODO: DELETE BAND
      },
    );
  }

  _addNewBand() {
    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Band Name'),
            content: TextField(controller: textController),
            actions: [
              MaterialButton(
                onPressed: () => _addBandToList(textController.text),
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
              )
            ],
          );
        },
      );
    } else {
      showCupertinoDialog(
        context: null,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('New Band Name'),
            content: CupertinoTextField(
              controller: textController,
              placeholder: 'The Beatles',
            ),
            actions: [
              CupertinoDialogAction(
                child: Text('Add'),
                isDefaultAction: true,
                onPressed: () => _addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                child: Text('Cancel'),
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }

  void _addBandToList(String name) {
    Navigator.pop(context);
    // Error
    if (name.length == 0) {
      return;
    }
    this.bands.add(Band(
          id: DateTime.now().toString(),
          name: name,
          votes: 0,
        ));
    setState(() {});
  }
}
