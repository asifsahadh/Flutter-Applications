import 'package:firebaseform/histogram.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabScreen(),
    );
  }
}

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;
  bool _formSubmitted = false;

  void _handleFormSubmit() {
    setState(() {
      _formSubmitted = true;
      _currentIndex = 1; // Navigate to the Histogram screen after submission
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.tab),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TabGridScreen(
                    formSubmitted: _formSubmitted,
                    onTabSelected: (int index) {
                      setState(() {
                        _currentIndex = index;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          MyForm(onFormSubmit: _handleFormSubmit), // Form Screen
          if (_formSubmitted) AgeHistogram(), // Show Histogram after Form Submission
        ],
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  final VoidCallback onFormSubmit;

  MyForm({required this.onFormSubmit});

  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _regController = TextEditingController();
  final TextEditingController _appController = TextEditingController();
  final TextEditingController _cnController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CollectionReference formCollection = FirebaseFirestore.instance.collection('form');

  late List<Map<String, dynamic>> formFields;

  @override
  void initState() {
    super.initState();
    formFields = [
      {
        'label': 'Name',
        'controller': _nameController,
        'widget': TextFormField(
          controller: _nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Name Cannot be Empty';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Name",
            hintText: "Enter your Name",
          ),
        )
      },
      {
        'label': 'Age',
        'controller': _ageController,
        'widget': TextFormField(
          controller: _ageController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Age Cannot be Empty';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Age",
            hintText: "Enter your Age",
          ),
        )
      },
      {
        'label': 'Registration Number',
        'controller': _regController,
        'widget': TextFormField(
          controller: _regController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Registration Number Cannot be Empty';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Registration Number",
            hintText: "Enter your Reg. No.",
          ),
        )
      },
      {
        'label': 'Application Number',
        'controller': _appController,
        'widget': TextFormField(
          controller: _appController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Application Number Cannot be Empty';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Application Number",
            hintText: "Enter your Application No.",
          ),
        )
      },
      {
        'label': 'Course Name',
        'controller': _cnController,
        'widget': TextFormField(
          controller: _cnController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Course Name Cannot be Empty';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Course Name",
            hintText: "Enter your Course Name.",
          ),
        )
      },
      {
        'label': 'Date of Joining',
        'controller': _dateController,
        'widget': Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: TextFormField(
            controller: _dateController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Date of Joining Cannot be Empty';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Date of Joining",
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            readOnly: true,
            onTap: () {
              _selectDate();
            },
          ),
        )
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Form", style: TextStyle(fontWeight: FontWeight.bold))),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
        child: Form(
          key: _formKey,
          child: ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final item = formFields.removeAt(oldIndex);
                formFields.insert(newIndex, item);
              });
            },
            children: formFields.map((field) {
              return ListTile(
                key: ValueKey(field['label']),
                title: field['widget'],
                trailing: Icon(Icons.drag_handle_sharp),
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await formCollection.add({
              'Name': _nameController.text,
              'Age': _ageController.text,
              'Registration Number': _regController.text,
              'Application Number': _appController.text,
              'Course Name': _cnController.text,
              'Date of Joining': _dateController.text,
            });

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Data Saved Successfully!'))
            );

            widget.onFormSubmit();

            // Clear Instances for Future Use
            _nameController.clear();
            _ageController.clear();
            _regController.clear();
            _appController.clear();
            _cnController.clear();
            _dateController.clear();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please Fill all the Required Fields!'))
            );
          }
        },
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}

// Grid Screen
class TabGridScreen extends StatelessWidget {
  final bool formSubmitted;
  final Function(int) onTabSelected;

  TabGridScreen({required this.formSubmitted, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabs'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          GestureDetector(
            onTap: () => onTabSelected(0),
            child: Card(
              child: Center(child: Text('Form')),
            ),
          ),
          if (formSubmitted)
            GestureDetector(
              onTap: () => onTabSelected(1),
              child: Card(
                child: Center(child: Text('Histogram')),
              ),
            ),
        ],
      ),
    );
  }
}
