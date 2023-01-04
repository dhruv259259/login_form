import 'dart:io';
import 'dart:math';

import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_form/Viewdata.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: home(),
    debugShowCheckedModeBanner: false,
  ));
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String gender = " ";
  ImagePicker _picker = ImagePicker();
  XFile? image;
  bool img = false;
  bool h = false, h1 = false, h2 = false, h3 = false;
  bool error = false, error1 = false, error2 = false, error3 = false;
  String city = "Enter City...";
  Database ?database;
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    permision();
    datebes();
    super.initState();
  }
  permision()
  async {
    var status = await Permission.storage.status;
    if(status.isDenied)
      {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
        ].request();
        print(statuses[Permission.storage]);
      }
  }
  datebes()
  async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'dhruv.db');


// open the database
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE form (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, contact TEXT,email TEXT,password TEXT,gender TEXT,hobbies TEXT,city TEXT,image TEXT)');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Form for student"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Camera & gallery"),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              image = await _picker.pickImage(
                                  source: ImageSource.camera);
                              setState(() {
                                img = true;
                              });
                              Navigator.pop(context);
                            },
                            child: Text("camera")),
                        TextButton(
                            onPressed: () async {
                              image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                img = true;
                              });
                              Navigator.pop(context);
                            },
                            child: Text("gallery"))
                      ],
                    );
                  },
                );
              },
              child: (img == true)
                  ? SizedBox(
                  height: 170,
                  width: 170,
                  child: CircleAvatar(
                    backgroundImage: FileImage(File(image!.path)),
                  ))
                  : Image(
                image: AssetImage("image/2521826.png"),
                height: 170,
                width: 170,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                  controller: t1,
                  decoration: InputDecoration(errorText: (error==true)?"Enter valid Name":null,
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2,color: Colors.red)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2,color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyanAccent),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent),
                          borderRadius: BorderRadius.circular(10)),
                      label: Text(
                        "Enter Name",
                        style: TextStyle(color: Colors.tealAccent),
                      ),
                      hintText: "Enter Name",
                      hintStyle: TextStyle(color: Colors.white)),
                  cursorColor: Colors.white),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                  maxLength: 10,
                  controller: t2,
                  decoration: InputDecoration(
                      errorText: (error1==true)?"Enter valid Contect":null,
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2,color: Colors.red)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2,color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyanAccent),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent),
                          borderRadius: BorderRadius.circular(10)),
                      label: Text(
                        " Contect No.",
                        style: TextStyle(color: Colors.tealAccent),
                      ),
                      hintText: "Contect No.",
                      hintStyle: TextStyle(color: Colors.white)),
                  cursorColor: Colors.white),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                  controller: t3,
                  decoration: InputDecoration(errorText: (error2==true)?"Enter valid Email":null,
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2,color: Colors.red)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2,color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyanAccent),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent),
                          borderRadius: BorderRadius.circular(10)),
                      label: Text(
                        "Enter Email",
                        style: TextStyle(color: Colors.tealAccent),
                      ),
                      hintText: "Enter Email",
                      hintStyle: TextStyle(color: Colors.white)),
                  cursorColor: Colors.white),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                  maxLength: 6,
                  obscureText: true,
                  controller: t4,
                  decoration: InputDecoration(errorText: (error3==true)?"Enter valid Password":null,
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2,color: Colors.red)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2,color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyanAccent),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent),
                          borderRadius: BorderRadius.circular(10)),
                      label: Text(
                        "Enter Password",
                        style: TextStyle(color: Colors.tealAccent),
                      ),
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: Colors.white)),
                  cursorColor: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: "male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value! as String;
                    });
                  },
                ),
                Text("Male"),
                Radio(
                  value: "Female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value! as String;
                    });
                  },
                ),
                Text("Famale"),
                Radio(
                    value: "Other",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value! as String;
                      },);
                    }),
                Text("Other")
              ],
            ),
            Text(""),
            Text("Hobbies"),
            Text(""),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("movie"),
                Checkbox(
                  value: h,
                  onChanged: (value) {
                    setState(() {
                      h = value!;
                    });
                  },
                ),
                Text("Cricket"),
                Checkbox(
                  value: h1,
                  onChanged: (value) {
                    setState(() {
                      h1 = value!;
                    });
                  },
                ),
                Text("Traveling"),
                Checkbox(
                  value: h2,
                  onChanged: (value) {
                    setState(() {
                      h2 = value!;
                    });
                  },
                ),
              ],
            ),
            DropdownButton(
              isExpanded: true,
              value: city,
              items: [
                DropdownMenuItem(
                  enabled: false,
                  alignment: Alignment.center,
                  child: Text("Enter City..."),
                  value: "Enter City...",
                ),
                DropdownMenuItem(
                  child: Text("Surat"),
                  value: "surat",
                ),
                DropdownMenuItem(
                  child: Text("Ahmedabad"),
                  value: "Ahmedabad",
                ),
                DropdownMenuItem(
                  child: Text("Vadodara"),
                  value: "Vadodara",
                ),
                DropdownMenuItem(
                  child: Text("Rajkot"),
                  value: "Rajkot",
                ),
                DropdownMenuItem(
                  child: Text("Morbi"),
                  value: "Morbi",
                ),
                DropdownMenuItem(
                  child: Text("Navsari"),
                  value: "Navsari",
                ),
              ],
              onChanged: (value) {
                setState(() {
                  city = value! as String;
                  print("city :- $city");
                });
              },
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  String strName, strContact, strEmail, strPassword;
                  strName = t1.text;
                  strContact = t2.text;
                  strEmail = t3.text;
                  strPassword = t4.text;
                  error=false;
                  error1=false;
                  error2=false;
                  error3=false;
                  var regExp=r'^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[789]\d{9}$';
                  RegExp rx=RegExp(regExp);
                  var regExp1=r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp rx1=RegExp(regExp1);


                  if (strName.isEmpty) {
                    error = true;
                    print("Enter valid Name");
                  } else if (strContact.isEmpty) {
                    error1 = true;
                    print("Enter valid Contact");
                  }
                  else if(!rx.hasMatch(strContact))
                    {
                      error1=true;
                    }else if (strEmail.isEmpty) {
                    error2 = true;
                    print("Enter valid Contact");
                  }
                  else if(!rx1.hasMatch(strEmail)) {
                    error2=true;
                }else if (strPassword.isEmpty) {
                    error3 = true;
                    print("Enter valid Contact");
                  } else {
                    String strhobby;
                    StringBuffer sb=StringBuffer();
                    if(h==true)
                    {
                      sb.write("movie");
                    }
                    if(h1==true)
                    {
                      if(sb.length>0)
                      {
                        sb.write("/");
                      }
                      sb.write("Cricket");
                    }
                    if(h2==true)
                    {
                      if(sb.length>0)
                      {
                        sb.write("/");
                      }
                      sb.write("Traveling");
                    }
                    strhobby=sb.toString();
                    var path=await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/dk";
                    Directory dir=Directory(path);
                    if(!await dir.exists())
                    {
                      await dir.create();
                    }
                    int r=Random().nextInt(1000);
                    String imageName ="img${r}.jpg";
                    File file=File("${dir.path}/${imageName}");
                    file.writeAsBytes(await image!.readAsBytes());
                    String strImage=file.path;

                    String insert="insert into form values(NULL,'$strName','$strContact','$strEmail','$strPassword','$gender','$strhobby','$city','$strImage')";
                    int d_row;
                    d_row=await database!.rawInsert(insert) ;
                    print("deta :- $d_row");
                    setState(() {
                      t1.text="";
                      t2.text="";
                      t3.text="";
                      t4.text="";
                    });

                  }
                  setState(() {});
                },
                child: Text("Submit")),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return view(database!);
              },));
            }, child: Text("View Data"))
          ]),
        ));
  }
}
