import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../model/dice.dart';
import '../model/dice_list.dart';

class AddDiceScreen extends StatefulWidget {
  @override
  _AddDiceScreenState createState() => _AddDiceScreenState();
}

class _AddDiceScreenState extends State<AddDiceScreen> {
  final GlobalKey<FormState> _key = GlobalKey();

  static const _number = 1;
  static const _faces = 6;
  static const _add = 0;
  Dice dice = Dice(number: _number, faces: _faces, add: _add);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Form(
          key: _key,
          autovalidate: true,
          child: _buildForms(),
        ),
      ),
    );
  }

  Widget _buildForms() {
    final diceList = Provider.of<DiceList>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Add Dice ${dice.fullName}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: Colors.blue,
          ),
        ),
        _buildNumberForm(),
        _buildFacesForm(),
        _buildAddForm(),
        FlatButton(
          child: const Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
          onPressed: () {
            if (_key.currentState.validate()) {
              diceList.add(dice);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }

  TextFormField _buildNumberForm() {
    return TextFormField(
      maxLength: 3,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: '${dice.number}',
      ),
      onChanged: (value) {
        setState(() {
          dice = Dice(
            number: int.parse(value),
            faces: dice.faces,
            add: dice.add,
          );
        });
      },
      keyboardType: TextInputType.number,
      validator: (newValue) {
        if (newValue.isEmpty) {
          return null;
        }

        const min = 1;
        const max = 999;
        if (int.parse(newValue) < min || int.parse(newValue) > max) {
          return '$min <= value <= $max';
        }

        return null;
      },
    );
  }

  TextFormField _buildFacesForm() {
    return TextFormField(
      maxLength: 4,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: '${dice.faces}',
      ),
      onChanged: (value) {
        setState(() {
          dice = Dice(
            number: dice.number,
            faces: int.parse(value),
            add: dice.add,
          );
        });
      },
      keyboardType: TextInputType.number,
      validator: (newValue) {
        if (newValue.isEmpty) {
          return null;
        }

        const min = 1;
        const max = 9999;
        if (int.parse(newValue) < min || int.parse(newValue) > max) {
          return '$min <= value <= $max';
        }

        return null;
      },
    );
  }

  TextFormField _buildAddForm() {
    return TextFormField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: '${dice.add}',
      ),
      onChanged: (value) {
        setState(() {
          dice = Dice(
            number: dice.number,
            faces: dice.faces,
            add: int.parse(value),
          );
        });
      },
      keyboardType: TextInputType.number,
      validator: (newValue) {
        if (newValue.isEmpty) {
          return null;
        }

        const min = -9999;
        const max = 9999;
        if (int.parse(newValue) < -9999 || int.parse(newValue) > 9999) {
          return '$min <= value <= $max';
        }

        return null;
      },
    );
  }
}
