import 'package:flutter/material.dart';

class AProposPage extends StatelessWidget {
  const AProposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A1628), Color(0xFF0D2137), Color(0xFF0A2E1A)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white12),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'À PROPOS',
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: 3),
                        ),
                      ),
                    ),
                    const SizedBox(width: 44),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      // Logo
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1E88E5), Color(0xFF0D47A1)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1E88E5).withValues(alpha: 0.4),
                              blurRadius: 28,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.sports_soccer_rounded, size: 56, color: Colors.white),
                      ),
                      const SizedBox(height: 18),
                      ShaderMask(
                        shaderCallback: (b) => const LinearGradient(
                          colors: [Color(0xFF00E676), Color(0xFFFFD600)],
                        ).createShader(b),
                        child: const Text(
                          'Football Quiz',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const Text('Version 1.0.0', style: TextStyle(color: Colors.white38, fontSize: 12)),
                      const SizedBox(height: 28),

                      _Carte(
                        icone: Icons.gamepad_rounded,
                        titre: 'Le Jeu',
                        contenu: 'Identifie le bon joueur parmi 9 cartes avant que le temps ne s\'écoule. Plus tu vas vite, plus tu marques de points !',
                        couleur: const Color(0xFF00E676),
                      ),
                      const SizedBox(height: 12),
                      _Carte(
                        icone: Icons.bar_chart_rounded,
                        titre: 'Les Niveaux',
                        contenu: '🟢 Facile — 4 sec · +10 pts\n🟡 Moyen — 2.5 sec · +15 pts\n🔴 Difficile — 1 sec · +25 pts',
                        couleur: const Color(0xFFFFD600),
                      ),
                      const SizedBox(height: 12),
                      _Carte(
                        icone: Icons.favorite_rounded,
                        titre: 'Les Vies',
                        contenu: 'Tu as 3 vies ❤️. Chaque mauvaise réponse ou temps écoulé t\'en coûte une. Game over à 0 vie !',
                        couleur: const Color(0xFFFF5252),
                      ),
                      const SizedBox(height: 12),
                      _Carte(
                        icone: Icons.code_rounded,
                        titre: 'Développement',
                        contenu: 'Développé avec Flutter & Dart.\nCréé avec ❤️ à Cotonou, Bénin 🇧🇯\npour les fans de football du monde entier.',
                        couleur: const Color(0xFF1E88E5),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        '© 2025 Football Quiz · Made in Bénin 🇧🇯',
                        style: TextStyle(color: Colors.white24, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Carte extends StatelessWidget {
  final IconData icone;
  final String titre;
  final String contenu;
  final Color couleur;

  const _Carte({
    required this.icone,
    required this.titre,
    required this.contenu,
    required this.couleur,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: couleur.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: couleur.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: couleur.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icone, color: couleur, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                titre,
                style: TextStyle(color: couleur, fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(contenu, style: const TextStyle(color: Colors.white60, fontSize: 13, height: 1.65)),
        ],
      ),
    );
  }
}