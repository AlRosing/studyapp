import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'globals.dart' as globals;

/*todo This is a overall to-do list
Figure out overflow issue
Add deleting items & sets.
implement scrolling(ListView class might be useful for this)
Get a successful run
Work on studying features

Changes:
made it so that you can edit items (change them)
checked & implemented text wrap-around for terms
made it so that you can delete both items and sets
changed a bit of the look - for the terms & for the done button(replaced with check mark)
 */

void main() {
  runApp(MaterialApp(title: 'StudyApp', initialRoute: '/home', routes: {
    '/': (context) => const MyHomePage(title: 'StudyApp'),
    '/home': (context) => const MyHomePage(title: 'StudyApp'),
    '/SetCreation': (context) => const SetCreationPage(),
  }));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  //Sets mySets = Sets();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //todo make it so that the sets show on the home screen
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('StudyApp'),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: const Text('StudyApp'))
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: const Text("Welcome Back\n\n"),
            ),
            Column(
              children: <Widget>[
                const Text("Create Set"),
                Column(
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/SetCreation');
                      },
                      child: const Text("Q&A"),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              body: Center(
                                child: Text(
                                  "Not implemented yet, sorry!\nPress the escape key to return.",
                                ),
                              ),
                            ),
                            barrierDismissible: true,
                            fullscreenDialog: false,
                          ),
                        );
                      },
                      child: const Text("Visual Drag&Drop"),
                    ),
                  ],
                ),
                const Text("Recent"),
                Column(
                  children: globals.mySets.displaySets(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorNotImplemented extends StatefulWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Error: Not implemented yet"),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class SetCreationPage extends StatefulWidget {
  const SetCreationPage({super.key});

  @override
  _SetCreationPageState createState() => _SetCreationPageState();
}

class _SetCreationPageState extends State<SetCreationPage> {
  @override
  Widget build(BuildContext context) {
    QASet current = QASet();
    List<Widget> info = [
      Row(
        children: <Widget>[
          const Text("Name:  "),
          //add text editor
          Flexible(
            fit: FlexFit.tight,
            child: TextField(
              controller: TextEditingController(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name here',
              ),
              onSubmitted: (String value) async {
                current.setName(value);
              },
            ),
          ),
          IconButton(
            onPressed: () {
              globals.mySets.add(current);
              Navigator.pushNamed(context, '/home');
            },
            icon: Icon(
              Icons.check,
              color: Colors.green[800],
              size: 30,
            ),
          )
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('StudyApp'),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: const Text('StudyApp')),
        ],
      ),
      body: Column(
        children: [
          Column(children: info),
          Column(children: current.displayItems(context)),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditingItems(name: current.getName())),
              );
            },
            child: const Text(
              '+',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          //name stuff
          //terms
        ],
      ),
    );
  }
}

class ViewSetPage extends StatefulWidget {
  final QASet? current;

  const ViewSetPage({super.key, required this.current});

  @override
  _ViewSetPageState createState() => _ViewSetPageState(current);
}

//todo make it so that you can delete pairs
class _ViewSetPageState extends State<ViewSetPage> {
  QASet? current;
  String? oldName;

  _ViewSetPageState(this.current) {
    oldName = current!.getName();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> info = [
      Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: current!.getName(),
              ),
              onSubmitted: (String value) async {
                current!.setName(value);
                globals.mySets.setSet(current!, globals.mySets.find(oldName));
              },
            ),
            fit: FlexFit.loose,
          ),
          IconButton(
            //issue here
            icon: Icon(
              Icons.check,
              color: Colors.green[800],
              size: 30,
            ),
            onPressed: () {
              globals.mySets.setSet(current!, globals.mySets.find(oldName));
              Navigator.pushNamed(context, '/home');
            },
          )
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('StudyApp'),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: const Text('StudyApp')),
        ],
      ),
      body: Column(
        children: [
          Column(children: info),
          Column(children: current!.displayItems(context)),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditingItems(name: current!.getName())),
              );
            },
            child: const Text(
              '+',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          //name stuff
          //terms
        ],
      ),
    );
  }
}

class EditingItems extends StatefulWidget {
  final String? name;
  final int? index;

  const EditingItems({required this.name, this.index, super.key});

  @override
  _EditingItemsState createState() => _EditingItemsState(name, index);
}

class _EditingItemsState extends State<EditingItems> {
  String? name;
  int? index;

  _EditingItemsState(String? name, int? i) {
    this.name = name;
    index = i;
  }

  @override
  Widget build(BuildContext context) {
    //needs to get name or some sort of identifier as to what set it is
    int setI = globals.mySets.find(name);
    Item toAdd = Item();
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            //add text editor
            Flexible(
              child: TextField(
                controller: TextEditingController(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Term here\t',
                ),
                onChanged: (String value) async {
                  toAdd.setTerm(value);
                },
                onSubmitted: (String value) async {
                  toAdd.setTerm(value);
                },
              ),
              fit: FlexFit.tight,
            ),
            Flexible(
              child: TextField(
                controller: TextEditingController(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Answer here\t',
                ),
                onChanged: (String value) async {
                  toAdd.setAnswer(value);
                },
                onSubmitted: (String value) async {
                  toAdd.setAnswer(value);
                },
              ),
              fit: FlexFit.tight,
            ),
            TextButton(
              //issue here I think
              onPressed: () {
                //print(globals.mySets.get(setI));
                QASet thing = globals.mySets.get(setI)!;
                if (index == null) {
                  thing.addItem(toAdd);
                } else {
                  thing.setItem(index!, toAdd);
                }
                globals.mySets.setSet(thing, setI);
                //.addItemToSet(toAdd, setI); //problem might be here
                //print(globals.mySets.get(setI));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewSetPage(
                      current: globals.mySets.get(setI),
                    ),
                  ),
                );
              },
              child: const Text("Done"),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
    /*IconButton(
    //adds stuff each time it is pressed
    //should only show when the mouse is hovering over it
      onPressed: () {
      },
      //Icon:
    ),*/
  }
}

//textediting
/*class InputText extends StatefulWidget {
  const InputText({super.key});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late TextEditingController _controller;
  late String text;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getText() {
    return this.text;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter text here',
      ),
      onSubmitted: (String value) async {
        text = value;
      },
    );
  }
}*/

//IMPORTANT Information holding
class Sets {
  late List<QASet> sets;

  Sets() {
    sets = [];
  }

  List<Widget> displaySets(BuildContext context) {
    List<Widget> setsToDisplay = <Widget>[];
    for (int i = 0; i < sets.length; i++) {
      //todo put list in center
      setsToDisplay.add(
        Row(
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewSetPage(
                            current: get(i),
                          )),
                );
              },
              child: Text(
                sets[i].getName(),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: () {
                print(globals.mySets);
                globals.mySets.deleteSet(i);
                print(globals.mySets);
                Navigator.pushNamed(context, '/home');
              },
              icon: Icon(
                CupertinoIcons.trash,
                size: 15,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
    }
    print(sets.toString());
    return setsToDisplay;
  }

  int find(String? n) {
    for (int i = 0; i < sets.length; i++) {
      if (sets[i].getName() == n) return i;
    }
    return -1;
  }

  QASet? get(int index) {
    if (index > -1 && index < sets.length)
      return sets[index];
    else {
      return null;
    }
  }

  void add(QASet set) {
    sets.add(set);
  }

  void deleteSet(int index) {
    if (index > -1 && index < sets.length) sets.removeAt(index);
  }

  void setSet(QASet set, int index) {
    print(set.toString() + "\n");
    print(index.toString() + "\n");
    sets[index] = set;
    print(sets[index].toString() + "\n");
    print(sets.toString() + "\n");
  }

  void addItemToSet(Item thing, int index) {
    sets[index].addItem(thing);
  }

  @override
  String toString() {
    String str = "[";
    for (int i = 0; i < sets.length; i++) {
      str = "$str${sets[i]}, ";
    }
    str = "$str]";
    return str;
  }
}

class QASet {
  late String name;
  late List<Item> items;

  QASet() {
    name = "Unnamed";
    Item thing = Item();
    items = [thing];
  }

  List<Widget> displayItems(BuildContext context) {
    //no issues here
    List<Widget> itemsToDisplay = <Widget>[];
    print("LENGTH: " + items.length.toString());
    for (int i = 0; i < items.length; i++) {
      String uno = items[i].getTerm();
      String dos = items[i].getAnswer();
      print("IN LOOP:\n" +
          "i=" +
          i.toString() +
          "\nuno='" +
          uno +
          "'\ndos='" +
          dos +
          "'\nEnd of loop");
      itemsToDisplay.add(
        ElevatedButton(
          child: Row(
            children: <Widget>[
              Flexible(
                child: Text(
                  uno,
                  softWrap: true,
                ),
                fit: FlexFit.tight,
              ),
              Spacer(),
              Flexible(
                child: Text(
                  dos,
                  softWrap: true,
                ),
                fit: FlexFit.tight,
              ),
              IconButton(
                onPressed: () {
                  this.deleteItem(i);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewSetPage(
                        current: this,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  CupertinoIcons.trash,
                  size: 15,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditingItems(name: name, index: i)),
            );
          },
        ),
      );
    }
    print(this.toString() + "574");
    return itemsToDisplay;
  }

  int getLength() {
    return items.length;
  }

  String getName() {
    return name;
  }

  void setName(String str) {
    name = str;
  }

  void moveItem(int from, int to) {
    if (from > 0 && to > 0 && from < items.length && to < items.length) {
      Item temp = items[from];
      items[from] = items[to];
      items[to] = temp;
    }
  }

  void setTerm(int index, String str) {
    items[index].setTerm(str);
  }

  void setAnswer(int index, String str) {
    items[index].setAnswer(str);
  }

  String getAnswer(int index) {
    return items[index].getAnswer();
  }

  String getTerm(int index) {
    return items[index].getTerm();
  }

  Item getItem(int index) {
    return items[index];
  }

  void setItem(int index, Item thing) {
    if (index < items.length) {
      items[index] = thing;
    } else if (index == items.length) {
      items.add(thing);
    }
  }

  void addItem(Item thing) {
    items.add(thing);
  }

  void deleteItem(int index) {
    if (index > -1 && index < items.length) items.removeAt(index);
  }

  @override
  String toString() {
    String str = "$name: [";
    for (int i = 0; i < items.length; i++) {
      str = "$str${items[i]}, ";
    }
    str = "$str]";
    return str;
  }
}

class Item {
  late String term;
  late String answer;

  Item() {
    term = "term";
    answer = "answer";
  }

  void setTerm(String str) {
    term = str;
  }

  void setAnswer(String str) {
    answer = str;
  }

  String getTerm() => term;

  String getAnswer() => answer;

  @override
  String toString() => "[$term, $answer]";
}
