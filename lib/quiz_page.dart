import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:world_capitals_quiz/score.dart';
class GetJson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("data/cpp.json"),
        builder:(context, snapshot){
          List myData = json.decode(snapshot.data.toString());
          if(myData==null){
              return Scaffold(
                body: Center(
                 child: Text('Loading...'),
                ),
              );
          }else{
           return QuizPage(myData: myData);
          }
        }
    );
  }
}
class QuizPage extends StatefulWidget {
  var myData;
  QuizPage({Key key , @required this.myData}) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState(myData);
}

class _QuizPageState extends State<QuizPage> {
  var myData  ;
  _QuizPageState(this.myData);
  Color optionColor=Colors.green[900];
  Color wrongAnswerColor=Colors.red;
  Color correctAnswerColor=Colors.green;
  int score=0;
  int i =1;
  int time=20;
  String showTime="20";
  bool cancelTimer=false;
  Map<String, Color> btnColors={
    "a": Colors.green[900],
    "b": Colors.green[900],
    "c": Colors.green[900],
    "d": Colors.green[900],
  };
  void nextQuestion(){
    cancelTimer=false;
    time=20;
  setState(() {
    if(i<2){
      i++;
    }
    else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ScorePage(mark:score ,)));
    }
    btnColors["a"] = Colors.green[900];
    btnColors["b"] = Colors.green[900];
    btnColors["c"] = Colors.green[900];
    btnColors["d"] = Colors.green[900];
  });
  startTimer();
  }
  void startTimer()async{
    const  oneSec=Duration(seconds: 1);

    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if(time<1){
          t.cancel();

          nextQuestion();
        }else if(cancelTimer==true){
          t.cancel();
        }
        else{
          time=time-1;
        }
        showTime=time.toString();
      });
    });
  }
  void checkAnswer(String k){
    if(myData[2]['1']==myData[1][i.toString()][k]){
      score=score+1;
      print(myData[1][i.toString()][k]);
      optionColor=correctAnswerColor;
    }else{
      optionColor=wrongAnswerColor;
      print(myData[1][i.toString()]);
    }
    setState(() {
      btnColors[k]=optionColor;
      cancelTimer=true;
    });
    Timer(Duration(seconds: 2), nextQuestion);
  }
  Widget optionButton(String k){
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20
      ),
      child: MaterialButton(
        minWidth: 200,
        height: 50,
        splashColor:  Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        color: btnColors[k],
       child: Text(myData[1][i.toString()][k],
       style: TextStyle(
         fontSize: 16,
          fontFamily: 'Alike',
          color: Colors.white,
       ),
       ),

        onPressed: (){
         checkAnswer(k);
       },
      ),
    );
  }
  @override
  void initState() {
    startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    return WillPopScope(
      onWillPop: (){
        return showDialog(
            context: context,
             builder: (context){
              return AlertDialog(
                title: Text('World Capitals'),
                content: Text("You can't go back"),
                actions: [
                  FlatButton(onPressed: (){
                      Navigator.pop(context);
                    },
                      child: Text('OK'))
                ],
              );
             }
        );
      },
      child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.teal[200],

                    child: Text(myData[0][i.toString()],
                    style: TextStyle(
                      fontFamily: 'Alike',
                      fontSize: 25,
                      color: Colors.green[900]
                    ),
                    ),
                  ) ),
              Expanded(
                  flex: 6,
                  child: Container(
                    width: MediaQuery.of(context).size.width,

                    decoration: BoxDecoration(
                      color: Colors.teal[200]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        optionButton('a'),
                        optionButton('b'),
                        optionButton('c'),
                        optionButton('d'),
                      ],
                    ),
                  ) ),
              
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.width*0.2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                      ),
                        color: Colors.teal
                    ),
                    child: Text(showTime,
                       style: TextStyle(
                         fontSize: 40,
                         color: Colors.white
                       ),
                    ),
                  ) ),
            ],
          ),
      ),
    );
  }
}
