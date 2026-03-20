import 'package:flutter/material.dart';
import 'jeu_page.dart';

enum Niveau { facile, moyen, difficile }

class NiveauPage extends StatelessWidget {
  const NiveauPage({super.key});

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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    _BackButton(onTap: () => Navigator.pop(context)),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'CHOISIR UN NIVEAU',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 44),
                  ],
                ),
              ),

              // Hero
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF00E676).withValues(alpha: 0.15),
                        border: Border.all(
                          color: const Color(0xFF00E676).withValues(alpha: 0.4),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.sports_soccer_rounded,
                        color: Color(0xFF00E676),
                        size: 44,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Quel est ton niveau ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Choisis et lance la partie !',
                      style: TextStyle(color: Colors.white38, fontSize: 13),
                    ),
                  ],
                ),
              ),

              // Cards niveau
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _NiveauCard(
                        niveau: Niveau.facile,
                        titre: 'FACILE',
                        description: 'Tu as 10 secondes pour identifier chaque joueur.',
                        details: '10 sec · +8 pts · Joueurs célèbres',
                        emoji: '🟢',
                        couleur: const Color(0xFF00E676),
                        icone: Icons.sentiment_satisfied_alt_rounded,
                        tempsMs: 10000,
                      ),
                      const SizedBox(height: 12),
                      _NiveauCard(
                        niveau: Niveau.moyen,
                        titre: 'MOYEN',
                        description: 'Réfléchis vite, 2 secondes par joueur !',
                        details: '2 sec · +15 pts · Mix de joueurs',
                        emoji: '🟡',
                        couleur: const Color(0xFFFFD600),
                        icone: Icons.sentiment_neutral_rounded,
                        tempsMs: 2000,
                      ),
                      const SizedBox(height: 12),
                      _NiveauCard(
                        niveau: Niveau.difficile,
                        titre: 'DIFFICILE',
                        description: '1 seconde seulement. Réfléchis très vite !',
                        details: '1 sec · +25 pts · Joueurs variés',
                        emoji: '🔴',
                        couleur: const Color(0xFFFF5252),
                        icone: Icons.local_fire_department_rounded,
                        tempsMs: 1000,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _NiveauCard extends StatelessWidget {
  final Niveau niveau;
  final String titre;
  final String description;
  final String details;
  final String emoji;
  final Color couleur;
  final IconData icone;
  final int tempsMs;

  const _NiveauCard({
    required this.niveau,
    required this.titre,
    required this.description,
    required this.details,
    required this.emoji,
    required this.couleur,
    required this.icone,
    required this.tempsMs,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => JeuPage(niveau: niveau, tempsEnMillisecondes: tempsMs),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: couleur.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: couleur.withValues(alpha: 0.45), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: couleur.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(icone, color: couleur, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        titre,
                        style: TextStyle(
                          color: couleur,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(emoji, style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    details,
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: couleur, size: 16),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white12),
        ),
        child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
      ),
    );
  }
}