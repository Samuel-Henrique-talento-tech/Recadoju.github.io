import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Planeta {
  String nome;
  String descricao;

  Planeta({required this.nome, required this.descricao});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Planetas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Planeta> _planetas = [
    Planeta(nome: 'Terra', descricao: 'Planeta onde vivemos'),
    Planeta(nome: 'Marte', descricao: 'Planeta vermelho'),
    Planeta(nome: 'Júpiter', descricao: 'Planeta gasoso'),
  ];

  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();

  void _adicionarPlaneta() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _planetas.add(Planeta(
          nome: _nomeController.text,
          descricao: _descricaoController.text,
        ));
        _nomeController.clear();
        _descricaoController.clear();
      });
    }
  }

  void _excluirPlaneta(int index) {
    setState(() {
      _planetas.removeAt(index);
    });
  }

  void _editarPlaneta(int index) {
    _nomeController.text = _planetas[index].nome;
    _descricaoController.text = _planetas[index].descricao;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Planeta'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do planeta';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição do planeta';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _planetas[index] = Planeta(
                    nome: _nomeController.text,
                    descricao: _descricaoController.text,
                  );
                  _nomeController.clear();
                  _descricaoController.clear();
                });
                Navigator.of(context).pop();
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Planetas'),
      ),
      body: ListView.builder(
        itemCount: _planetas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_planetas[index].nome),
            subtitle: Text(_planetas[index].descricao),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editarPlaneta(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _excluirPlaneta(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Adicionar Planeta'),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
