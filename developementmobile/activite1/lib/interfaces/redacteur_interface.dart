import 'package:flutter/material.dart';
import '../modele/redacteur.dart';
import '../database/database_manager.dart';

class RedacteurInterface extends StatefulWidget {
  const RedacteurInterface({super.key});

  @override
  State<RedacteurInterface> createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<Redacteur> _redacteurs = [];
  final DatabaseManager _dbManager = DatabaseManager.instance;

  @override
  void initState() {
    super.initState();
    _chargerRedacteurs();
  }

  Future<void> _chargerRedacteurs() async {
    final redacteurs = await _dbManager.getAllRedacteurs();
    setState(() {
      _redacteurs = redacteurs;
    });
  }

  Future<void> _ajouterRedacteur() async {
    if (_nomController.text.isEmpty ||
        _prenomController.text.isEmpty ||
        _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final redacteur = Redacteur.sansId(
      nom: _nomController.text,
      prenom: _prenomController.text,
      email: _emailController.text,
    );

    await _dbManager.insertRedacteur(redacteur);
    _nomController.clear();
    _prenomController.clear();
    _emailController.clear();

    await _chargerRedacteurs();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rédacteur ajouté avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _modifierRedacteur(Redacteur redacteur) async {
    final nomController = TextEditingController(text: redacteur.nom);
    final prenomController = TextEditingController(text: redacteur.prenom);
    final emailController = TextEditingController(text: redacteur.email);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le rédacteur'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: prenomController,
                decoration: const InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () async {
              final redacteurModifie = Redacteur(
                id: redacteur.id,
                nom: nomController.text,
                prenom: prenomController.text,
                email: emailController.text,
              );

              await _dbManager.updateRedacteur(redacteurModifie);
              await _chargerRedacteurs();

              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rédacteur modifié avec succès'),
                    backgroundColor: Colors.blue,
                  ),
                );
              }
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  Future<void> _supprimerRedacteur(int id) async {
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Voulez-vous vraiment supprimer ce rédacteur ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirme == true) {
      await _dbManager.deleteRedacteur(id);
      await _chargerRedacteurs();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rédacteur supprimé avec succès'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gestion des Rédacteurs',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFE91E63),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Compteur de rédacteurs
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFE91E63).withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.people, color: Color(0xFFE91E63)),
                const SizedBox(width: 8),
                Text(
                  'Total: ${_redacteurs.length} rédacteur(s)',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE91E63),
                  ),
                ),
              ],
            ),
          ),

          // Formulaire d'ajout
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _nomController,
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _prenomController,
                  decoration: const InputDecoration(
                    labelText: 'Prénom',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _ajouterRedacteur,
                    icon: const Icon(Icons.add),
                    label: const Text('Ajouter un rédacteur'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE91E63),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(thickness: 2),

          // Liste des rédacteurs
          Expanded(
            child: _redacteurs.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 80, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Aucun rédacteur enregistré',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _redacteurs.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final redacteur = _redacteurs[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFE91E63),
                            child: Text(
                              redacteur.prenom[0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            '${redacteur.prenom} ${redacteur.nom}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(redacteur.email),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () => _modifierRedacteur(redacteur),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () =>
                                    _supprimerRedacteur(redacteur.id!),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
