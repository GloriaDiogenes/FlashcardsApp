import 'package:flutter/material.dart';
import 'cadastro_screen.dart';

class EscolhaTipoScreen extends StatelessWidget {
  const EscolhaTipoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Cores personalizadas
    const Color mossGreen = Color(0xFF6D8B74);
    const Color softPink = Color(0xFFF5C3C2);
    const Color lightBackground = Color(0xFFF9F3F3);

    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        title: const Text(
          'Tipo de Usuário',
          style: TextStyle(color: Color(0xFF6D8B74)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF6D8B74)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          children: [
            // Ícone e título
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: mossGreen,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.supervised_user_circle,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Selecione seu tipo de usuário',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6D8B74),
                    ),
                  ),
                ],
              ),
            ),
            
            // Botão Profissional
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.work, size: 28),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Sou Profissional',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CadastroScreen(tipo: 'profissional'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mossGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  shadowColor: mossGreen.withOpacity(0.4),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Botão Cliente
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.person, size: 28),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Sou Cliente',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CadastroScreen(tipo: 'comum'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: mossGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: mossGreen, width: 1.5),
                  ),
                  elevation: 2,
                ),
              ),
            ),
            
            // Espaçamento antes do botão de voltar
            const SizedBox(height: 40),
            
            // Botão "Voltar ao Login"
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Volta para a tela anterior (login)
              },
              child: const Text(
                'Voltar ao Login',
                style: TextStyle(
                  fontSize: 16,
                  color: mossGreen,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}