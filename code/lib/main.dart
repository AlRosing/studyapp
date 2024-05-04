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
Added folders(including folders in folders!) & way to display them
Changed looks of various screens - Reworked/added MyHomePage, ChoosingSetType(added),  BasicPageFormat(added), NewSetPage(added), SetCreationPage, ViewSetPage, QASetPage
Removed EnterQuestionPage
 */

void main() {
  Folder fold = Folder(
      n: "Chemistry", nums: [1, 2]); //adding Chemistry folder to general folder
  Folder fold2 = Folder(n: "Set1", nums: [1]);
  fold2.moveFolder(globals.user.general, fold);
  runApp(MaterialApp(title: 'StudyApp', initialRoute: '/home', routes: {
    '/': (context) => const MyHomePage(title: 'StudyApp'),
    '/home': (context) => const MyHomePage(title: 'StudyApp'),
    '/choosingSetType': (context) => const ChoosingSetType(),
    '/newSet': (context) => const NewSetPage(),
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
        backgroundColor: const Color(0xFF4F86B2),
        title: const Text(
          "Study\n App",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'PassionOne',
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: const Color(0xFFEEEEEE),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "images/StudyAppLogoThing.png",
                  fit: BoxFit.fill,
                ),
                const Center(
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Color(0xFF0096EA),
                      fontSize: 37.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFFEEEEEE),
              margin: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
              child: const Text(
                "My Recent Sets",
                style: TextStyle(
                  color: Color(0xFF0096EA),
                  fontSize: 22.0,
                ),
                textAlign: TextAlign.center,
              )),
          /*Column(
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
                          builder: (context) => const Scaffold(
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
              ),*/
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 416,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: globals.user.mySets.displaySets(context), //todo error
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: globals.user.display(context),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/choosingSetType');
          },
          child: Container(
            color: const Color(0xFF0288D1),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            width: MediaQuery.of(context).size.width - 10.0,
            child: const Center(
              child: Text(
                "Create New Set",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChoosingSetType extends StatelessWidget {
  const ChoosingSetType({super.key});

  @override
  Widget build(BuildContext context) {
    Widget setTypes = Center(
        child: Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/newSet');
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            width: MediaQuery.of(context).size.width - 20.0,
            child: const Center(
              child: Text(
                "Flashcard Set",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: Colors.grey[400],
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            width: MediaQuery.of(context).size.width - 20.0,
            child: const Center(
              child: Text(
                "Visual Drag & Drop Set",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: Colors.grey[400],
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            width: MediaQuery.of(context).size.width - 20.0,
            child: const Center(
              child: Text(
                "Q & A Set",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    ));
    Text q = const Text(
      "What type of set would you like to create?",
      softWrap: true,
      overflow: TextOverflow.fade,
      style: TextStyle(
        fontSize: 22.0,
        color: Color(0xFF29698C),
      ),
    );
    return BasicPageFormat(info: setTypes, text: q);
  }
}

class NewSetPage extends StatefulWidget {
  const NewSetPage({super.key});

  @override
  _NewSetPageState createState() => _NewSetPageState();
}

class _NewSetPageState extends State<NewSetPage> {
  QASet current = QASet();
  bool added = false;
  String oldName = "";

  @override
  Widget build(BuildContext context) {
    Widget info = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(
              5.0, 5.0, MediaQuery.of(context).size.width - 115.0, 0.0),
          child: const Text(
            "Set Name:",
            style: TextStyle(
              color: Color(0xFF29698C),
              fontSize: 22,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 15.0),
          child: TextField(
            controller: TextEditingController(),
            maxLines: 1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Type the name of the set here.",
              hintMaxLines: 1,
            ),
            onSubmitted: (String value) async {
              if (!added) {
                current.setName(value);
                globals.user.add(current);
                added = true;
                oldName = value;
              } else {
                globals.user.mySets
                    .setSet(current, globals.user.mySets.find(oldName));
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              5.0, 15.0, MediaQuery.of(context).size.width - 180.0, 0.0),
          child: const Text(
            "Question Format:",
            style: TextStyle(
              color: Color(0xFF29698C),
              fontSize: 22,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
          child: TextField(
            controller: TextEditingController(),
            maxLines: 6,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  "Type your question sentence here, using <term> where you want your term to appear in the question.",
              hintMaxLines: 6,
            ),
            onChanged: (String value) async {
              current.setQuestion(value);
              if (!added) {
                globals.user.add(current);
                added = true;
              } else {
                globals.user.mySets
                    .setSet(current, globals.user.mySets.find(current.name));
              }
            },
            onSubmitted: (String value) async {
              current.setQuestion(value);
              if (!added) {
                globals.user.add(current);
                added = true;
              } else {
                globals.user.mySets
                    .setSet(current, globals.user.mySets.find(current.name));
              }
            },
          ),
        ),
        //haven't implemented set color yet
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: (MediaQuery.of(context).size.width - 182) / 2),
          child: Row(
            children: [
              IconButton.outlined(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                icon: const Icon(
                  CupertinoIcons.xmark,
                  color: Colors.red,
                  size: 60.0,
                ),
              ),
              const SizedBox(
                width: 30.0,
                height: 10.0,
              ),
              IconButton.outlined(
                onPressed: () {
                  if (!added) {
                    globals.user.add(current);
                  } else {
                    globals.user.mySets.setSet(
                        current, globals.user.mySets.find(current.name));
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SetCreationPage(
                              setI: globals.user.mySets.find(current.name))));
                },
                icon: const Icon(
                  Icons.check,
                  color: Color(0xFF00B84A),
                  size: 60.0,
                ),
              )
            ],
          ),
        ),
      ],
    );
    Text text = const Text(
      "Create New Term Set",
      style: TextStyle(
        fontSize: 34,
        color: Color(0xFF29698C),
      ),
    );
    return BasicPageFormat(info: info, text: text);
  }
}

class SetCreationPage extends StatefulWidget {
  final int setI;

  const SetCreationPage({super.key, required this.setI});

  @override
  _SetCreationPageState createState() => _SetCreationPageState(setI: setI);
}

class _SetCreationPageState extends State<SetCreationPage> {
  int setI;

  _SetCreationPageState({required this.setI});

  @override
  Widget build(BuildContext context) {
    QASet current = globals.user.mySets.get(setI)!;
    Widget info = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton.outlined(
              onPressed: () {
                globals.user.mySets.setSet(current, setI);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewSetPage(setI: setI),
                  ),
                );
              },
              icon: Icon(
                Icons.check,
                color: Colors.green[800],
                size: 60.0,
              ),
            ),
            IconButton.outlined(
              onPressed: () {
                //todo adding
                globals.user.mySets.setSet(current, setI);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditingItems(setI: setI)));
              },
              icon: Icon(
                Icons.add,
                size: 60.0,
                color: Colors.green[800],
              ),
            ),
            IconButton.outlined(
              onPressed: () {
                globals.user.deleteSet(setI);
                Navigator.pushNamed(context, '/home');
              },
              icon: const Icon(
                CupertinoIcons.trash,
                size: 60.0,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
    Widget stuff = Column(
      mainAxisSize: MainAxisSize.min,
      children: current.displayItemsforEditing(context),
    );
    String name = globals.user.mySets.get(setI)!.name;
    if (globals.user.mySets.get(setI) != null)
      name = globals.user.mySets.get(setI)!.name;
    else
      name = "ERROR: No Set Found";
    Text text = Text(
      name,
      style: const TextStyle(
        color: Color(0xFF29698C),
        fontSize: 34.0,
      ),
    );
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF4F86B2),
          title: const Text(
            "Study\n App",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'PassionOne',
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: const Icon(
                Icons.home,
                color: Colors.black,
                size: 20,
              ),
            ),
          ]),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 22.0),
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFFEEEEEE),
            child: Center(child: text),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: info,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 377.0,
            child: SingleChildScrollView(
              child: stuff,
            ),
          ),
        ],
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
    Widget info = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(
              5.0, 5.0, MediaQuery.of(context).size.width - 65.0, 0.0),
          child: const Text(
            "Term:",
            style: TextStyle(
              color: Color(0xFF29698C),
              fontSize: 22,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 15.0),
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
            maxLines: 2,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              5.0, 15.0, MediaQuery.of(context).size.width - 90.0, 0.0),
          child: const Text(
            "Answer:",
            style: TextStyle(
              color: Color(0xFF29698C),
              fontSize: 22,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
          child: TextField(
            controller: TextEditingController(),
            maxLines: 4,
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
        //haven't implemented set color yet
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: (MediaQuery.of(context).size.width - 182) / 2),
          child: Row(
            children: [
              IconButton.outlined(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SetCreationPage(setI: setI)));
                },
                icon: const Icon(
                  CupertinoIcons.xmark,
                  color: Colors.red,
                  size: 60.0,
                ),
              ),
              const SizedBox(
                width: 30.0,
                height: 10.0,
              ),
              IconButton.outlined(
                onPressed: () {
                  if (index != null) {
                    globals.user.mySets.setItemInSet(toAdd, setI, index!);
                  } else {
                    globals.user.mySets.addItemToSet(toAdd, setI);
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SetCreationPage(setI: setI)));
                },
                icon: const Icon(
                  Icons.check,
                  color: Color(0xFF00B84A),
                  size: 60.0,
                ),
              )
            ],
          ),
        ),
      ],
    );
    Text text = const Text(
      "Create New Term Item",
      style: TextStyle(
        fontSize: 34,
        color: Color(0xFF29698C),
      ),
    );
    return BasicPageFormat(info: info, text: text);
  }
}

class BasicPageFormat extends StatefulWidget {
  final Widget info;
  final Text text;

  const BasicPageFormat({super.key, required this.info, required this.text});

  @override
  _BasicPageFormatState createState() =>
      _BasicPageFormatState(info: info, text: text);
}

class _BasicPageFormatState extends State<BasicPageFormat> {
  Widget info;
  Text text;

  _BasicPageFormatState({required this.info, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF4F86B2),
          title: const Text(
            "Study\n App",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'PassionOne',
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: const Icon(
                Icons.home,
                color: Colors.black,
                size: 20,
              ),
            ),
          ]),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 22.0),
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFFEEEEEE),
            child: Center(child: text),
          ),
          SingleChildScrollView(
            child: info,
          ),
        ],
      ),
      drawer: Drawer(
        child: globals.user.display(context),
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
    print("ViewSetPage!!!!!");
    //todo change shape of buttons, add play & edit buttons
    //todo rework the studying
    QASet current = globals.user.mySets.get(setI)!;
    Text text = Text(
      "${current.getName()}",
      style: const TextStyle(
        fontSize: 32,
        color: Color(0xFF29698C),
      ),
      softWrap: true,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
    Widget info = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton.outlined(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QAStudyPage(setI: setI)));
                },
                icon: const Icon(
                  Icons.play_arrow,
                  color: Color(0xFF00B84A),
                  size: 60.0,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  //editing button
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SetCreationPage(setI: setI)),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    "EDIT",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF4F86B2),
          title: const Text(
            "Study\n App",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'PassionOne',
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: const Icon(
                Icons.home,
                color: Colors.black,
                size: 20,
              ),
            ),
          ]),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 22.0),
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFFEEEEEE),
            child: Center(child: text),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: info,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 350.0,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: current.displayItems(context),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: globals.user.display(context),
      ),
    );
  }
}

//class to pick the study set & do it
class QAStudyPage extends StatefulWidget {
  final int setI;
  final int? itemI;

  const QAStudyPage({super.key, required this.setI, this.itemI});

  @override
  _QAStudyPageState createState() => _QAStudyPageState(setI: setI);
}

class _QAStudyPageState extends State<QAStudyPage> {
  final int setI;

  //todo add grade trackers
  _QAStudyPageState({required this.setI});

  int randomItem() {
    int len = globals.user.mySets.get(setI)!.getLength();
    final random = Random();
    return random.nextInt(len);
  } //for later

  Widget response(BuildContext context, i) {
    QASet current = globals.user.mySets.get(setI)!; //todo change UI stuff
    String q = current.prompt(i);
    String response = "";
    Text text = Text(
      current.name,
      maxLines: 1,
      style: const TextStyle(
        color: Color(0xFF29698C),
        fontSize: 34,
      ),
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
    //problem w/ info being too large...
    Widget info = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 20.0,
          child: Text(
            q,
            maxLines: 7,
            style: const TextStyle(
              color: Color(0xFF29698C),
              fontSize: 22,
            ),
          ),
        ),
        TextField(
          controller: TextEditingController(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Response',
          ),
          maxLines: 6,
          onChanged: (String value) async {
            response = value;
          },
          onSubmitted: (String value) async {
            response = value;
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: (MediaQuery.of(context).size.width - 182) / 2),
          child: Row(
            children: [
              IconButton.outlined(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewSetPage(setI: setI)));
                },
                icon: const Icon(
                  CupertinoIcons.xmark,
                  color: Colors.red,
                  size: 60.0,
                ),
              ),
              const SizedBox(
                width: 30.0,
                height: 10.0,
              ),
              IconButton.outlined(
                onPressed: () {
                  print(response);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => answer(context, response, i)));
                },
                icon: const Icon(
                  Icons.check,
                  color: Color(0xFF00B84A),
                  size: 60.0,
                ),
              )
            ],
          ),
        ),
      ],
    );
    return BasicPageFormat(info: info, text: text);
  }

  Widget answer(BuildContext context, String response, int i) {
    QASet current = globals.user.mySets.get(setI)!;
    String answer = globals.user.mySets.get(setI)!.getAnswer(i);
    String q = current.prompt(i);
    bool correct = answer.trim() == response.trim();
    //at top have correct or incorrect
    Text top;
    Widget thing;
    List<Widget> buttons;
    if (correct) {
      top = const Text(
        "Correct!",
        style: TextStyle(
          color: Color(0xFF00C914),
          fontSize: 22,
        ),
      );
      thing = Text(
        "The answer to '${q}' is ${answer}",
        style: const TextStyle(
          fontSize: 22,
        ),
        maxLines: 10,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      );
      buttons = <Widget>[
        IconButton.outlined(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => this.response(context, i + 1),
              ),
            );
          },
          icon: const Icon(
            Icons.check,
            color: Color(0xFF00B84A),
            size: 50.0,
          ),
        )
      ];
    } else {
      top = const Text(
        "Incorrect!",
        style: TextStyle(
          color: Colors.red,
          fontSize: 22,
        ),
      );
      thing = Text(
        "Correct Answer:\n${answer}",
        style: const TextStyle(
          fontSize: 22,
        ),
        maxLines: 10,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      );
      buttons = <Widget>[
        IconButton.outlined(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.redo,
            color: Colors.red,
            size: 50.0,
          ),
        ),
        IconButton.outlined(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => this.response(context, i + 1),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_forward,
            color: Color(0xFF00B84A),
            size: 50.0,
          ),
        ),
      ];
    }
    return AlertDialog(
      title: top,
      content: SingleChildScrollView(
        child: thing,
      ),
      actions: buttons,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    );
    /*return Scaffold(
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
                          nextI =
                              globals.user.mySets.get(setI)!.getLength() - 1;
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
                        if (i <
                            globals.user.mySets.get(setI)!.getLength() - 1) {
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
    );*/
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //if ((itemI!)>=globals.mySets.get(setI)!.getLength()) return to set page
    //generates number & prompt

    return response(context, 0);
  }
}

//IMPORTANT Information holding
class UserData {
  late Folder general;

  //todo add categories & friends, etc
  String user = "";
  String password = "";
  Sets mySets = Sets();

  UserData(
      {String? u, String? pass, Sets? sets, List<Folder>? folders = const []}) {
    user = u ?? "Guest";
    password = pass ?? "password";
    mySets = sets ?? globals.sampleData;
    List<int> numbers = [];
    for (int i = 0; i < mySets.length(); i++) numbers.add(i);
    general = Folder(n: "General", nums: numbers, folders: folders);
  }

  void setUser(String str) {
    user = str;
  }

  void setPassword(String pass) {
    password = pass;
  }

  Folder getGeneral() {
    return general;
  }

  void setGeneral(Folder fold) {
    general = fold;
  }

  String getUser() => user;

  String getPassword() => password;

  void deleteSet(int i) {
    if (mySets.length() > i && i > -1) {
      general.deletingSet(i);
      mySets.deleteSet(i);
    }
  }

  void add(QASet set) {
    general.setNums.add(mySets.length());
    mySets.add(set);
  }

  Widget display(BuildContext context) {
    //todo
    List<Widget> insideStuff = [const SizedBox(height: 20.0, width: 10.0)];
    for (int i in general.setNums) {
      insideStuff.add(globals.user.mySets.displaySetShortened(context, i));
    }
    for (Folder fold in general.foldersInside) {
      insideStuff.add(fold.displayFolder(context));
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      children: insideStuff,
    );
  }
}

class Folder {
  //will need basic Generic folder
  late String name;
  late Folder? folder;
  late List<Folder> foldersInside;
  late List<int> setNums;

  //creation
  Folder(
      {String n = "Untitled",
      Folder? fold,
      List<int>? nums,
      List<Folder>? folders}) {
    name = n;
    if (nums != null) {
      setNums = nums;
    } else
      setNums = [];
    if (name == "General") {
      folder = null;
    } else {
      if (fold == null)
        setFolder(globals.user.getGeneral());
      else
        setFolder(fold);
    }
    foldersInside = [];
  }

  @override
  String toString() {
    String str = "Folder:\n\tName: " + name + "\n\tInside: ";
    if (folder == null)
      str += "N/A";
    else
      str += folder!.name;
    str += "\n\tContains:\n\t\tFolders:";
    for (Folder fold in foldersInside) {
      str += "\n\t\t\t" + fold.name;
    }
    str += "\n\t\tSet Numbers: ";
    for (int i in setNums) {
      str += "\n\t\t\t" + i.toString();
    }
    return str;
  }

  void removeAllSetsOfThisFromOuter() {
    for (int i in setNums) {
      removeSetFromOuterFolders(i);
    }
  }

  void deletingSet(int i) {
    for (int j = 0; j < setNums.length; j++) {
      if (setNums[j] > i) {
        setNums[j] = setNums[j] - 1;
      } else if (setNums[j] == i) {
        setNums.removeAt(j);
        j--;
      }
    }
    for (int j = 0; j < foldersInside.length; j++) {
      foldersInside[j].deletingSet(i);
    }
  }

  void removeSetFromOuterFolders(int i) {
    if (folder != null) {
      if (folder != null && folder!.setNums.contains(i)) {
        folder!.setNums.remove(i);
      }
      folder!.removeSetFromOuterFolders(i);
    }
  }

  //setting
  void setName(String str) {
    name = str;
  }

  void setFolder(Folder fold) {
    folder = fold;
    fold.addFolder(this);
  }

  void setFolders(List<Folder> folds) {
    foldersInside = folds;
  }

  void moveFolder(Folder from, Folder to) {
    from.removeFolder(this);
    setFolder(to);
  }

  void moveSet(int i, Folder to) {
    removeSet(i);
    to.addSet(i);
  }

  void removeFolder(Folder folder) {
    foldersInside.remove(folder);
  }

  void removeBuriedFolder(Folder folder) {
    if (foldersInside.contains(folder)) {
      foldersInside.remove(folder);
    } else {
      for (int j = 0; j < foldersInside.length; j++) {
        foldersInside[j].removeBuriedFolder(folder);
      }
    }
  }

  void removeSet(int i) {
    setNums.remove(i);
  }

  void removeBuriedSet(int i) {
    if (setNums.contains(i)) {
      setNums.remove(i);
    } else {
      for (int j = 0; j < foldersInside.length; j++) {
        foldersInside[j].removeBuriedSet(i);
      }
    }
  }

  void addFolder(Folder fold) {
    foldersInside.add(fold);
    fold.folder = this;
    fold.removeAllSetsOfThisFromOuter();
  }

  void addSet(int i) {
    if (setNums.contains(i) == -1) {
      setNums.add(i);
      removeSetFromOuterFolders(i);
    }
  }

  //getting
  String getName() => name;

  Folder? getFolder() => folder;

  List<int> getSetNums() => setNums;

  List<QASet> getSets() {
    List<QASet> sets = [];
    for (int i = 0; i < setNums.length; i++) {
      sets.add(globals.user.mySets.sets[i]);
    }
    return sets;
  }

  Widget displayFolder(BuildContext context) {
    List<Widget> insideStuff = [];
    for (int i in setNums) {
      insideStuff.add(globals.user.mySets.displaySetShortened(context, i));
    }
    for (Folder fold in foldersInside) {
      insideStuff.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, .0, 0.0, 0.0),
          child: fold.displayFolder(context),
        ),
      );
    }
    return ExpansionTile(
      title: Row(
        children: [
          const Icon(Icons.folder, size: 20, color: Colors.orange),
          Text(name),
        ],
      ),
      controlAffinity: ListTileControlAffinity.leading,
      children: insideStuff,
    );
  }
}

class Sets {
  List<QASet> sets = [];

  Sets({List<QASet>? stuff}) {
    sets = stuff ?? [];
  }

  Container displaySet(BuildContext context, int i) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          border: Border.all(
        color: const Color(0xFF6750A4),
      )),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 280.0,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewSetPage(setI: i)));
              },
              child: Text(
                get(i)!.getName(),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              globals.user.deleteSet(i);
              Navigator.pushNamed(context, '/home');
            },
            icon: const Icon(
              CupertinoIcons.trash,
              size: 15,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Container displaySetShortened(BuildContext context, int i) {
    if (i < sets.length && i > -1) {
      return Container(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 190.0,
              child: TextButton(
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
            ),
            IconButton(
              onPressed: () {
                globals.user.mySets.deleteSet(i);
                Navigator.pushNamed(context, '/home');
              },
              icon: const Icon(
                CupertinoIcons.trash,
                size: 15,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
    } else
      return Container(child: null);
  }

  //todo get rid of testing stuff
  List<Widget> displaySets(BuildContext context) {
    List<Widget> setsToDisplay = <Widget>[];
    for (int i = 0; i < sets.length; i++) {
      //todo put list in center
      setsToDisplay.add(displaySet(context, i));
    }
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
    if (index > -1 && index < sets.length) {
      return sets[index];
    } else {
      return null;
    }
  }

  void add(QASet set) {
    sets.add(set);
  }

  void deleteSet(int index) {
    print("Set Length: ${sets.length}");
    print(index);
    if (index > -1 && index < sets.length) {
      if (index != sets.length - 1)
        sets.removeAt(index);
      else
        sets.removeLast();
    }
  }

  void removeSet(QASet set) {
    sets.remove(set);
  }

  void setSet(QASet set, int index) {
    sets[index] = set;
  }

  void addItemToSet(Item thing, int index) {
    sets[index].addItem(thing);
  }

  void setItemInSet(Item thing, int index, int termIndex) {
    sets[index].setItem(termIndex, thing);
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
  String name = "Unnamed";
  String qBegin = "";
  String qEnd = "";
  List<Item> items = [];

  QASet({String n = "Unnamed", List<Item>? items, String q = ""}) {
    name = n;
    int i = q.indexOf("<term>");
    if (i == -1) {
      qBegin = q;
    } else {
      qBegin = q.substring(0, i);
      qEnd = q.substring(i + 6);
    }
    if (items == null) {
      Item thing = Item();
      this.items = [thing];
    } else {
      this.items = items;
    }
  }

  void setQuestion(String q) {
    int i = q.indexOf("<term>");
    if (i == -1) {
      qBegin = q;
    } else {
      qBegin = q.substring(0, i);
      qEnd = q.substring(i + 6);
    }
  }

  String prompt(int i) {
    if (i < 0 || i >= items.length)
      return "No such item";
    else {
      return qBegin + items[i].getTerm() + qEnd;
    }
  }

  List<Widget> displayItems(BuildContext context) {
    //no issues here
    List<Widget> itemsToDisplay = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      String uno = items[i].getTerm();
      String dos = items[i].getAnswer();
      itemsToDisplay.add(
        Container(
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditingItems(
                          setI: globals.user.mySets.find(name), index: i)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 125.0,
                  child: Text(
                    uno,
                    softWrap: true,
                    maxLines: 6,
                  ),
                ),
                const SizedBox(
                  width: 50,
                  height: 10,
                ),
                SizedBox(
                  width: 125.0,
                  child: Text(
                    dos,
                    softWrap: true,
                    maxLines: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return itemsToDisplay;
  }

  List<Widget> displayItemsforEditing(BuildContext context) {
    //no issues here
    List<Widget> itemsToDisplay = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      String uno = items[i].getTerm();
      String dos = items[i].getAnswer();
      itemsToDisplay.add(
        Container(
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 115.0,
                  child: Text(
                    uno,
                    softWrap: true,
                    maxLines: 7,
                  ),
                ),
                const SizedBox(
                  width: 30,
                  height: 10,
                ),
                SizedBox(
                  width: 115.0,
                  child: Text(
                    dos,
                    softWrap: true,
                    maxLines: 7,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    deleteItem(i);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetCreationPage(
                          setI: globals.user.mySets.find(getName()),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
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
                    builder: (context) => EditingItems(
                        setI: globals.user.mySets.find(name), index: i)),
              );
            },
          ),
        ),
      );
    }
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
    items.insert(0, thing);
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

  Item({String t = "term", String a = "answer"}) {
    term = t;
    answer = a;
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
