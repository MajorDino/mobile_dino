import 'package:mobile_dino/List_Dinos.dart';
import 'package:flutter/material.dart';
import 'package:mobile_dino/main.dart';
import 'package:mobile_dino/my_flutter_app_icons.dart';

var DinoList = ListDinos();

int kgton(var peso) {
  if (peso < 1) {
    return (peso * 1000).round();
  }
  return peso.round();
}

Column iconText(String danger) {
  Color cor1/*, cor2*/;
  IconData emoji;
  String txt;
  if (danger == '1') {
    cor1 = Color.fromARGB(255, 80, 169, 130);
    //cor2 = Colors.green;
    emoji = Icons.emoji_emotions;
    txt = "BAIXO";
  }
  else if (danger == '2') {
    cor1 = Color.fromARGB(255, 235, 188, 90);
    //cor2 = Color.fromARGB(255, 255, 230, 0);
    emoji = Icons.remove_circle;
    txt = "MÉDIO";
  }
  else if (danger == '3') {
    cor1 = Color(0xFFDA773E);
    //cor2 = Color.fromARGB(255, 255, 153, 0);
    emoji = Icons.cancel_sharp;
    txt = "ALTO";
  }
  else {
    cor1 = Color(0xFFB00020);
    //cor2 = Color.fromARGB(255, 255, 17, 0);
    emoji = Icons.dangerous_sharp; //gpp_bad
    txt = "ELEVADO";
  }
  return Column(
    children: [
      ShaderMask(
        blendMode: BlendMode.srcATop,
        child: Icon(
          emoji,
          //color: cor1,
          size: 50.0
        ),
        shaderCallback: (bounds) => LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [cor1, cor1],
        ).createShader(bounds),
      ),
      Text("NÍVEL DE PERIGO\n" + txt, style: TextStyle(color: light ? darkcolor : lightcolor, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
    ],
    mainAxisAlignment: MainAxisAlignment.center,
  );
}

Column foodIcon(String food) {
  Color cor;
  IconData emoji;
  String txt;
  if (food == '1') {
    cor = Color(0xFF94C263);
    emoji = Icons.eco;
    txt = "HERBÍVORO";
  }
  else if (food == '2') {
    cor = Color(0xFFC73737);
    emoji = MyFlutterApp.chicken_leg; //fluttericon.com
    txt = "CARNÍVORO";
  }
  else if (food == '3') {
    cor = Color.fromARGB(255, 235, 188, 90);
    emoji = MyFlutterApp.knife_fork;
    txt = "ONÍVORO";
  }
  else {
    cor = Color.fromARGB(255, 115, 172, 204);
    emoji = Icons.set_meal;
    txt = "PISCÍVORO";
  }
  return Column(
    children: [
      Icon(
        emoji,
        color: cor,
        size: 50.0
      ),
      Text(txt, style: TextStyle(color: light ? darkcolor : lightcolor, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
    ],
    mainAxisAlignment: MainAxisAlignment.center,
  );
}

Column sizeIcon(String size) { //health_and_safety & health_and_safety_rounded
  Color cor;
  String txt;
  if (size == '1') {
    cor = Color.fromARGB(255, 80, 169, 130);
    txt = "PEQUENO";
  }
  else if (size == '2') {
    cor = Color.fromARGB(255, 235, 188, 90);
    txt = "MÉDIO";
  }
  else if (size == '3') {
    cor = Color(0xFFDA773E);
    txt = "GRANDE";
  }
  else {
    cor = Color(0xFFB00020);
    txt = "GIGANTE";
  }
  return Column(
    children: [
      Icon(
        Icons.straighten,
        color: cor,
        size: 50.0
      ),
      Text("PORTE\n" + txt, style: TextStyle(color: light ? darkcolor : lightcolor, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
    ],
    mainAxisAlignment: MainAxisAlignment.center,
  );
}

Widget buildText(BuildContext context, int index, Color cor) => ExpansionTile(
  title: Center(child: Text(DinoList[index]['Name'].toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
  subtitle: Center(child: Text(DinoList[index]['Scifi'].toString(), style: TextStyle(color: Color(0xFF1F1B24), fontStyle: FontStyle.italic, fontWeight: FontWeight.bold))),
  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Image.asset(DinoList[index]["Foto"].toString(), fit: BoxFit.cover),
    Row(
      children: [
        Expanded(
          child: Container(
            child: Column(
              children: [
                Text(DinoList[index]['AlturaMax'] >= 0 ? "ALTURA" : "ENVERGADURA", style: TextStyle(color: cor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                Text((DinoList[index]['AlturaMin'] == null ? "" : ((DinoList[index]['AlturaMin']).abs().toString() + " - ")) + (DinoList[index]['AlturaMax']).abs().toString() + (double.parse(DinoList[index]['AlturaMax'].abs().toString()) < 2 ? " metro" : " metros"), style: TextStyle(color: light ? darkcolor : lightcolor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
              ],
            ),
            decoration: BoxDecoration(
              color: light ? lightcolor : darkcolor,
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            margin: EdgeInsets.fromLTRB(4, 2, 2, 2),
            padding: EdgeInsets.all(8)
          ),
        ),
        Expanded(
          child: Container(
            child: Column(
              children: [
                Text("COMPRIMENTO", style: TextStyle(color: cor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                Text((DinoList[index]['ComprimentoMin'] == null ? "" : (DinoList[index]['ComprimentoMin'].toString() + " - ")) + DinoList[index]['ComprimentoMax'].toString() + (double.parse(DinoList[index]['ComprimentoMax'].toString()) < 2 ? " metro" : " metros"), style: TextStyle(color: light ? darkcolor : lightcolor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
              ]
            ),
            decoration: BoxDecoration(
              color: light ? lightcolor : darkcolor,
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            margin: EdgeInsets.fromLTRB(2, 2, 4, 2),
            padding: EdgeInsets.all(8)
          )
        ),
      ]
    ),
    Row(
      children: [
        Expanded(
          child: Container(
            child:
              Column(children: [
                Text("PESO", style: TextStyle(color: cor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                Text((DinoList[index]['PesoMin'] == null ? "" : ((double.parse((DinoList[index]['PesoMax']).toString()) >= 1 ? (DinoList[index]['PesoMin']).toString() : kgton(DinoList[index]['PesoMin']).toString()) + " - ")) + (double.parse(DinoList[index]['PesoMax'].toString()) < 1 ? kgton(DinoList[index]['PesoMax']).toString() : DinoList[index]['PesoMax'].toString()) + (double.parse(DinoList[index]['PesoMax'].toString()) < 1 ? " quilo" : " tonelada") + (double.parse(kgton(DinoList[index]['PesoMax']).toString()) < 2 ? "" : "s"), style: TextStyle(color: light ? darkcolor : lightcolor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
              ]),
            decoration: BoxDecoration(
              color: light ? lightcolor : darkcolor,
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            margin: EdgeInsets.fromLTRB(4, 2, 2, 2),
            padding: EdgeInsets.all(8)
          )
        ),
        Expanded(
          child: Container(
            child:
              Column(children: [
                /*Text("TEMPO", style: TextStyle(color: cor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center),*/
                Text(DinoList[index]['TempoMax'].toString() + " - " + DinoList[index]['TempoMin'].toString() + "\nmilhões de anos", style: TextStyle(color: light ? darkcolor : lightcolor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
              ]),
            decoration: BoxDecoration(
              color: light ? lightcolor : darkcolor,
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            margin: EdgeInsets.fromLTRB(2, 2, 4, 2),
            padding: EdgeInsets.all(8)
          )
        )
      ]
    ),
    Container(
      child:
        Column(children: [
          Text("LOCAL", style: TextStyle(color: cor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          Text(DinoList[index]['Local'].toString(), style: TextStyle(color: light ? darkcolor : lightcolor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
        ]),
      decoration: BoxDecoration(
        color: light ? lightcolor : darkcolor,
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      margin: EdgeInsets.fromLTRB(4, 2, 4, 2),
      padding: EdgeInsets.all(8)
    ),
    Container(
      child: Row(
        children: [
          iconText(DinoList[index]['Danger'].toString()),
          foodIcon(DinoList[index]['Food'].toString()),
          //sizeIcon(DinoList[index]['Size'].toString())
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: BoxDecoration(
        color: light ? lightcolor : darkcolor,
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      height: 120,
      margin: EdgeInsets.fromLTRB(4, 2, 4, 4),
      padding: EdgeInsets.all(8)
    ),
    Text("#" + (index + 1).toString().padLeft(3, '0'), style: TextStyle(color: Color(0xFF121212), fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
    /*CircularPercentIndicator(
      animation: true,
      animationDuration: 1500,
      center: Text("100%"),
      lineWidth: 6.25,
      percent: 1.0,
      progressColor: Colors.green,
      radius: 60.0,
    )*/
  ]
);