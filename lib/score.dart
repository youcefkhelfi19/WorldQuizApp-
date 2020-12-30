
import 'package:flutter/material.dart';
import 'package:world_capitals_quiz/home_page.dart';

class ScorePage extends StatefulWidget {
  final int mark;
  ScorePage({this.mark});
  @override
  _ScorePageState createState() => _ScorePageState(mark);
}

class _ScorePageState extends State<ScorePage> {
  int mark;
  _ScorePageState(this.mark);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Score'),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 6,
              child:Material(
                child: Container(
                  child: Column(
                    children: [
                      ClipRect(
                        child: Image(
                          image: AssetImage(
                            'images/good.png'
                          ),
                        ),
                      ),
                      Text('You got $mark point ')
                    ],
                  ),
                ),
              )

          ),
          Expanded(
            flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    OutlineButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
                        },
                        child: Text('Continue'),
                      borderSide: BorderSide(
                        color: Colors.blue,width: 5.0
                      ),
                        ),

                ],
              ))
        ],
      ),
    );
  }
}
