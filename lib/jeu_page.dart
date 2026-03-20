import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'niveau.dart';

// ── Modèle Joueur ──
class Joueur {
  final String nom;
  final String prenom;
  final String club;
  final String nationalite;
  final String imageAsset;

  const Joueur({
    required this.nom,
    required this.prenom,
    required this.club,
    required this.nationalite,
    required this.imageAsset,
  });

  String get nomComplet => '$prenom $nom';
}

// ── Base de données joueurs ──
// imageAsset = chemin exact tel que déclaré dans pubspec.yaml
const List<Joueur> tousLesJoueurs = [
  Joueur(nom: 'MBAPPÉ',      prenom: 'Kylian',     club: 'Real Madrid',     nationalite: '🇫🇷 France',      imageAsset: 'assets/Kylian_Mbappe.jpg'),
  Joueur(nom: 'RONALDO',     prenom: 'Cristiano',  club: 'Al Nassr',        nationalite: '🇵🇹 Portugal',    imageAsset: 'assets/Cristiano_Ronaldo.jpg'),
  Joueur(nom: 'MESSI',       prenom: 'Lionel',     club: 'Inter Miami',     nationalite: '🇦🇷 Argentine',   imageAsset: 'assets/lionel_messi.jpg'),
  Joueur(nom: 'NEYMAR',      prenom: 'Neymar Jr',  club: 'Al Hilal',        nationalite: '🇧🇷 Brésil',      imageAsset: 'assets/Neymar.jpg'),
  Joueur(nom: 'HAALAND',     prenom: 'Erling',     club: 'Man City',        nationalite: '🇳🇴 Norvège',     imageAsset: 'assets/Erling_Haaland (2).jpg'),
  Joueur(nom: 'DE BRUYNE',   prenom: 'Kevin',      club: 'Man City',        nationalite: '🇧🇪 Belgique',    imageAsset: 'assets/debrune.jpg'),
  Joueur(nom: 'BENZEMA',     prenom: 'Karim',      club: 'Al Ittihad',      nationalite: '🇫🇷 France',      imageAsset: 'assets/benzemar.jpg'),
  Joueur(nom: 'VINICIUS',    prenom: 'Vinicius Jr',club: 'Real Madrid',     nationalite: '🇧🇷 Brésil',      imageAsset: 'assets/Vinicius_Jr.jpg'),
  Joueur(nom: 'PEDRI',       prenom: 'Pedri',      club: 'FC Barcelone',    nationalite: '🇪🇸 Espagne',     imageAsset: 'assets/pedri.jpg'),
  Joueur(nom: 'BELLINGHAM',  prenom: 'Jude',       club: 'Real Madrid',     nationalite: '🏴󠁧󠁢󠁥󠁮󠁧󠁿 Angleterre', imageAsset: 'assets/Belligham.jpg'),
  Joueur(nom: 'OSIMHEN',     prenom: 'Victor',     club: 'Galatasaray',     nationalite: '🇳🇬 Nigeria',     imageAsset: 'assets/Victor.jpg'),
  Joueur(nom: 'GRIEZMANN',   prenom: 'Antoine',    club: 'Atletico Madrid', nationalite: '🇫🇷 France',      imageAsset: 'assets/griezman.jpg'),
  Joueur(nom: 'KANE',        prenom: 'Harry',      club: 'Bayern Munich',   nationalite: '🏴󠁧󠁢󠁥󠁮󠁧󠁿 Angleterre', imageAsset: 'assets/Harry_Kane.jpg'),
  Joueur(nom: 'RASHFORD',    prenom: 'Marcus',     club: 'Aston Villa',     nationalite: '🏴󠁧󠁢󠁥󠁮󠁧󠁿 Angleterre', imageAsset: 'assets/Marcus_Rashford.jpg'),
  Joueur(nom: 'THURAM',      prenom: 'Marcus',     club: 'Inter Milan',     nationalite: '🇫🇷 France',      imageAsset: 'assets/MarcusThuram.jpg'),
  Joueur(nom: 'MODRIĆ',      prenom: 'Luka',       club: 'Real Madrid',     nationalite: '🇭🇷 Croatie',     imageAsset: 'assets/Luka_Modric.jpg'),
];

const List<Color> _couleursCarte = [
  Color(0xFF1565C0), Color(0xFFAD1457), Color(0xFF2E7D32),
  Color(0xFF4527A0), Color(0xFFE65100), Color(0xFF00695C),
  Color(0xFF37474F), Color(0xFF6A1B9A),
];

class JeuPage extends StatefulWidget {
  final Niveau niveau;
  final int tempsEnMillisecondes;

  const JeuPage({super.key, required this.niveau, required this.tempsEnMillisecondes});

  @override
  State<JeuPage> createState() => _JeuPageState();
}

class _JeuPageState extends State<JeuPage> with TickerProviderStateMixin {
  int score = 0;
  int vies = 3;
  int manche = 0;
  int positionBonneReponse = 0;
  List<Joueur> joueursAffiches = [];
  late Joueur joueurCible;
  bool jeuActif = true;
  Timer? _timer;
  double _progression = 1.0;
  String _feedback = '';
  bool _feedbackBon = true;
  bool _mancheEnCours = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _demarrerManche();
    });
  }

  void _demarrerManche() {
    if (!mounted) return;
    _timer?.cancel();
    _mancheEnCours = true;

    final rng = Random();
    final liste = List<Joueur>.from(tousLesJoueurs)..shuffle(rng);
    final huit = liste.take(8).toList();
    final bonnePos = rng.nextInt(8);

    setState(() {
      joueursAffiches = huit;
      positionBonneReponse = bonnePos;
      joueurCible = huit[bonnePos];
      _progression = 1.0;
      _feedback = '';
    });

    const intervalMs = 50;
    final totalTicks = widget.tempsEnMillisecondes ~/ intervalMs;
    int tick = 0;

    _timer = Timer.periodic(const Duration(milliseconds: intervalMs), (t) {
      if (!mounted) { t.cancel(); return; }
      tick++;
      setState(() {
        _progression = 1.0 - (tick / totalTicks);
      });
      if (tick >= totalTicks) {
        t.cancel();
        if (_mancheEnCours) _mauvaisChoix(tempsEcoule: true);
      }
    });
  }

  void _bonChoix() {
    if (!_mancheEnCours) return;
    _mancheEnCours = false;
    _timer?.cancel();

    final gain = widget.niveau == Niveau.facile ? 10
        : widget.niveau == Niveau.moyen ? 15 : 25;

    setState(() {
      score += gain;
      manche++;
      _feedback = '+$gain pts 🎉';
      _feedbackBon = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _demarrerManche();
    });
  }

  void _mauvaisChoix({bool tempsEcoule = false}) {
    if (!_mancheEnCours) return;
    _mancheEnCours = false;
    _timer?.cancel();

    setState(() {
      vies--;
      _feedback = tempsEcoule
          ? '⏱️ Temps ! C\'était ${joueurCible.nomComplet}'
          : '❌ C\'était ${joueurCible.nomComplet}';
      _feedbackBon = false;
    });

    if (vies <= 0) {
      Future.delayed(const Duration(milliseconds: 900), _finDeJeu);
    } else {
      Future.delayed(const Duration(milliseconds: 1400), () {
        if (mounted) _demarrerManche();
      });
    }
  }

  void _finDeJeu() {
    if (!mounted) return;
    setState(() => jeuActif = false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0D2137),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Column(
          children: [
            Icon(Icons.emoji_events_rounded, color: Color(0xFFFFD600), size: 68),
            SizedBox(height: 8),
            Text(
              'PARTIE TERMINÉE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(color: Colors.white12),
            const SizedBox(height: 8),
            _ligneScore('Score final', '$score pts', const Color(0xFF00E676)),
            _ligneScore('Manches gagnées', '$manche', Colors.white70),
            _ligneScore('Niveau', widget.niveau.name.toUpperCase(), const Color(0xFFFFD600)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Menu', style: TextStyle(color: Colors.white38)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E676),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                score = 0;
                vies = 3;
                manche = 0;
                jeuActif = true;
              });
              _demarrerManche();
            },
            child: const Text('Rejouer 🔄', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Widget _ligneScore(String label, String valeur, Color couleur) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 14)),
          Text(valeur, style: TextStyle(color: couleur, fontSize: 16, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  Color get _couleurProgression {
    if (_progression > 0.5) return const Color(0xFF00E676);
    if (_progression > 0.25) return const Color(0xFFFFD600);
    return const Color(0xFFFF5252);
  }

  Color get _couleurNiveau => widget.niveau == Niveau.facile
      ? const Color(0xFF00E676)
      : widget.niveau == Niveau.moyen
          ? const Color(0xFFFFD600)
          : const Color(0xFFFF5252);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (joueursAffiches.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A1628),
        body: Center(child: CircularProgressIndicator(color: Color(0xFF00E676))),
      );
    }

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
              // ── Header score / vies ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () { _timer?.cancel(); Navigator.pop(context); },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white12),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 15),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (i) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Icon(
                            Icons.favorite_rounded,
                            color: i < vies ? const Color(0xFFFF5252) : Colors.white12,
                            size: 22,
                          ),
                        )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00E676).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF00E676).withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        '$score pts',
                        style: const TextStyle(
                          color: Color(0xFF00E676),
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Barre de temps ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('TEMPS', style: TextStyle(color: Colors.white24, fontSize: 10, letterSpacing: 2)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _couleurNiveau.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            widget.niveau.name.toUpperCase(),
                            style: TextStyle(color: _couleurNiveau, fontSize: 10, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: _progression,
                        backgroundColor: Colors.white10,
                        valueColor: AlwaysStoppedAnimation<Color>(_couleurProgression),
                        minHeight: 7,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ── Carte cible ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Row(
                    children: [
                      // Point d'interrogation à la place de la photo
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF00E676).withValues(alpha: 0.15),
                          border: Border.all(color: const Color(0xFF00E676), width: 2),
                        ),
                        child: const Center(
                          child: Text(
                            '?',
                            style: TextStyle(
                              color: Color(0xFF00E676),
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'TROUVE CE JOUEUR',
                              style: TextStyle(color: Colors.white24, fontSize: 9, letterSpacing: 2),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              joueurCible.nomComplet,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${joueurCible.nationalite} · ${joueurCible.club}',
                              style: const TextStyle(color: Colors.white54, fontSize: 11),
                            ),
                          ],
                        ),
                      ),

                      if (_feedback.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: (_feedbackBon ? const Color(0xFF00E676) : const Color(0xFFFF5252))
                                .withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _feedbackBon ? '+pts 🎉' : '❌',
                            style: TextStyle(
                              color: _feedbackBon ? const Color(0xFF00E676) : const Color(0xFFFF5252),
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ── Grille 4×2 ──
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      const double cm = 37.8;
                      const double carteW = 5 * cm;
                      const double carteH = 3 * cm;
                      const int colonnes = 4;
                      const int rangees = 2;
                      const double espH = 8;
                      const double espV = 8;

                      final double largeurGrille = constraints.maxWidth;
                      final double carteHReelle =
                          (largeurGrille - (colonnes - 1) * espH) / colonnes / (carteW / carteH);
                      final double hauteurGrille =
                          rangees * carteHReelle + (rangees - 1) * espV;

                      return Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: largeurGrille,
                          height: hauteurGrille,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: colonnes,
                              crossAxisSpacing: espH,
                              mainAxisSpacing: espV,
                              childAspectRatio: carteW / carteH,
                            ),
                            itemCount: colonnes * rangees,
                            itemBuilder: (_, index) => _CarteJoueur(
                              joueur: joueursAffiches[index],
                              estLaBonne: index == positionBonneReponse,
                              couleur: _couleursCarte[index % _couleursCarte.length],
                              reveler: _feedback.isNotEmpty && !_feedbackBon,
                              onTap: () {
                                if (!jeuActif || !_mancheEnCours) return;
                                if (index == positionBonneReponse) {
                                  _bonChoix();
                                } else {
                                  _mauvaisChoix();
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Widget carte joueur ──
class _CarteJoueur extends StatelessWidget {
  final Joueur joueur;
  final bool estLaBonne;
  final Color couleur;
  final VoidCallback onTap;
  final bool reveler;

  const _CarteJoueur({
    required this.joueur,
    required this.estLaBonne,
    required this.couleur,
    required this.onTap,
    required this.reveler,
  });

  @override
  Widget build(BuildContext context) {
    final surligne = reveler && estLaBonne;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: surligne
              ? const Color(0xFF00E676).withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: surligne ? const Color(0xFF00E676) : couleur.withValues(alpha: 0.45),
            width: surligne ? 2.5 : 1,
          ),
          boxShadow: surligne
              ? [BoxShadow(color: const Color(0xFF00E676).withValues(alpha: 0.3), blurRadius: 14)]
              : [],
        ),
        // Photo plein cadre — pas de nom ni club
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Image.asset(
            joueur.imageAsset,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, __, ___) => Container(
              color: couleur.withValues(alpha: 0.3),
              child: const Center(
                child: Icon(Icons.person_rounded, color: Colors.white38, size: 40),
              ),
            ),
          ),
        ),
      ),
    );
  }
}