import 'dart:convert';
import 'package:movies_app/domain/models/customException/database_exception.dart';
import 'package:movies_app/domain/models/dtos/result_dto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    try {
      _database = await _initDatabase();
    } on Exception catch (e) {
      throw DatabaseCustomException(e.toString());
    }
    return _database!;
  }

  // Convert List<int> to String (JSON format)
  String listToString(List<int> list) {
    return jsonEncode(list);
  }

// Convert String back to List<int>
  List<int> stringToList(String data) {
    return List<int>.from(jsonDecode(data));
  }

  Future<Database> _initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'movies_app.db');
      return openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute('''
          CREATE TABLE watchList (
            id INTEGER PRIMARY KEY,
            title TEXT,
            release_date TEXT,
            backdrop_path TEXT,
            genre_ids TEXT,
            overview TEXT,
            posterPath TEXT,
            vote_average REAL
          )
        ''');
        },
      );
    } catch (e) {
      throw DatabaseCustomException(e.toString());
    }
  }

  Future<void> insertMovie(MovieResultDto movie) async {
    try {
      final db = await database;
      await db.insert('watchList', {
        'id': movie.id,
        'backdrop_path': movie.backdropPath,
        'release_date': movie.releaseDate,
        'title': movie.title,
        'overview': movie.overview,
        'vote_average': movie.voteAverage,
        'posterPath': movie.posterPath,
        'genre_ids':
            listToString(movie.genreIds!), // Convert List<int> to String
      });
    } catch (e) {
      throw DatabaseCustomException(e.toString());
    }
  }

  Future<void> deleteMovie(int id) async {
    try {
      final db = await database;
      await db.delete(
        'watchList',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw DatabaseCustomException(e.toString());
    }
  }

  Future<List<MovieResultDto>> getMovies() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> moviesMap = await db.query('watchList');
      print(moviesMap.length);

      return moviesMap.map((movie) {
        return MovieResultDto(
            id: movie['id'] as int,
            title: movie['title'] as String,
            backdropPath: movie['backdrop_path'] as String,
            releaseDate: movie['release_date'] as String,
            voteAverage: (movie['vote_average'] as num).toDouble(),
            overview: movie['overview'] as String,
            posterPath: movie['posterPath'] as String,
            genreIds:
                stringToList(movie['genre_ids'] as String) // String to list

            );
      }).toList();
    } catch (e) {
      throw DatabaseCustomException(e.toString());
    }
  }
}
