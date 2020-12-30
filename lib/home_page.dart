import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:world_capitals_quiz/quiz_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images=[
    "images/af.png",
    "images/am.png",
    "images/as.png",
    "images/au.png",
    "images/eu.png",
  ];
  Widget CustomCard(String contentName,String image){
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>GetJson()));
        },
        child: Material(
          color: Colors.green[900],
          elevation: 10.0,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(

                      height: 200.0,
                      width: 200.0,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(image),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(contentName,style: TextStyle(fontSize: 24.0,
                      color: Colors.white,
                      fontFamily: 'Alike',
                      fontWeight: FontWeight.w700),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text('The five content',
        style: TextStyle(
          fontFamily: 'Alike'
        ),
        ),
        elevation: 0.0,
        backgroundColor:Colors.green[900] ,
        centerTitle: true,
      ),
      body: ListView(
          children: [
            CustomCard('Australia',images[3]),
            CustomCard('Africa', images[0]),
            CustomCard('Asia',images[2]),
            CustomCard('America',images[1]),
            CustomCard('Europe',images[4]),


          ],
      ),
    );
  }
}
