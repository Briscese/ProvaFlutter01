import 'package:flutter/material.dart';

class AlunosPage extends StatelessWidget {
  final String token;
  final List<dynamic> alunos;

  AlunosPage({required this.token, required this.alunos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página de Alunos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Token recebido: $token'),
            SizedBox(height: 20),
            Text(
              'Lista de Alunos:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: alunos.length,
                itemBuilder: (context, index) {
                  final aluno = alunos[index];
                  final String nome = aluno['nome'];
                  final int nota = aluno['nota'];

                  // Definindo a cor do retângulo com base na nota
                  Color backgroundColor;
                  if (nota < 60) {
                    backgroundColor = Colors.yellow; // Menor que 60, amarelo
                  } else if (nota == 100) {
                    backgroundColor = Colors.green; // 100, verde
                  } else {
                    backgroundColor = Colors.blue;  // Entre 60 e 99, azul
                  }

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10), // Espaçamento entre os retângulos
                    padding: EdgeInsets.all(16), // Padding interno do conteúdo
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          nome,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Nota: $nota',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
