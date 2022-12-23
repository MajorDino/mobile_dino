// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_dino/CardBuild.dart';
import 'package:percent_indicator/percent_indicator.dart';

bool light = WidgetsBinding.instance!.platformDispatcher.platformBrightness == Brightness.light ? true : false;
final Color darkcolor = Color(0xFF121212);
final Color lightcolor = Color(0xFFFFFFFF);

void main() { //Método principal
  runApp(
    MaterialApp( //Método que executa o aplicativo e método MaterialApp() que define as principais características do mesmo
      debugShowCheckedModeBanner: false, //Retira a mensagem de debug que por padrão aparece sobre a aplicação
      title: "DinoDex", //Título do projeto
      home: myHome() //Classe que substitui nossa tela de Home
    )
  );
}

class myHome extends StatefulWidget {
  const myHome({ Key? key }) : super(key: key);

  @override
  State<myHome> createState() => _myHomeState();
}

class _myHomeState extends State<myHome> with TickerProviderStateMixin {
  bool showFAB = true;

  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )..forward();

  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _animation.dispose();
  }

  //AMARELO 235, 188, 90
  //VERDE 80, 169, 130
  //AZUL 115, 172, 204
  //ROSA 198, 130, 234
  Color coloring(int index) {
    Color cor;
    cor = Color.fromARGB(255, 207 + (index * (-20 / DinoList.length)).toInt(), 102 + (index * (32 / DinoList.length)).toInt(), 121 + (index * (131 / DinoList.length)).toInt());
    return cor;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( //Utilização de Scaffold() para formatação de cabeçalho e corpo da aplicação
      /*appBar: AppBar(
        title: 
          Text(
            "DINO-DEX",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              letterSpacing: 1
            ),
            textAlign: TextAlign.center
          ),
        backgroundColor: Colors.purple
      ),*/
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, __) => [
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                },
                tooltip: 'Pesquisar'
              )
            ],
            backgroundColor: Colors.purple,
            //centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: light ? Alignment.topRight : Alignment.topLeft,
                  end: light ? Alignment.bottomLeft : Alignment.bottomRight,
                  colors: [/*Color(0xFF3700B3),*/ Colors.purple, Color(0XFF6200EE)]
                ),
              ),
            ),
            floating: true,
            snap: true,
            title: Text(
              "DINO.DEX",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                letterSpacing: 1
              ),
              textAlign: TextAlign.center
            )
          )
        ],
        body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Container(
            child: NotificationListener<UserScrollNotification>(
              onNotification: (scroll) {
                if (scroll.direction == ScrollDirection.reverse && showFAB) {
                  _controller.reverse();
                  showFAB = false;
                }
                else if (scroll.direction == ScrollDirection.forward && !showFAB){
                  _controller.forward();
                  showFAB = true;
                }
                return true;
              },
              child: ListView.builder(
                itemCount: DinoList.length,
                itemBuilder: (context, index){
                  return /*TileItem(num: index);*/ Card(
                    child: Container(
                      child:
                        //Text(DinoList[index]['Name'].toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        buildText(context, index, coloring(index)),
                      color: coloring(index)
                    ),
                    clipBehavior: Clip.antiAlias,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  );
                }
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 5, color: Color(0xFFBB86FC)), // 255, 207, 102, 121 - 255, 187, 134, 252
              color: light ? lightcolor : darkcolor //0xFF1F1B24
            ),
            padding: EdgeInsets.all(7) //Margens internas (Left, Top, Right, Bottom)
          )
        )
      ),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              light = (light ? false : true);
            });
          },
          backgroundColor: Colors.purple,
          child: Icon(light ? Icons.dark_mode : Icons.light_mode),
        )
      )
    );
  }
}

class DataSearch extends SearchDelegate<String?> {
  List<String> dinoNames = [];
  late final List<String> dinoNamesPT_BR;
  late int _indice;

  List<String> receivingDinoList() {
    List<String> result = [];
    for (int i = 0; i < DinoList.length; i++) {
      result.add(DinoList[i]["Name"].toString().toLowerCase());
      result.add(DinoList[i]["Scifi"].toString().toLowerCase());
    }
    return result;
  }

  List<String> receivingDinosPT_BR(List<String> list) {
    List<String> result = [];
    for (int i = 0; i < list.length; i += 2) {
      result.add(list[i]);
    }
    return result;
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    if (dinoNames.isEmpty) {
      dinoNames = receivingDinoList();
      dinoNamesPT_BR = receivingDinosPT_BR(dinoNames);
    }
    return ThemeData(
      hintColor: Colors.white,
      textTheme: TextTheme(
        headline6: TextStyle( // headline 6 affects the query text
          color: Colors.white,
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          //fontWeight: FontWeight.bold
        )
      ),
      appBarTheme: AppBarTheme(
        color: Colors.purple
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        query = "";
        showSuggestions(context);
      }
    )];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    Color cor = Color.fromARGB(255, 207 + (_indice * (-20 / DinoList.length)).toInt(), 102 + (_indice * (32 / DinoList.length)).toInt(), 121 + (_indice * (131 / DinoList.length)).toInt());

    return Container(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index){
          return Card(
            child: Container(
              child:
                buildText(context, _indice, cor),
              color: cor
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )
          );
        }
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: Color(0xFFBB86FC)), // 255, 207, 102, 121 - 255, 187, 134, 252
        color: light ? lightcolor : darkcolor
      ),
      padding: EdgeInsets.all(7),
      width: double.infinity,
      height: double.infinity
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionList = query.isEmpty ? dinoNamesPT_BR : dinoNames.where((p) => p.startsWith(query.toLowerCase())).toList();
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.0, color: Color(0xFFBB86FC)),
          left: BorderSide(width: 5.0, color: Color(0xFFBB86FC)),
          right: BorderSide(width: 5.0, color: Color(0xFFBB86FC)),
          bottom: BorderSide(width: 5.0, color: Color(0xFFBB86FC)),
        ), //all(width: 5, color: Color(0xFFBB86FC)),
        color: light ? lightcolor : darkcolor
      ),
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.search, color: Colors.grey),
          onTap: () {
            _indice = (dinoNames.indexOf(suggestionList[index].toLowerCase()) / 2).toInt();
            showResults(context);
          },
          textColor: light ? darkcolor : lightcolor,
          tileColor: light ? lightcolor : darkcolor,
          title: RichText(text: TextSpan(
            children: [
              TextSpan(
                text: suggestionList[index].toLowerCase().substring(query.length),
                style: TextStyle(color: Colors.grey, fontSize: 16)
              ),
            ],
            style: TextStyle(color: Color.fromARGB(255, 115, 172, 204), fontSize: 16, fontWeight: FontWeight.bold),
            text: suggestionList[index].toLowerCase().substring(0, query.length),
          ))
        ),
        itemCount: suggestionList.length,
      )
    );
  } 
}