import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'globals.dart' as globals;

/*todo This is a overall to-do list
Work on studying features
Change look of terms as buttons - becomes too circular the longer the text gets
Work on aesthetics
Put plus button at top as well
Add way to add terms more quickly

Changes:
Separated ViewSetPage from SetCreationPage, making SetCreationPage the primary editing & creating page for sets
ViewSetPage now has editing & studying button
Added studying
Replaced "Home" button text with a home icon
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
      ),
      body: Center(
        child: SingleChildScrollView(
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
            mainAxisSize: MainAxisSize.min,
          ),
        ),
      ),
    );
  }
}

class SetCreationPage extends StatefulWidget {
  final int? setI;

  const SetCreationPage({super.key, this.setI});

  @override
  _SetCreationPageState createState() => _SetCreationPageState(this.setI);
}

class _SetCreationPageState extends State<SetCreationPage> {
  int? setI;

  _SetCreationPageState(int? i) {
    this.setI = i;
  }

  @override
  Widget build(BuildContext context) {
    QASet current;
    bool added;
    int i = globals.mySets.length();
    String hint;
    if (setI == null) {
      current = QASet();
      added = false;
      hint = "Enter name here";
    } else {
      if (globals.mySets.get(setI!) == null)
        current = QASet();
      else
        current = globals.mySets.get(setI!)!;
      added = true;
      hint = current.getName();
    }

    List<Widget> info = [
      Row(
        children: <Widget>[
          const Text("Name:  "),
          Flexible(
            fit: FlexFit.tight,
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: hint,
              ),
              onSubmitted: (String value) async {
                current.setName(value);
                if (added == false) {
                  globals.mySets.add(current);
                  added = true;
                  setI = i;
                } else {
                  globals.mySets.setSet(current, setI!);
                }
              },
            ),
          ),
          IconButton(
            onPressed: () {
              if (added == false) {
                globals.mySets.add(current);
                setI = i;
              } else {
                globals.mySets.setSet(current, setI!);
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewSetPage(setI: this.setI!),
                ),
              );
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
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: Icon(
              Icons.home,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(children: info),
            Column(children: current.displayItemsforEditing(context)),
            ElevatedButton(
              onPressed: () {
                if (setI == null) {
                  setI = globals.mySets.find(current.getName());
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditingItems(setI: this.setI!)),
                );
              },
              child: const Text(
                '+',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}

class ViewSetPage extends StatefulWidget {
  final int setI;

  const ViewSetPage({super.key, required this.setI});

  @override
  _ViewSetPageState createState() => _ViewSetPageState(setI);
}

class _ViewSetPageState extends State<ViewSetPage> {
  int setI;

  _ViewSetPageState(this.setI);

  @override
  Widget build(BuildContext context) {
    print("ViewSetPage");
    QASet current = globals.mySets.get(setI)!;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('StudyApp'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: Icon(
              Icons.home,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "\n${current.getName()}",
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnterQFormat(setI: setI)));
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.blue),
                  ),
                  child: const Text(
                    "Study",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    //editing button
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SetCreationPage(setI: setI)),
                    );
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.blue),
                  ),
                  child: const Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: current.displayItems(context),
              mainAxisSize: MainAxisSize.min,
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}

//reasonably shouldn't need any scrolling here.....
class EditingItems extends StatefulWidget {
  final int setI;
  final int? index;

  const EditingItems({required this.setI, this.index, super.key});

  @override
  _EditingItemsState createState() => _EditingItemsState(setI, index);
}

class _EditingItemsState extends State<EditingItems> {
  int setI;
  int? index;

  _EditingItemsState(this.setI, this.index);

  @override
  Widget build(BuildContext context) {
    print("EditingItems");
    //needs to get name or some sort of identifier as to what set it is
    Item toAdd = Item();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('StudyApp'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: Icon(
              Icons.home,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
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
                //print(setI);
                //print(globals.mySets.get(setI));
                QASet thing = globals.mySets.get(setI)!; //returning null
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
                    builder: (context) => SetCreationPage(setI: setI),
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
  }
}

class EnterQFormat extends StatefulWidget {
  final int setI;

  const EnterQFormat({required this.setI, super.key});

  @override
  _EnterQFormatState createState() => _EnterQFormatState(setI);
}

class _EnterQFormatState extends State<EnterQFormat> {
  int setI;

  _EnterQFormatState(this.setI);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String begin = "";
    String ending = "";
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text("Enter Question Format (put <term> in place of the term):"),
              Flexible(
                fit: FlexFit.tight,
                child: TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter question here',
                  ),
                  onChanged: (String value) async {
                    int i = value.indexOf("<term>");
                    if (i == -1) {
                      begin = value;
                    } else {
                      begin = value.substring(0, i);
                      ending = value.substring(i + 6);
                    }
                  },
                  onSubmitted: (String value) async {
                    //do string stuff - divide it into begin and ending
                    int i = value.indexOf("<term>");
                    if (i == -1) {
                      begin = value;
                    } else {
                      begin = value.substring(0, i);
                      ending = value.substring(i + 6);
                    }
                  },
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewSetPage(setI: setI)));
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.red),
                    ),
                    child: Container(
                      child: Text(
                        "Exit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      width: 54,
                      color: Colors.red,
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      //go to studying - provide begin & ending as values
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QAStudyPage(
                                  setI: setI, begin: begin, ending: ending)));
                      //todo
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.blue),
                    ),
                    child: Container(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      width: 54,
                      color: Colors.blue,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
              ),
            ],
          ),
          color: Colors.grey[500],
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.fromLTRB(30, 310, 30, 310),
        ),
      ),
    );
  }
}

//class to pick the study set & do it
class QAStudyPage extends StatefulWidget {
  final String begin;
  final String ending;
  final int setI;
  final int? itemI;

  const QAStudyPage(
      {super.key,
      required this.setI,
      required this.begin,
      required this.ending,
      this.itemI});

  @override
  _QAStudyPageState createState() => _QAStudyPageState(
      setI: this.setI, begin: this.begin, ending: this.ending);
}

class _QAStudyPageState extends State<QAStudyPage> {
  final String begin;
  final String ending;
  final int setI;

  //todo add grade trackers
  _QAStudyPageState(
      {required this.setI, required this.begin, required this.ending});

  int randomItem() {
    int len = globals.mySets.get(setI)!.getLength();
    final random = Random();
    return random.nextInt(len);
  } //for later

  Widget response(BuildContext context, i) {
    String q = begin + globals.mySets.get(setI)!.getTerm(i) + ending;
    String response = "";
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                q,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Response',
                  ),
                  onSubmitted: (String value) async {
                    response = value;
                  },
                ),
              ),
              Row(
                children: [
                  IconButton.filled(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                    ),
                    onPressed: () {
                      int nextI;
                      if (i > 0)
                        nextI = i - 1;
                      else
                        nextI = globals.mySets.get(setI)!.getLength() - 1;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  this.response(context, nextI)));
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewSetPage(setI: setI)));
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.red),
                    ),
                    child: Container(
                      child: Text(
                        "Exit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      width: 54,
                      color: Colors.red,
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  this.answer(context, response, i)));
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.blue),
                    ),
                    child: Container(
                      child: Text(
                        "See Answer",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      width: 54,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton.filled(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 30,
                    ),
                    onPressed: () {
                      int nextI;
                      int longest = globals.mySets.get(setI)!.getLength() - 1;
                      if (i < longest) {
                        nextI = i + 1;
                      } else
                        nextI = 0;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  this.response(context, nextI)));
                    },
                  ),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          color: Colors.grey[500],
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.fromLTRB(30, 200, 30, 200),
        ),
      ),
    );
  }

  Widget answer(BuildContext context, String response, int i) {
    String answer = globals.mySets.get(setI)!.getAnswer(i);
    String q = begin + globals.mySets.get(setI)!.getTerm(i) + ending;
    return Scaffold(
      body: Center(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  q,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text("Your Response:\n" + response),
                ),
                Text(
                  "Correct Answer:\n" + answer,
                ),
                //todo grading stuff
                Row(
                  children: [
                    IconButton.filled(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      ),
                      onPressed: () {
                        int nextI;
                        if (i > 0)
                          nextI = i - 1;
                        else
                          nextI = globals.mySets.get(setI)!.getLength() - 1;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    this.response(context, nextI)));
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewSetPage(setI: setI)));
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.red),
                      ),
                      child: Container(
                        child: Text(
                          "Exit",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        width: 54,
                        color: Colors.red,
                      ),
                    ),
                    IconButton.filled(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                      ),
                      onPressed: () {
                        int nextI;
                        if (i < globals.mySets.get(setI)!.getLength() - 1) {
                          nextI = i + 1;
                        } else
                          nextI = 0;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    this.response(context, nextI)));
                      },
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
          color: Colors.grey[500],
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.fromLTRB(30, 200, 30, 200),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //if ((itemI!)>=globals.mySets.get(setI)!.getLength()) return to set page
    //generates number & prompt

    return this.response(context, 0);
  }
}

//IMPORTANT Information holding
class Sets {
  late List<QASet> sets;

  Sets() {
    sets = [];
  }

  //todo get rid of testing stuff
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
                        builder: (context) => ViewSetPage(setI: i)));
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

  int length() {
    return sets.length;
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
          onPressed: () {},
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
            ],
          ),
        ),
      );
    }
    print(this.toString() + "571");
    return itemsToDisplay;
  }

  List<Widget> displayItemsforEditing(BuildContext context) {
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
                        setI: globals.mySets.find(this.getName()),
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
                  builder: (context) =>
                      EditingItems(setI: globals.mySets.find(name), index: i)),
            );
          },
        ),
      );
    }
    print(this.toString() + "638");
    return itemsToDisplay;
  }

  int getLength() {
    return items.length;
  }

  String getName() {
    return name;
  }

  void setName(String? str) {
    if (str != null)
      name = str;
    else
      name = "Unnamed";
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
