import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vehicle_parking/constants/global_variables.dart';
import 'package:vehicle_parking/pages/home/account_details.dart';
import 'package:vehicle_parking/pages/home/services/home_services.dart';

// ignore: must_be_immutable
class Userdetails extends StatefulWidget {
  Userdetails({
    Key? key,
  }) : super(key: key);

  @override
  _UserdetailsState createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  bool emptyname = false;
  bool emptyaddress = false;
  bool emptyphone = false;
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController name = TextEditingController();
  List detailss = [];
  List userss = [];

  @override
  void initState() {
    super.initState();
    _userdata();
  }

  final SnackBar _snackBar = const SnackBar(
    content: Text('Details Updated!'),
    duration: Duration(seconds: 3),
  );
  final SnackBar _snackBar1 = const SnackBar(
    content: Text('Server Error!'),
    duration: Duration(seconds: 3),
  );
  _userdata() {
    HomeService.userData().then((response) async {
      if (response.statusCode == 200) {
        var vData = json.decode(response.body);
        setState(() {
          phone.text =  vData['phone'];
          address.text = vData['address'];
          name.text = vData['name'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(_snackBar1);
      }
    });
  }

  _userupdate(String name, String address, String phone) {
    HomeService.updateUserData(name, address, phone).then((response) async {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AccountDetails()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(_snackBar1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.blueColor,
        title: const Text(
          "UPDATE DETAILS",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                       
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 60.0,
                              foregroundImage:
                                  ExactAssetImage('assets/images/logo.png'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              name.text,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextFormField(
                            //initialValue: widget.dataage.toString(),
                            controller: name,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              labelText: 'Name',
                              hintText: 'Name',
                              errorText: emptyname ? 'Please Fill the box' : '',
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            //initialValue: widget.dataphn.toString(),
                            controller: phone,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              labelText: 'Phone',
                              hintText: 'Phone Number',
                              errorText:
                                  emptyphone ? 'Please Fill the box' : '',
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            //initialValue: widget.dataaddress,
                            controller: address,
                            obscureText: false,
                            style: const TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              labelText: 'Address',
                              hintText: 'Address',
                              errorText:
                                  emptyaddress ? 'Please Fill the box' : '',
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              left: 210,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (phone.text.isEmpty) {
                                  setState(() {
                                    emptyphone = true;
                                  });
                                } else if (address.text.isEmpty) {
                                  setState(() {
                                    emptyaddress = true;
                                  });
                                } else if (name.text.isEmpty) {
                                  setState(() {
                                    emptyname = true;
                                  });
                                } else {
                                  setState(() {
                                    emptyaddress = false;
                                    emptyname = false;
                                    emptyphone = false;
                                    final String addres = address.text;
                                    final String phn = phone.text;
                                    final String nam = name.text;
                                    _userupdate(nam, phn, addres);
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(3, 218, 197, 1),
                                fixedSize: const Size(140, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Save",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.face_4_outlined,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
