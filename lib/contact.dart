import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nomController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _envoye = false;

  @override
  void dispose() {
    _nomController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _envoyer() {
    if (_nomController.text.trim().isEmpty ||
        _messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Remplis tous les champs obligatoires 😊'),
          backgroundColor: const Color(0xFFFF6F00),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }
    setState(() => _envoye = true);
  }

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
                          'CONTACT',
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
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: _envoye ? _pageConfirmation() : _formulaire(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formulaire() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6F00), Color(0xFFE65100)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF6F00).withValues(alpha: 0.4),
                  blurRadius: 24,
                ),
              ],
            ),
            child: const Icon(Icons.mail_rounded, size: 42, color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Nous Contacter',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(height: 4),
        const Center(
          child: Text(
            'Une idée ? Un bug ? Un joueur manquant ?',
            style: TextStyle(color: Colors.white38, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),

        // Infos
        _infoLigne(Icons.email_rounded, 'ricardokpanou8@gmail.com', const Color(0xFFFF6F00)),
        const SizedBox(height: 8),
        _infoLigne(Icons.language_rounded, 'www.footballquiz.app', const Color(0xFF1E88E5)),
        const SizedBox(height: 8),
        _infoLigne(Icons.location_on_rounded, 'Porto-Novo, Bénin 🇧🇯', const Color(0xFF00E676)),
        const SizedBox(height: 28),

        // Formulaire
        _label('Prénom *'),
        const SizedBox(height: 6),
        _champ(_nomController, 'Ton prénom', Icons.person_rounded),
        const SizedBox(height: 14),
        _label('Email (facultatif)'),
        const SizedBox(height: 6),
        _champ(_emailController, 'ton@email.com', Icons.alternate_email_rounded,
            type: TextInputType.emailAddress),
        const SizedBox(height: 14),
        _label('Message *'),
        const SizedBox(height: 6),
        _champMultiligne(_messageController, 'Écris ton message ici...'),
        const SizedBox(height: 24),

        // Bouton envoyer
        GestureDetector(
          onTap: _envoyer,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6F00), Color(0xFFE65100)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF6F00).withValues(alpha: 0.4),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.send_rounded, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text(
                  'Envoyer le message',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _label(String texte) {
    return Text(
      texte,
      style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.w600),
    );
  }

  Widget _infoLigne(IconData icone, String texte, Color couleur) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: couleur.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icone, color: couleur, size: 16),
        ),
        const SizedBox(width: 10),
        Text(texte, style: const TextStyle(color: Colors.white60, fontSize: 13)),
      ],
    );
  }

  Widget _champ(
    TextEditingController ctrl,
    String hint,
    IconData icone, {
    TextInputType type = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: TextField(
        controller: ctrl,
        keyboardType: type,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white24),
          prefixIcon: Icon(icone, color: Colors.white24, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _champMultiligne(TextEditingController ctrl, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: TextField(
        controller: ctrl,
        maxLines: 5,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white24),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _pageConfirmation() {
    return Column(
      children: [
        const SizedBox(height: 60),
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF00E676), Color(0xFF00897B)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00E676).withValues(alpha: 0.4),
                blurRadius: 32,
                spreadRadius: 4,
              ),
            ],
          ),
          child: const Icon(Icons.check_rounded, size: 60, color: Colors.white),
        ),
        const SizedBox(height: 26),
        const Text(
          'Message envoyé !',
          style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10),
        Text(
          'Merci ${_nomController.text.trim()} 🙏\nNous te répondrons très rapidement !',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white54, fontSize: 15, height: 1.7),
        ),
        const SizedBox(height: 40),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 15),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00E676), Color(0xFF00897B)],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00E676).withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Text(
              "Retour à l'accueil",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
