import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'niveau.dart';
import 'apropos.dart';
import 'contact.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A1628),
              Color(0xFF0D2137),
              Color(0xFF0A2E1A),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Cercles décoratifs en arrière-plan
              Positioned(
                top: -60,
                right: -60,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF00E676).withValues(alpha: 0.05),
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                left: -80,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFD600).withValues(alpha: 0.04),
                  ),
                ),
              ),

              // Contenu principal
              Column(
                children: [
                  // ── HERO ──
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo animé
                        ScaleTransition(
                          scale: _pulseAnim,
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF00E676), Color(0xFF00897B)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF00E676).withValues(alpha: 0.4),
                                  blurRadius: 40,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.sports_soccer_rounded,
                              size: 76,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Titre
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF00E676), Color(0xFFFFD600)],
                          ).createShader(bounds),
                          child: const Text(
                            'FOOTBALL',
                            style: TextStyle(
                              fontSize: 46,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 10,
                              height: 1,
                            ),
                          ),
                        ),
                        const Text(
                          'GAME',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w200,
                            color: Colors.white60,
                            letterSpacing: 18,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00E676).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFF00E676).withValues(alpha: 0.35),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star_rounded, color: Color(0xFFFFD600), size: 14),
                              SizedBox(width: 6),
                              Text(
                                'Reconnais le joueur',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.star_rounded, color: Color(0xFFFFD600), size: 14),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── BOUTONS ──
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // JOUER
                          _BoutonPrincipal(
                            label: 'JOUER',
                            sousTitre: 'Choisir un niveau et jouer',
                            icone: Icons.play_circle_filled_rounded,
                            couleurGradient: [const Color(0xFF00E676), const Color(0xFF00897B)],
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const NiveauPage()),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // À PROPOS + CONTACT
                          Row(
                            children: [
                              Expanded(
                                child: _BoutonSecondaire(
                                  label: 'À Propos',
                                  icone: Icons.info_rounded,
                                  couleur: const Color(0xFF1E88E5),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const AProposPage()),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _BoutonSecondaire(
                                  label: 'Contact',
                                  icone: Icons.mail_rounded,
                                  couleur: const Color(0xFFFF6F00),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const ContactPage()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // QUITTER
                          _BoutonSecondaire(
                            label: 'Quitter',
                            icone: Icons.exit_to_app_rounded,
                            couleur: const Color(0xFF6A1B9A),
                            pleineLargeur: true,
                            onTap: () => _confirmerQuitter(context),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  const Text(
                    '⚽  Football Game v1.0  •  Made in Bénin 🇧🇯',
                    style: TextStyle(color: Colors.white24, fontSize: 11),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmerQuitter(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0D2137),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Quitter ?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
        content: const Text(
          'Tu veux vraiment quitter Football Quiz ?',
          style: TextStyle(color: Colors.white60),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler', style: TextStyle(color: Colors.white38)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E676),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => SystemNavigator.pop(),
            child: const Text('Quitter', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}

// ── Bouton principal gradient ──
class _BoutonPrincipal extends StatelessWidget {
  final String label;
  final String sousTitre;
  final IconData icone;
  final List<Color> couleurGradient;
  final VoidCallback onTap;

  const _BoutonPrincipal({
    required this.label,
    required this.sousTitre,
    required this.icone,
    required this.couleurGradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: couleurGradient),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: couleurGradient.first.withValues(alpha: 0.45),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icone, color: Colors.white, size: 34),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                  ),
                ),
                Text(
                  sousTitre,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}

// ── Bouton secondaire ──
class _BoutonSecondaire extends StatelessWidget {
  final String label;
  final IconData icone;
  final Color couleur;
  final VoidCallback onTap;
  final bool pleineLargeur;

  const _BoutonSecondaire({
    required this.label,
    required this.icone,
    required this.couleur,
    required this.onTap,
    this.pleineLargeur = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: pleineLargeur ? double.infinity : null,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
        decoration: BoxDecoration(
          color: couleur.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: couleur.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, color: couleur, size: 22),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}