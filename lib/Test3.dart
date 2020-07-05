import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Carausel extends StatefulWidget {
  @override
  _CarauselState createState() => _CarauselState();
}
class _CarauselState extends State<Carausel> {
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
  PageController _pageController;
  int currentPage = 2;
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
              Row(
                children: <Widget>[
                  Container(
                    width: 391,
                    height: 150,
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
            ],
          ),
        ),
      ),
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
                width: Curves.easeOut.transform(value) * MediaQuery.of(context).size.width/5.5,
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