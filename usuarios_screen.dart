import 'package:flutter/material.dart';
import 'escolha_tipo_screen.dart'; // Importe a tela de escolha de tipo
import 'cadastro_screen.dart'; // Importe a tela de cadastro

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({super.key});

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  // Cores personalizadas
  final Color mossGreen = const Color(0xFF6D8B74);
  final Color softPink = const Color(0xFFF5C3C2);
  final Color lightBackground = const Color(0xFFF9F3F3);

  // Lista de usuários e controle para busca
  final List<Map<String, String>> _todosUsuarios = [
    {
      'nome': 'João Silva', 
      'email': 'joao@email.com', 
      'tipo': 'Professor',
      'telefone': '(11) 99999-9999',
      'endereco': 'Rua A, 123'
    },
    {
      'nome': 'Maria Souza', 
      'email': 'maria@email.com', 
      'tipo': 'Aluno',
      'telefone': '(11) 88888-8888',
      'endereco': 'Av. B, 456'
    },
    {
      'nome': 'Carlos Andrade', 
      'email': 'carlos@email.com', 
      'tipo': 'Professor',
      'telefone': '(11) 77777-7777',
      'endereco': 'Rua C, 789'
    },
    {
      'nome': 'Ana Oliveira', 
      'email': 'ana@email.com', 
      'tipo': 'Aluno',
      'telefone': '(11) 66666-6666',
      'endereco': 'Av. D, 101'
    },
    {
      'nome': 'Pedro Costa', 
      'email': 'pedro@email.com', 
      'tipo': 'Aluno',
      'telefone': '(11) 55555-5555',
      'endereco': 'Rua E, 202'
    },
    {
      'nome': 'Fernanda Lima', 
      'email': 'fernanda@email.com', 
      'tipo': 'Professor',
      'telefone': '(11) 44444-4444',
      'endereco': 'Av. F, 303'
    },
    {
      'nome': 'Ricardo Santos', 
      'email': 'ricardo@email.com', 
      'tipo': 'Aluno',
      'telefone': '(11) 33333-3333',
      'endereco': 'Rua G, 404'
    },
    {
      'nome': 'Juliana Pereira', 
      'email': 'juliana@email.com', 
      'tipo': 'Professor',
      'telefone': '(11) 22222-2222',
      'endereco': 'Av. H, 505'
    },
  ];

  List<Map<String, String>> _usuariosExibidos = [];
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _itemsPerPage = 5;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _usuariosExibidos = _todosUsuarios;
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading &&
        _usuariosExibidos.length < _todosUsuarios.length) {
      _loadMoreUsers();
    }
  }

  void _loadMoreUsers() {
    setState(() {
      _isLoading = true;
    });

    // Simulando carregamento assíncrono
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _currentPage++;
        final startIndex = (_currentPage - 1) * _itemsPerPage;
        final endIndex = startIndex + _itemsPerPage;
        if (startIndex < _todosUsuarios.length) {
          _usuariosExibidos = _todosUsuarios.sublist(
              0, endIndex > _todosUsuarios.length ? _todosUsuarios.length : endIndex);
        }
        _isLoading = false;
      });
    });
  }

  void _filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        _usuariosExibidos = _todosUsuarios;
      } else {
        _usuariosExibidos = _todosUsuarios
            .where((user) =>
                user['nome']!.toLowerCase().contains(query.toLowerCase()) ||
                user['email']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      _currentPage = 1; // Reset paginação ao filtrar
    });
  }

  void _logout() {
    // Navega para a tela de escolha de tipo (como ponto inicial)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const EscolhaTipoScreen()),
      (route) => false,
    );
  }

  void _editUser(Map<String, String> user) {
    final nomeController = TextEditingController(text: user['nome']);
    final telefoneController = TextEditingController(text: user['telefone']);
    final enderecoController = TextEditingController(text: user['endereco']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Usuário'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: telefoneController,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: enderecoController,
                  decoration: const InputDecoration(labelText: 'Endereço'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  final index = _todosUsuarios.indexWhere((u) => u['email'] == user['email']);
                  if (index != -1) {
                    _todosUsuarios[index]['nome'] = nomeController.text;
                    _todosUsuarios[index]['telefone'] = telefoneController.text;
                    _todosUsuarios[index]['endereco'] = enderecoController.text;
                    _filterUsers(_searchController.text);
                  }
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Usuário ${nomeController.text} atualizado'),
                    backgroundColor: mossGreen,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        title: const Text('Usuários Cadastrados', style: TextStyle(color: Colors.white)),
        backgroundColor: mossGreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterUsers,
              decoration: InputDecoration(
                labelText: 'Buscar usuários',
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
                prefixIcon: const Icon(Icons.search, color: Color(0xFF6D8B74)),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterUsers('');
                        },
                      )
                    : null,
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _usuariosExibidos.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _usuariosExibidos.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        color: Color(0xFF6D8B74),
                      ),
                    ),
                  );
                }
                
                final user = _usuariosExibidos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: softPink.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        user['tipo'] == 'Professor' ? Icons.school : Icons.person,
                        color: mossGreen,
                      ),
                    ),
                    title: Text(
                      user['nome']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6D8B74),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user['email']!),
                        Text(user['telefone']!),
                        Text(user['endereco']!),
                        const SizedBox(height: 4),
                        Chip(
                          label: Text(
                            user['tipo']!,
                            style: const TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          backgroundColor: mossGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Color(0xFF6D8B74)),
                          onPressed: () {
                            _editUser(user);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _showDeleteDialog(user);
                          },
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

  void _showDeleteDialog(Map<String, String> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: Text('Tem certeza que deseja excluir o usuário ${user['nome']}?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Color(0xFF6D8B74))),
            ),
            TextButton(
              onPressed: () {
                // Simulação de exclusão
                setState(() {
                  _todosUsuarios.removeWhere((u) => u['email'] == user['email']);
                  _filterUsers(_searchController.text);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Usuário ${user['nome']} excluído'),
                    backgroundColor: mossGreen,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}