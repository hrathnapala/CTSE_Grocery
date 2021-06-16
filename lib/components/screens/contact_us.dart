import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    const twitterUrl = 'https://twitter.com';
    const facebookUrl = 'https://facebook.com';
    const instagramUrl = 'https://instagram.com';

    void _launchTwitterURL() async => await canLaunch(twitterUrl)
        ? await launch(twitterUrl)
        : throw 'Could not launch $twitterUrl';

    void _launchFBURL() async => await canLaunch(facebookUrl)
        ? await launch(facebookUrl)
        : throw 'Could not launch $facebookUrl';

    void _launchInstagramURL() async => await canLaunch(instagramUrl)
        ? await launch(instagramUrl)
        : throw 'Could not launch $instagramUrl';

    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('Contact Us'),
          centerTitle: true,
          backgroundColor: Colors.grey[850],
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/ShoppingList.png'),
                    radius: 40.0),
              ),
              Divider(
                height: 60.0,
                color: Colors.blue[100],
              ),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.blue[100],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'EMAIL',
                    style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'contact@groceryapp.com',
                style: TextStyle(
                    color: Colors.blue,
                    letterSpacing: 2.0,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'PHONE',
                    style:
                        TextStyle(color: Colors.blue[100], letterSpacing: 2.0),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '+9451234567',
                style: TextStyle(
                    color: Colors.blue,
                    letterSpacing: 2.0,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 200.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: _launchTwitterURL,
                        icon: FaIcon(
                          FontAwesomeIcons.twitter,
                          color: Colors.blue[100],
                          size: 40.0,
                        )),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: _launchInstagramURL,
                        icon: FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Colors.blue[100],
                          size: 40.0,
                        )),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: _launchFBURL,
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue[100],
                          size: 40.0,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ));
  }
}
