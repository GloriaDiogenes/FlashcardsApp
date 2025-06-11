import 'package:flutter/material.dart';
import 'usuarios_screen.dart';
import 'login_screen.dart';

class CadastroScreen extends StatefulWidget {
  final String tipo;
  const CadastroScreen({super.key, required this.tipo});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();
  final telefoneController = TextEditingController();
  final enderecoController = TextEditingController();

  // Cores personalizadas
  final Color mossGreen = const Color(0xFF6D8B74);
  final Color softPink = const Color(0xFFF5C3C2);
  final Color lightBackground = const Color(0xFFF9F3F3);

  void _cadastrar() {
    if (senhaController.text != confirmarSenhaController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não coincidem!')),
      );
      return;
    }

    print('Usuário cadastrado:');
    print('Nome: ${nomeController.text}');
    print('Email: ${emailController.text}');
    print('Telefone: ${telefoneController.text}');
    print('Endereço: ${enderecoController.text}');
    print('Tipo: ${widget.tipo}');

    if (widget.tipo == 'profissional') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UsuariosScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        title: Text(
          'Cadastro - ${widget.tipo == 'profissional' ? 'Profissional' : 'Comum'}',
          style: TextStyle(color: mossGreen),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: mossGreen),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Ícone e título
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: mossGreen,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        widget.tipo == 'profissional' ? Icons.work : Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Complete seu cadastro',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: mossGreen,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.tipo == 'profissional'
                          ? 'Cadastro para profissionais'
                          : 'Cadastro para usuários comuns',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Campo Nome
              _buildTextField(
                controller: nomeController,
                label: 'Nome Completo',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              // Campo Email
              _buildTextField(
                controller: emailController,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Campo Senha
              _buildTextField(
                controller: senhaController,
                label: 'Senha',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // Campo Confirmar Senha
              _buildTextField(
                controller: confirmarSenhaController,
                label: 'Confirmar Senha',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // Campo Telefone
              _buildTextField(
                controller: telefoneController,
                label: 'Telefone',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // Campo Endereço
              _buildTextField(
                controller: enderecoController,
                label: 'Endereço',
                icon: Icons.home_outlined,
              ),
              const SizedBox(height: 32),

              // Botão de Cadastro
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _cadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mossGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: mossGreen.withOpacity(0.4),
                  ),
                  child: const Text(
                    'Finalizar Cadastro',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: softPink, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: mossGreen, width: 1.5),
        ),
        prefixIcon: Icon(icon, color: mossGreen),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}