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
          child: _buildForms(context),
        ),
      ),
    );
  }

  Widget _buildForms(BuildContext context) {
    final diceList = Provider.of<DiceList>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Add Dice ${dice.name}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: Colors.blue,
          ),
        ),
        TextFormField(
          maxLength: 3,
          decoration: const InputDecoration(
            labelText: 'Number of dices',
            hintText: '$_number',
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

            if (int.parse(newValue) < 1 || int.parse(newValue) > 100) {
              return '1 <= number <= 100';
            }

            return null;
          },
        ),
        TextFormField(
          maxLength: 4,
          decoration: const InputDecoration(
            labelText: 'Faces of dices',
            hintText: '$_faces',
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

            if (int.parse(newValue) < 1 || int.parse(newValue) > 9999) {
              return '1 <= feces <= 9999';
            }

            return null;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Adjust value',
            hintText: '$_add',
          ),
          textAlign: TextAlign.justify,
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

            if (int.parse(newValue) < -9999 || int.parse(newValue) > 9999) {
              return '-9999 <= value <= 9999';
            }

            return null;
          },
        ),
        FlatButton(
          child: Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
          onPressed: () {
            if (_key.currentState.validate()) {
              // No any error in validation
              diceList.add(dice);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
