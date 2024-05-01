import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Importing a placeholder login screen

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String? genderValue;
  TextEditingController rollNoController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  final _Signupkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation = ColorTween(
      begin: Color.fromARGB(255, 27, 34, 94),
      end: Color(0xffB760D5),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(animation: _animation),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Image.asset(
                    'assets/logo.png',
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Welcome to CommuneHub!',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Where community gathers',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _Signupkey,
                    child: Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'We need some bio info',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: namecontroller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Name";
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.check,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Enter Name',
                                  labelText: 'Full Name',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: _emailcontroller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter an Email id";
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.check,
                                    color: Colors.grey,
                                  ),
                                  labelText: 'Phone or Gmail',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: _passcontroller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password is mandatory";
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                readOnly: true,
                                controller: dobController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter DOB";
                                  }
                                },
                                onTap: () async {
                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if (pickedDate != null)
                                    setState(() {
                                      dobController.text =
                                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                    });
                                },
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey,
                                  ),
                                  labelText: 'Date of Birth',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              DropdownButtonFormField<String>(
                                value: genderValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    genderValue = newValue;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Gender',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                ),
                                items: <String>[
                                  'Male',
                                  'Female',
                                  'Other'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: rollNoController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Roll Number";
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.check,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Enter Roll Number',
                                  labelText: 'Roll Number',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: departmentController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Department";
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.check,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Enter Department',
                                  labelText: 'Department',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: semesterController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Semester";
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.check,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Enter Semester',
                                  labelText: 'Semester',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 55,
                                width: 200, // Reduced width
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xffB760D5),
                                    Color(0xff281537),
                                  ]),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    if (_Signupkey.currentState!.validate()) {
                                      // Check if the email is already in use
                                      try {
                                        // Inside the try block after creating the user
                                        UserCredential userData =
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                          email: _emailcontroller.text.trim(),
                                          password: _passcontroller.text.trim(),
                                        );

                                        if (userData != null) {
                                          // Set the user's display name
                                          await userData.user!.updateProfile(
                                              displayName: namecontroller.text);

                                          // User creation successful
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userData.user!.uid)
                                              .set({
                                            'uid': userData.user!.uid,
                                            'email': userData.user!.email,
                                            'name': namecontroller.text,
                                            'dob': dobController.text,
                                            'gender': genderValue ?? '',
                                            'createdAt': DateTime.now(),
                                            'status': 1,
                                            'roll_number':
                                                rollNoController.text,
                                            'department':
                                                departmentController.text,
                                            'semester': semesterController.text,
                                          }).then((value) {
                                            // Navigate to home screen
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/home',
                                                (route) => false);
                                          });
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          // Password is too weak
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'The password provided is too weak.'),
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          // Email is already in use
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'The account already exists for that email.'),
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        // Other errors
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'An error occurred while signing up.'),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                    } else {
                                      // Show a Snackbar if any field is not entered
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Please fill in all the fields.'),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  final Animation<Color?> animation;

  const AnimatedBackground({Key? key, required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                animation.value!,
                Color(0xff7E53D6),
                Color(0xffB760D5),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
