import 'package:flutter/material.dart';

import 'globals.dart' as globals;

/*todo This is a overall to-do list
Figure out overflow issue
Do a default name
//add editing features for the terms
Fix the text going invisible - does text disappear?
Implement wrap-around for text in terms....
Get a successful run
Work on studying features
Errors:
//emulator disappears when click checkmark/enter -FIXED mostly
//issues with duplicates happen once one term has been added -FIXED
//opening a set causes it to save it as a separate one as well unless use StudyApp (home) button-FIXED
//opening a term causes it save it twice as well....-FIXED
//overall issue with editing -FIXED
//need to click enter to save it
//error with PixelFold?? need to update the debugger or smthing -FIXED
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text("Name:  "),
          //add text editor
          SizedBox(
            width: 160,
            child: TextField(
              controller: TextEditingController(),
              decoration: const InputDecoration(
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
            child: const Text("Done"),
          )
        ],
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
          //is it displaying it twice????
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
          Expanded(
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
          ),
          TextButton(
            //issue here
            onPressed: () {
              globals.mySets.setSet(
                  current!,
                  globals.mySets.find(
                      oldName)); //issue - need to check if current already there
              Navigator.pushNamed(context, '/home');
            },
            child: const Text("X"),
          )
        ],
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

  const EditingItems({required this.name, super.key});

  @override
  _EditingItemsState createState() => _EditingItemsState(name);
}

class _EditingItemsState extends State<EditingItems> {
  //todo move down the children in row
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 600, 0, 0),
        child: Row(
          children: [
            //add text editor
            Expanded(
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
            ),
            SizedBox(
              width: 150,
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
            ),
            TextButton(
              //issue here I think
              onPressed: () {
                //print(globals.mySets.get(setI));
                QASet thing = globals.mySets.get(setI);
                thing.addItem(toAdd);
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
      setsToDisplay.add(TextButton(
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
      ));
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

  QASet get(int index) {
    return sets[index];
  }

  void add(QASet set) {
    sets.add(set);
  }

  void deleteSet(int index) {
    if (index > 0 && index < sets.length) sets.remove(index);
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
        TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Text(
                  uno,
                  softWrap: true,
                ),
              ),
              Expanded(
                  child: Text(
                dos,
                softWrap: true,
              )),
            ],
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
