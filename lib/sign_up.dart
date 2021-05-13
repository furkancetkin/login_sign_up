import 'package:flutter/material.dart';
import 'package:login_sign_up/homePage.dart';
import 'package:login_sign_up/login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _activeStep = 0;
  String name, mail, password;
  List<Step> allSteps;
  bool fail = false;
  bool isHiddenPassword = true;

  var key0 = GlobalKey<FormFieldState>();
  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    allSteps = _allSteps();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Stepper(
                steps: allSteps,
                currentStep: _activeStep,
                onStepContinue: () {
                  setState(() {
                    _ileriButonuKontrolu();
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (_activeStep > 0) {
                      _activeStep--;
                    } else {
                      _activeStep = 0;
                    }
                  });
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 600,
            ),
            Text(
              "If you have an account",
              style: TextStyle(fontSize: 18),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                });
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

  List<Step> _allSteps() {
    List<Step> steps = [
      Step(
        title: Text("Username"),
        subtitle: Text("Username bottom title"),
        state: _settingStates(0),
        isActive: true,
        content: TextFormField(
            key: key0,
            decoration: InputDecoration(
                labelText: "Username",
                hintText: "Enter Username",
                border: OutlineInputBorder()),
            validator: (inputValue) {
              if (inputValue.length < 5) {
                return "Please enter at least 6 characters";
              }
            },
            onSaved: (inputValue) {
              name = inputValue;
            }),
      ),
      Step(
        title: Text("Mail"),
        subtitle: Text("Mail bottom title"),
        state: _settingStates(1),
        isActive: true,
        content: TextFormField(
          keyboardType: TextInputType.emailAddress,
          key: key1,
          decoration: InputDecoration(
              labelText: "Mail",
              hintText: "Enter Mail",
              border: OutlineInputBorder()),
          validator: (inputValue) {
            if (inputValue.length < 5 || !inputValue.contains("@")) {
              return "Please enter valid e-mail address";
            }
          },
          onSaved: (inputValue) {
            mail = inputValue;
          },
        ),
      ),
      Step(
        title: Text("Password"),
        subtitle: Text("Password bottom title"),
        state: _settingStates(2),
        isActive: true,
        content: TextFormField(
            key: key2,
            obscureText: isHiddenPassword,
            decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter Password",
                suffixIcon: InkWell(
                    onTap: _togglePasswordView,
                    child: Icon(isHiddenPassword
                        ? Icons.visibility_off
                        : Icons.visibility)),
                border: OutlineInputBorder()),
            validator: (inputValue) {
              if (inputValue.length < 5) {
                return "Please enter at least 6 characters";
              }
            },
            onSaved: (inputValue) {
              password = inputValue;
            }),
      ),
    ];
    return steps;
  }

  StepState _settingStates(int momentStep) {
    if (_activeStep == momentStep) {
      if (fail) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else
      return StepState.complete;
  }

  void _ileriButonuKontrolu() {
    switch (_activeStep) {
      case 0:
        if (key0.currentState.validate()) {
          key0.currentState.save();
          fail = false;
          _activeStep = 1;
        } else {
          fail = true;
        }

        break;

      case 1:
        if (key1.currentState.validate()) {
          key1.currentState.save();
          fail = false;
          _activeStep = 2;
        } else {
          fail = true;
        }

        break;

      case 2:
        if (key2.currentState.validate()) {
          key2.currentState.save();
          fail = false;
          _activeStep = 2;
          formFinished();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          fail = true;
        }

        break;
    }
  }

  void formFinished() {
    debugPrint(
        "İnput values : name => $name, mail => $mail, password => $password ");
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}
