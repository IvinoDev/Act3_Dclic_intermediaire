import 'package:flutter/material.dart';
import 'interfaces/redacteur_interface.dart';

void main() {
  runApp(const MonAppli());
}

class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magazine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink, fontFamily: 'Roboto'),
      home: const PageAccueil(),
    );
  }
}

class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Magazine Infos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFE91E63),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeroImage(),
            const PartieTitre(),
            const PartieTexte(),
            const PartieIcone(),
            const PartieRubrique(),
            const SizedBox(height: 32),
            //* Bouton Liste des rédacteurs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RedacteurInterface(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.people, size: 24),
                  label: const Text(
                    'Liste des rédacteurs',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE91E63),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class HeroImage extends StatelessWidget {
  const HeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE91E63), Color(0xFFF8BBD9)],
        ),
      ),
      child: Stack(
        children: [
          // Image de fond architecturale
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/magazineInfo.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFE91E63), Color(0xFFF8BBD9)],
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.article, size: 80, color: Colors.white54),
                  ),
                );
              },
            ),
          ),
          // Overlay gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  const Color(0xFFE91E63).withOpacity(0.3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bienvenue au Magazine Infos',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C2C2C),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Votre magazine numérique, votre source d\'inspiration',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF666666),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: const Text(
        'Magazine Infos est bien plus qu\'un simple magazine d\'informations. C\'est votre passerelle vers le monde, une source inestimable de connaissances et d\'actualités soigneusement sélectionnées pour vous éclairer sur les enjeux mondiaux, la culture, la science, la, et voir même le divertissement (le jeux).',
        style: TextStyle(
          fontSize: 15,
          color: Color(0xFF4A4A4A),
          height: 1.6,
          letterSpacing: 0.2,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIconButton(Icons.phone, 'TEL'),
          _buildIconButton(Icons.mail, 'MAIL'),
          _buildIconButton(Icons.share, 'PARTAGE'),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE91E63).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFFE91E63), size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFE91E63),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildRubriqueCard(
                'assets/images/presse.jpg',
                'Actualités',
                const Color(0xFF4CAF50),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: _buildRubriqueCard(
                'assets/images/mode.jpg',
                'Lifestyle',
                const Color(0xFF2196F3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRubriqueCard(String imagePath, String title, Color accentColor) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Image de fond
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [accentColor.withOpacity(0.8), accentColor],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        title == 'Actualités' ? Icons.newspaper : Icons.style,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Overlay gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                ),
              ),
            ),
            // Titre
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
