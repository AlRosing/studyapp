import 'package:flutter/material.dart';

import 'globals.dart' as globals;

/*todo This is a overall to-do list
Figure out overflow issue
Do a default name
Fix the text going invisible
Get a successful run
Work on studying features
 */

void main() {
  runApp(MaterialApp(title: 'StudyApp', initialRoute: '/home', routes: {
    '/': (context) => const MyHomePage(title: 'StudyApp'),
    '/home': (context) => const MyHomePage(title: 'StudyApp'),
    '/SetCreation': (context) => SetCreationPage(),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('StudyApp'),
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
              child: Text("Welcome Back\n\n"),
            ),
            Column(
              children: <Widget>[
                Text("Create Set"),
                Column(
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/SetCreation');
                      },
                      child: Text("Q&A"),
                    ),
                    TextButton(
                      onPressed: () {
                        //todo add Visual Drag&Drop features & navigate to its creation page here
                      },
                      child: Text("Visual Drag&Drop"),
                    ),
                  ],
                ),
                Text("Recent"),
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

class SetCreationPage extends StatefulWidget {
  @override
  _SetCreationPageState createState() => _SetCreationPageState();
}

class _SetCreationPageState extends State<SetCreationPage> {
  int terms = 2;

  @override
  Widget build(BuildContext context) {
    QASet current = QASet();
    List<Widget> info = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text("Name:  "),
          //add text editor
          SizedBox(
            width: 160,
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name here',
              ),
              onSubmitted: (String value) async {
                current.setName(value);
                globals.mySets.add(current);
              },
            ),
          ),
          TextButton(
            onPressed: () {
              globals.mySets.add(current);
              Navigator.pushNamed(context, '/home');
            },
            child: Text("Done"),
          )
        ],
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('StudyApp'),
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
            child: Text(
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text("Name:  "),
          //add text editor
          SizedBox(
            width: 160,
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: current?.getName(),
              ),
              onSubmitted: (String value) async {
                current?.setName(value);
                globals.mySets.setSet(current!, globals.mySets.find(oldName));
              },
            ),
          ),
          TextButton(
            onPressed: () {
              globals.mySets.add(current!);
              Navigator.pushNamed(context, '/home');
            },
            child: Text("X"),
          )
        ],
      ),
    ];
    info.addAll(current!.displayItems(context));
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('StudyApp'),
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
            child: Text(
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

  const EditingItems({super.key, required this.name});

  @override
  _EditingItemsState createState() => _EditingItemsState(name);
}

class _EditingItemsState extends State<EditingItems> {
  String? name;

  _EditingItemsState(String? name) {
    this.name = name;
  }

  @override
  Widget build(BuildContext context) {
    //needs to get name or some sort of identifier as to what set it is
    int setI = globals.mySets.find(name);
    Item toAdd = Item();
    return Scaffold(
      body: Row(
        children: [
          //add text editor
          SizedBox(
            width: 150,
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Term here\t',
              ),
              onSubmitted: (String value) async {
                toAdd.setTerm(value);
              },
            ),
          ),
          SizedBox(
            width: 150,
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Answer here\t',
              ),
              onSubmitted: (String value) async {
                toAdd.setAnswer(value);
              },
            ),
          ),
          TextButton(
            onPressed: () {
              globals.mySets.addItemToSet(toAdd, setI);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewSetPage(
                          current: globals.mySets.get(setI),
                        )),
              );
            },
            child: Text("Done"),
          ),
        ],
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
      setsToDisplay.add(TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewSetPage(
                      current: this.get(i),
                    )),
          );
        },
        child: Text(sets[i].getName()),
      ));
    }
    return setsToDisplay;
  }

  int find(String? n) {
    for (int i = 0; i < sets.length; i++) {
      if (sets[i].getName() == n) return i;
    }
    return -1;
  }

  QASet get(int index) {
    return this.sets[index];
  }

  void add(QASet set) {
    this.sets.add(set);
  }

  void deleteSet(int index) {
    if (index > 0 && index < this.sets.length) this.sets.remove(index);
  }

  void setSet(QASet set, int index) {
    this.sets[index] = set;
  }

  void addItemToSet(Item thing, int index) {
    this.sets[index].addItem(thing);
  }
}

class QASet {
  late String name;
  late List<Item> items;

  QASet() {
    this.name = "";
    Item thing = Item();
    this.items = [thing];
  }

  List<Widget> displayItems(BuildContext context) {
    List<Widget> itemsToDisplay = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      String uno = items[i].getTerm();
      String dos = items[i].getAnswer();
      itemsToDisplay.add(
        TextButton(
          child: Row(
            children: <Widget>[Text(uno), Text(dos)],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditingItems(name: name)),
            );
          },
        ),
      );
    }
    return itemsToDisplay;
  }

  int getLength() {
    return items.length;
  }

  String getName() {
    return this.name;
  }

  void setName(String str) {
    this.name = str;
  }

  void moveItem(int from, int to) {
    if (from > 0 &&
        to > 0 &&
        from < this.items.length &&
        to < this.items.length) {
      Item temp = this.items[from];
      this.items[from] = this.items[to];
      this.items[to] = temp;
    }
  }

  void setTerm(int index, String str) {
    this.items[index].setTerm(str);
  }

  void setAnswer(int index, String str) {
    this.items[index].setAnswer(str);
  }

  String getAnswer(int index) {
    return this.items[index].getAnswer();
  }

  String getTerm(int index) {
    return this.items[index].getTerm();
  }

  Item getItem(int index) {
    return this.items[index];
  }

  void setItem(int index, Item thing) {
    if (index < items.length)
      this.items[index] = thing;
    else if (index == items.length) this.items.add(thing);
  }

  void addItem(Item thing) {
    this.items.add(thing);
  }
}

class Item {
  late String term;
  late String answer;

  Item() {
    this.term = "";
    this.answer = "";
  }

  void setTerm(String str) {
    term = str;
  }

  void setAnswer(String str) {
    answer = str;
  }

  String getTerm() => this.term;

  String getAnswer() => this.answer;
}
