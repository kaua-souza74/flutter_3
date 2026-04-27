import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora SENAI',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String display = '0';
  double? primeiroNumero;
  String? operacao;
  bool deveLimparDisplay = false;

  void adicionarNumero(String n) {
    setState(() {
      if (display == '0' || deveLimparDisplay) {
        display = n;
        deveLimparDisplay = false;
      } else {
        display = display + n;
      }
    });
  }

  void escolherOperacao(String op) {
    setState(() {
      primeiroNumero = double.tryParse(display);
      operacao = op;
      deveLimparDisplay = true;
    });
  }

  void calcular() {
    if (primeiroNumero == null || operacao == null) return;

    double segundoNumero = double.tryParse(display) ?? 0;
    double resultado = 0;

    setState(() {
      if (operacao == '+') resultado = primeiroNumero! + segundoNumero;
      if (operacao == '-') resultado = primeiroNumero! - segundoNumero;
      if (operacao == '*') resultado = primeiroNumero! * segundoNumero;
      if (operacao == '/') {
        if (segundoNumero != 0) {
          resultado = primeiroNumero! / segundoNumero;
        } else {
          display = 'Erro';
          return;
        }
      }

      // Formatação simples para o resultado
      if (resultado % 1 == 0) {
        display = resultado.toInt().toString();
      } else {
        display = resultado.toStringAsFixed(2);
      }
      
      primeiroNumero = null;
      operacao = null;
    });
  }

  void limpar() {
    setState(() {
      display = '0';
      primeiroNumero = null;
      operacao = null;
      deveLimparDisplay = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora SENAI'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            display,
            style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Linha de Operações
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () => escolherOperacao('+'), child: const Text('+')),
              const SizedBox(width: 5),
              ElevatedButton(onPressed: () => escolherOperacao('-'), child: const Text('-')),
              const SizedBox(width: 5),
              ElevatedButton(onPressed: () => escolherOperacao('*'), child: const Text('*')),
              const SizedBox(width: 5),
              ElevatedButton(onPressed: () => escolherOperacao('/'), child: const Text('/')),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Números
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () => adicionarNumero('1'), child: const Text('1')),
              const SizedBox(width: 5),
              ElevatedButton(onPressed: () => adicionarNumero('2'), child: const Text('2')),
              const SizedBox(width: 5),
              ElevatedButton(onPressed: () => adicionarNumero('3'), child: const Text('3')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () => adicionarNumero('4'), child: const Text('4')),
              const SizedBox(width: 5),
              ElevatedButton(onPressed: () => adicionarNumero('5'), child: const Text('5')),
              const SizedBox(width: 5),
              ElevatedButton(onPressed: () => adicionarNumero('6'), child: const Text('6')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () => adicionarNumero('7'), child: const Text('7')),
              const SizedBox(width: 5),
              ElevatedButton(onPressed: () => adicionarNumero('8'), child: const Text('8')),
              const SizedBox(width: 5),
              ElevatedButton(onPressed: () => adicionarNumero('9'), child: const Text('9')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: limpar, child: const Text('C')),
              const SizedBox(width: 5),
              ElevatedButton(onPressed: () => adicionarNumero('0'), child: const Text('0')),
              const SizedBox(width: 5),
              ElevatedButton(onPressed: calcular, child: const Text('=')),
            ],
          ),
        ],
      ),
    );
  }
}
