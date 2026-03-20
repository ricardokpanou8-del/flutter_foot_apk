import 'package:flutter/material.dart';
import 'jeu_page.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Accueil")),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                children: [
                  Container(height: 400, child: Image.asset("assets/img_enfant_courant.jpg")),
                  Text("Bienvenue sur TestApp, notre premiere appli flutter.", style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print("Le Container de Jouer a été appuyé");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return jeu_page(); 
                          },
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.grey.withValues(alpha: 0.4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.play_arrow, size: 48), Text("Jouer")],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.red.withValues(alpha: 0.4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.info, size: 48), Text("A propos")],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.yellow.withValues(alpha: 0.4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.call, size: 48), Text("Contact")],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.green.withValues(alpha: 0.4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.close, size: 48), Text("Fermer")],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}