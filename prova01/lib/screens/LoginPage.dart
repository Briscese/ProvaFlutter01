import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './AlunosPage.dart'; // Página de alunos

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> _login() async {
  final url = 'http://demo2299134.mockable.io/login';
  final response = await http.post(
    Uri.parse(url),
    body: jsonEncode({
      'username': _userController.text,
      'password': _passwordController.text,
    }),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final token = data['token'];
    final alunos = data['alunos'];

    if (token != null && alunos != null) {
      // Redireciona para a página de alunos, passando o token e a lista de alunos
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AlunosPage(token: token, alunos: alunos),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Erro: Token ou lista de alunos não encontrada!';
      });
    }
  } else {
    setState(() {
      _errorMessage = 'Erro ao fazer login: ${response.statusCode}';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
