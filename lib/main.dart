import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'Test3.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;
  int currentPage = 2;
  var dummyData = [
    {
      "Number": '0'
    },
    {
      "Number": '1'
    },
    {
      "Number": '2'
    },
    {
      "Number": '3'
    },
    {
      "Number": '4'
    },
    {
      "Number": '5'
    }
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.19,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
               Text('Story Time Wrap',style: TextStyle(fontSize: 18,color: Color(0xff4A5568)),),
           ],),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 300,
                child:Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: 20,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(width: MediaQuery.of(context).size.width * .4,height: 15,color: Color(0xff667EEA)),
                          Container(width:MediaQuery.of(context).size.width * .8,height: 10,color: Color(0xff667EEA))
                        ],
                      ),
                    ),
                    Positioned(
                      bottom:100,
                        left: 60,
                         child: Container(
                           width: MediaQuery.of(context).size.width * .7,
                           height: 115,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8),
                             color: Colors.white,
                             boxShadow: [
                               BoxShadow(
                                 blurRadius: 2,
                                 offset: Offset(1,1),
                                 color: Color(0xff000000).withOpacity(.25),
                                 spreadRadius: 1,
                                 // changes position of shadow
                               ),
                             ],
                           ),
                           child: Padding(
                             padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: <Widget>[
                                 Row(children: <Widget>[
                                   Text('24th june,09:30 am',style: TextStyle(fontSize: 12,color: Color(0xff718096)),),
                                 ],),

                                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: <Widget>[
                                   matrixwidget(firstRowfirstCol:'05',firstRowSecndCol: 'k',
                                       secndRow: 'Impression'
                                   ),
                                   matrixwidget(firstRowfirstCol:'05',firstRowSecndCol: 'k',
                                       secndRow: 'Reach'
                                   ),
                                 ],)
                               ],
                             ),
                           ),
                         )
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 150),

                      child: PageView.builder(
                        onPageChanged: (value){
                          setState(() {
                            currentPage = value;
                          });
                        },
                        controller: _pageController,
                        itemCount: dummyData.length + 2,
                        allowImplicitScrolling: true,
                        itemBuilder: (context, index) => aminatedItemBuilder(index, dummyData.length),
                      ),
                    ),

                  ],
                ),
              ),

            ]
        ),
      ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  aminatedItemBuilder(int index, int len){
    if(index < (len)) {
      return AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double value = 1;
          if (_pageController.position.haveDimensions) {
            print('page = ${_pageController
                .page} - index = $index and currentPage =  $currentPage');
            value = _pageController.page - index -2;
            print('value1 = $value');
            value = (1.4 - (value.abs())).clamp(0.4, 1.0);
            print('value2 = $value');
          }
          return Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: Curves.easeOut.transform(value) * 120,
                width: Curves.easeOut.transform(value) * MediaQuery.of(context).size.width/5.6,
                child: child,
              ),],
          );
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: index % 2 == 0 ? Colors.amber : Colors.lightGreen,
              boxShadow: [BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 5.0,
              ),]
          ),
          child: Text('${dummyData[index].values}'),
        ),
      );
    }
    else{
      return Container(
      );
    }
  }
}
Widget matrixwidget(
    {@required String firstRowfirstCol,
      String firstRowSecndCol,
      @required String secndRow}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            firstRowfirstCol,
            style: TextStyle(
              color: Color(0xff616161),
              fontSize: 28,
            ),
          ),
          Text(
            firstRowSecndCol,
            style: TextStyle(
              color: Color(0xff616161),
              fontSize: 18,))
        ],
      ),
      Text(
        secndRow,
        style:  TextStyle(
          color: Color(0xff718096),
          fontSize: 12,)
      ),
    ],
  );
}
