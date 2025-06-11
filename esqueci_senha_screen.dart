import 'package:flutter/material.dart';

class EsqueciSenhaScreen extends StatelessWidget {
  const EsqueciSenhaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    
    // Cores consistentes com o tema
    const Color mossGreen = Color(0xFF6D8B74);
    const Color lightBackground = Color(0xFFF9F3F3);

    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF6D8B74)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const Icon(
              Icons.lock_reset,
              size: 80,
              color: Color(0xFF6D8B74),
            ),
            const SizedBox(height: 24),
            const Text(
              'Digite seu email para receber o link de recuperação',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFF5C3C2), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF6D8B74), width: 1.5),
                ),
                prefixIcon: const Icon(Icons.email, color: Color(0xFF6D8B74)),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Lógica para enviar email de recuperação
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Link de recuperação enviado para seu email'),
                  ),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6D8B74),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Enviar Link',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}