import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class SendSms extends StatefulWidget {
  @override
  State<SendSms> createState() => _SendSmsState();
}

class _SendSmsState extends State<SendSms> {
  final Telephony telephony = Telephony.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _msgController = TextEditingController();
  final TextEditingController _valueSms = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.text = '+8801928943835';
    _msgController.text = 'testing :)';
    _valueSms.text = '10';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'phone no is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'your phone no',
                        labelText: 'Phone No'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _msgController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Msg cannot be empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'message',
                      labelText: 'Message',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _valueSms,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите количество СМС';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Количество сообщений',
                      labelText: 'Количество',
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => _sendSMS(), child: const Text('send sms')),
                ElevatedButton(
                    onPressed: () => _getSMS(),
                    child: const Text('receive sms')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _sendSMS() async {
    int _sms = 0;
    while (_sms < int.parse(_valueSms.text)) {
      telephony.sendSms(
          to: _phoneController.text, message: _msgController.text);
      _sms++;
    }
  }

  _getSMS() async {
    List<SmsMessage> _messages = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
        filter:
            SmsFilter.where(SmsColumn.ADDRESS).equals(_phoneController.text));

    for (var msg in _messages) {
      print(msg.body);
    }
  }
}
