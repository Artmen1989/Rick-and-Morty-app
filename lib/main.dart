import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CharacterListPage(),
    );
  }
}

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  List<dynamic> _characters = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    try {
      final response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _characters = data['results'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  void _retry() {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _characters = [];
    });
    _loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Characters'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _retry,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Failed to load characters',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _retry,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _characters.length,
      itemBuilder: (context, index) {
        final character = _characters[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(character['image']),
            ),
            title: Text(
              character['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${character['status']} - ${character['species']}'),
            trailing: IconButton(
              icon: const Icon(Icons.star_border),
              onPressed: () {
                // Временная заглушка для избранного
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Favorite feature coming soon!')),
                );
              },
            ),
          ),
        );
      },
    );
  }
}