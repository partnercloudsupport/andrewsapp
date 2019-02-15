import 'dart:async';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import '../models/serviceItem.dart';
import '../models/job.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class AddServiceItems extends StatefulWidget {
  final FirebaseUser user;
  final JobModel currentJob;
  AddServiceItems({Key key, this.user, this.currentJob}) : super(key: key);

  @override
  _AddServiceItemsState createState() => _AddServiceItemsState();
}

class _AddServiceItemsState extends State<AddServiceItems> {
  // final _serviceItemList = List<ServiceItem>();

  // once the form submits, this is flipped to true, and fields can then go into autovalidate mode.
  bool _autoValidate = false;
  bool _hasImage = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> litems = [];
  TextEditingController lengthController = new TextEditingController();
  TextEditingController widthController = new TextEditingController();
  TextEditingController notesController = new TextEditingController();

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient
  final GlobalKey<FormState> _dateKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _notesKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _hasUrineKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _sizeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _widthKey = GlobalKey<FormState>();
  Future<File> _imageFile;
  final TextEditingController eCtrl = new TextEditingController();
  int _act = 1;
  int currStep = 1;
  DateTime today = new DateTime.now();
  var twentyOnedaysFromNow;

  // class _StepperBodyState extends State<StepperBody> {
  // int currStep = 0;
  static var _focusNode = new FocusNode();
  // GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  // static MyData data = new MyData();
  ServiceItem _currentItem =
      ServiceItem(length: 0, width: 0, pictures: new List());

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });

    // _currentItem.pictures.add('https://picsum.photos/200/300');

    twentyOnedaysFromNow = today.add(new Duration(days: 21));
  }

  int current_step = 0;

  List<Step> my_steps = [
    new Step(
        // Title of the Step
        title: new Text("Size"),
        // Content, it can be any widget here. Using basic Text for this example
        content: new Text("Notes!"),
        isActive: true),
    new Step(
        title: new Text("Notes"),
        content: new Text("World!"),
        // You can change the style of the step icon i.e number, editing, etc.
        state: StepState.editing,
        isActive: true),
    new Step(
        title: new Text("Due"),
        content: new Text("Hello World!"),
        isActive: true),
  ];

  Widget customerPanel() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                widget.currentJob.customer.firstName +
                    ' ' +
                    widget.currentJob.customer.lastName,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(widget.currentJob.customer.phones.first.toString()),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Text(  widget.newJob.customer.address.streetAddress + widget.newJob.customer.address.city + widget.newJob.customer.address.state + widget.newJob.customer.address.zipcode),
                  (widget.currentJob.customer.address.pretty != null)
                      ? Text(widget.currentJob.customer.address.pretty)
                      : Text(
                          "Due 02/25/2019",
                          style: TextStyle(
                              color: Colors.orange.shade800,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: ListView(children: <Widget>[
          _getToolbar(context),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Add',
                          style: new TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'ServiceItems',
                          style:
                              new TextStyle(fontSize: 28.0, color: Colors.grey),
                        )
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.0, left: 0.0, right: 0.0),
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[]),
          ),
          _previewImage()
        ]),
        bottomNavigationBar: new Stack(
          overflow: Overflow.visible,
          alignment: new FractionalOffset(.5, 1.0),
          children: [
            new Container(
              height: 40.0,
              color: Colors.red,
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: new FloatingActionButton(
                onPressed: () => print('hello world'),
                child: new Icon(Icons.arrow_back),
              ),
            ),
          ],
        ));
  }

  Future<String> uploadImage(image) async {
    // FirebaseStorage _storage = FirebaseStorage.instance;
    var uuid = new Uuid().v1();
    String downloadUrl;
    StorageReference ref =
        FirebaseStorage.instance.ref().child("post_$uuid.jpg");

    await ref.put(image).onComplete.then((val) {
      val.ref.getDownloadURL().then((val) {
        print(val);
        downloadUrl = val; //Val here is Already String
      });
    });
    var url = await ref.getDownloadURL() as String;

    _currentItem.pictures.add(downloadUrl);

    return downloadUrl as String;
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            uploadImage(snapshot.data);

            Column(children: <Widget>[
              //   ListView(
              //       physics: const BouncingScrollPhysics(),
              //       padding: EdgeInsets.only(left: 40.0, right: 40.0),
              //       scrollDirection: Axis.horizontal,
              //       children:
              //  getPictureList(_currentItem.pictures) as List<Widget>),
              Opacity(
                opacity: 0.0,
                child: new CarouselSlider(
                  items: _currentItem.pictures.map((url) {
                    return Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Image.network(
                              url.toString(),
                              fit: BoxFit.cover,
                              width: 800.0,
                            )));
                  }).toList(),
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                  height: 250,
                  autoPlay: false,
                ),
              ),
              customerPanel(),
              Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 18, right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // formBuilder(),
                      Expanded(
                        flex: 2,
                        child: ListTile(
                            leading: _buildCardSettingsInt_Length(),
                            // leading: Image.file(snapshot.data),
                            enabled: _act == 1,
                            onTap: () {/* react to the tile being tapped */}),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListTile(
                            leading: _buildCardSettingsInt_Width(),
                            // leading: Image.file(snapshot.data),
                            enabled: _act == 1,
                            onTap: () {/* react to the tile being tapped */}),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(top: 100.0, right: 18, left: 18),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ListTile(
                          leading: _buildCardSettingsInt_Notes(),
                          // leading: Image.file(snapshot.data),
                          enabled: _act == 1,
                          onTap: () {
                            /* react to the tile being tapped */
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100.0, left: 18, right: 18),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        child: new Text(
                          "Finished",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        elevation: 4.0,
                        splashColor: Colors.deepPurple,
                        onPressed: saveItem(false),
                      ),
                    ),
                    Container(
                      width: 18,
                    ),
                    Expanded(
                      flex: 1,
                      child: new RaisedButton(
                        child: new Text(
                          "Add more",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        elevation: 4.0,
                        splashColor: Colors.deepPurple,
                        onPressed: saveItem(true),
                      ),
                    ),
                  ],
                ),
              ),
            ]);
          } else if (snapshot.error != null) {
            return const Text(
              'Error picking image.',
              textAlign: TextAlign.center,
            );
          } else {
            return _buildCameraButton(context);
          }
        });
  }

  saveItem(b) {}
  Padding _buildCameraButton(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: new Column(
        children: <Widget>[
          new Container(
            width: 50.0,
            height: 50.0,
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.black38),
                borderRadius: BorderRadius.all(Radius.circular(7.0))),
            child: new IconButton(
              icon: new Icon(Icons.camera),
              onPressed: () {
                _onImageButtonPressed(ImageSource.camera);
              },
              iconSize: 30.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child:
                Text('Take Picture', style: TextStyle(color: Colors.black45)),
          ),
        ],
      ),
    );
  }

  buildDateTimePicker() {
    final dateFormat = DateFormat("dd-M-yyyy");
    return DateTimePickerFormField(
        dateOnly: true,
        format: dateFormat,
        validator: (val) {
          if (val != null) {
            return null;
          } else {
            return 'Date Field is Empty';
          }
        },
        decoration: InputDecoration(labelText: 'Select Date'),
        initialValue: DateTime.now(), //Add this in your Code.
        // initialDate: DateTime(2017),
        onSaved: (value) {
          debugPrint(value.toString());
        });
  }

  Padding _getToolbar(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
      child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        new Image(
            width: 40.0,
            height: 40.0,
            fit: BoxFit.cover,
            image: new AssetImage('assets/icon.png')),
      ]),
    );
  }

  void _onImageButtonPressed(ImageSource source) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.camera);
    });
  }

  TextFormField _buildCardSettingsInt_Notes() {
    return new TextFormField(
      decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
          filled: true,
          // icon: Icon(Icons.phone),
          labelText: 'Notes',
          suffixIcon: new FlatButton(
              onPressed: () {
                notesController.clear();
              },
              child: new Icon(Icons.clear))),
      // keyboardType: TextInputType.phone,
      // initialValue: '(903) 926-9768',
      // onSaved: (String value) {
      //   _phoneNumber = value.; },
      // validator: _validatePhoneNumber,
      maxLength: 114,
      // initialValue: '(903) ',
      controller: notesController,
      inputFormatters: <TextInputFormatter>[
        // WhitelistingTextInputFormatter.digitsOnly,
        // Fit the validating format.
        // _phoneNumberFormatter,
      ],
      autofocus: true,
      style: TextStyle(
        fontSize: 22.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      maxLines: 5,

      textCapitalization: TextCapitalization.sentences,
    );
    // return CardSettingsInt(
    //   key: _sizeKey,
    //   label: 'Leght',
    //   unitLabel: 'feet',
    //   initialValue: _currentItem.length,
    //   onSaved: (value) => _currentItem.length = value,
    //   onChanged: (value) => _showSnackBar('Height', value),
    // );
  }

  TextFormField _buildCardSettingsInt_Length() {
    return new TextFormField(
      decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
          filled: true,
          // icon: Icon(Icons.phone),
          labelText: 'Length',
          suffixIcon: new FlatButton(
              onPressed: () {
                lengthController.clear();
              },
              child: new Icon(Icons.clear))),
      keyboardType: TextInputType.phone,
      // initialValue: '(903) 926-9768',
      // onSaved: (String value) {
      //   _phoneNumber = value.; },
      // validator: _validatePhoneNumber,
      maxLength: 14,

      // initialValue: '(903) ',
      controller: lengthController,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
        // Fit the validating format.
        // _phoneNumberFormatter,
      ],
      autofocus: true,
      style: TextStyle(
        fontSize: 22.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),

      // textCapitalization: TextCapitalization.none,
    );
    // return CardSettingsInt(
    //   key: _sizeKey,
    //   label: 'Leght',
    //   unitLabel: 'feet',
    //   initialValue: _currentItem.length,
    //   onSaved: (value) => _currentItem.length = value,
    //   onChanged: (value) => _showSnackBar('Height', value),
    // );
  }

  TextFormField _buildCardSettingsInt_Width() {
    return new TextFormField(
      decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
          filled: true,
          // icon: Icon(Icons.phone),
          labelText: 'Width',
          suffixIcon: new FlatButton(
              onPressed: () {
                widthController.clear();
              },
              child: new Icon(Icons.clear))),
      keyboardType: TextInputType.phone,
      // initialValue: '(903) 926-9768',
      // onSaved: (String value) {
      //   _phoneNumber = value.; },
      // validator: _validatePhoneNumber,
      maxLength: 14,
      // initialValue: '(903) ',
      controller: widthController,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
        // Fit the validating format.
        // _phoneNumberFormatter,
      ],
      autofocus: true,
      style: TextStyle(
        fontSize: 22.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),

      // textCapitalization: TextCapitalization.none,
    );
  }

  CardSettingsButton _buildCardSettingsButton_Save() {
    return CardSettingsButton(
      label: 'SAVE',
      onPressed: _savePressed,
    );
  }

  CardSettingsText _buildCardSettingsText_Name() {
    return CardSettingsText(
      key: _dateKey,
      label: 'Name',
      hintText: 'something cute...',
      initialValue: _currentItem.notes,
      requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Name is required.';
        return null;
      },
      onSaved: (value) => _currentItem.notes = value,
      onChanged: (value) => _showSnackBar('Name', value),
    );
  }

  CardSettingsDatePicker _buildCardSettingsDatePicker() {
    return CardSettingsDatePicker(
      key: _dateKey,
      icon: Icon(Icons.calendar_today),
      label: 'Date',
      initialValue: _currentItem.dueDateTime,
      onSaved: (value) => _currentItem.dueDateTime =
          updateJustDate(value, _currentItem.dueDateTime),
      onChanged: (value) => _showSnackBar('Show Date', value),
    );
  }

  CardSettingsSwitch _buildCardSettingsHasUrine() {
    return CardSettingsSwitch(
      key: _hasUrineKey,
      label: 'Urine?',
      initialValue: false,
      onChanged: (value) {
        setState(() => _currentItem.hasUrine = value);
        _showSnackBar('Has Spots?', value);
      },
      onSaved: (value) => _currentItem.hasUrine = value,
    );
  }

  Future _savePressed() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      // showResults(context, _serviceItemList);
    } else {
      setState(() => _autoValidate = true);
    }
  }

  void _resetPressed() {
    _formKey.currentState.reset();
  }

  void _showSnackBar(String label, dynamic value) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(label + ' = ' + value.toString()),
      ),
    );
  }
}

class Contact {
  final String name;
  final String email;
  final String imageUrl;

  const Contact(this.name, this.email, this.imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}
