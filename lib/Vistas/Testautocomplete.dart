import 'package:flutter/material.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';


class Testautocomplete extends StatefulWidget {
  Testautocomplete({Key key}) : super(key: key);
  _TestautocompleteState createState() => _TestautocompleteState();
}


class _TestautocompleteState extends State<Testautocomplete> {

  final people = <Person>[Person('Alice', '123 Main'), Person('Bob', '456 Main'),Person('Jaime', '307'),Person('JArge', '98'),Person('Jaime1', '307'),Person('JArge1', '98'),Person('Jaime2', '307'),Person('JArge2', '98')];
  final letters = 'abcdefghijklmnopqrstuvwxyz'.split('');

  String selectedLetter;
  Person selectedPerson;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;

  @override
  Widget build(BuildContext context) => Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text("Autocomplete")),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          autovalidate: autovalidate,
          child: ListView(children: <Widget>[
            SizedBox(height: 16.0),
            Text('Selected person: "$selectedPerson"'),
            Text('Selected letter: "$selectedLetter"'),
            SizedBox(height: 16.0),


            SimpleAutocompleteFormField<Person>(
              decoration: InputDecoration(
                  labelText: 'Person', border: OutlineInputBorder()),
              suggestionsHeight: 200.0,
              itemBuilder: (context, person) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(person.name,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      //Text(person.address)
                    ]),
              ),
              onSearch: (search) async => people
                  .where((person) =>
              person.name
                  .toLowerCase()
                  .contains(search.toLowerCase())
                  // ||
                  // person.address
                  //     .toLowerCase()
                  //     .contains(search.toLowerCase())
              )
                  .toList(),
              itemFromString: (string) => people.singleWhere(
                      (person) => person.name.toLowerCase() == string.toLowerCase(),
                  orElse: () => null),
              onChanged: (value) => setState(() => selectedPerson = value),
              onSaved: (value) => setState(() => selectedPerson = value),
              validator: (person) => person == null ? 'Invalid person.' : null,
            ),



            SizedBox(height: 16.0),
            SimpleAutocompleteFormField<String>(
              decoration: InputDecoration(
                  labelText: 'Letter', border: OutlineInputBorder()),
              // suggestionsHeight: 200.0,
              maxSuggestions: 10,
              itemBuilder: (context, item) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(item),
              ),
              onSearch: (String search) async => search.isEmpty
                  ? letters
                  : letters
                  .where((letter) => search.toLowerCase().contains(letter))
                  .toList(),
              itemFromString: (string) => letters.singleWhere(
                      (letter) => letter == string.toLowerCase(),
                  orElse: () => null),
              onChanged: (value) => setState(() => selectedLetter = value),
              onSaved: (value) => setState(() => selectedLetter = value),
              validator: (letter) => letter == null ? 'Invalid letter.' : null,
            ),
            SizedBox(height: 16.0),
            RaisedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    scaffoldKey.currentState
                        .showSnackBar(SnackBar(content: Text('Fields valid!')));
                  } else {
                    scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text('Fix errors to continue.')));
                    setState(() => autovalidate = true);
                  }
                })
          ]),
        ),
      ));
}

class Person {
  Person(this.name, this.address);
  final String name, address;
  @override
  String toString() => name;
}





