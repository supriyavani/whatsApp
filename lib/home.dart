import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedCountry = "+91";
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('WhatsApp'),
        ),
        body: SingleChildScrollView(
          child: Container(
           margin: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    flex: 25,
                    child: CountryCodePicker(
                      onChanged: (item) {
                        setState(() {
                          selectedCountry = item.dialCode;
                        });
                      },
                      initialSelection: 'IN',
                      favorite: ["+91", 'IN'],
                    ),
                  ),
                  Expanded(
                    flex: 75,
                    child: TextField(
                      controller: _phoneNumber,
                      minLines: 1,
                      decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          hintText: 'Enter your number here',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 15,
                    ),
                  ),
                ]),
                Padding(padding: EdgeInsets.all(16)),
                TextField(
                  controller: _message,
                  minLines: 3,
                  maxLines: 2000,
                  decoration: InputDecoration(
                      labelText: 'Message',
                      hintText: 'Type your message here',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                ),
                Padding(padding: EdgeInsets.all(16)),
                MaterialButton(
                  onPressed: () {
                    sendMessage();
                  },
                  color: Colors.teal,
                  child: Text('Send Message'),
                )
              ],
            ),
          ),
        ),
      );

  void sendMessage() {
    var number, messages;
    number = selectedCountry + _phoneNumber.text;
    messages = _message.text;
    if (_phoneNumber.text == null || _phoneNumber.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' Please enter a valid mobile number')));
      return;
    }

    var url = Uri.parse(
        "https://wa.me/$number?text=" + Uri.encodeComponent(messages));


    _launchURL(url);

  }

  void _launchURL(var url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
