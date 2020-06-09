import 'package:http/http.dart' as http ;
import 'dart:convert';

class Quote{
  var _id;
  var _tags;
  var _content;
  var _author;

  Future fetchQuote() async{
    var raw =  await http.get('https://api.quotable.io/random');
    var jsonObj = json.decode(raw.body);
    _id = jsonObj['_id'];
    _tags= jsonObj['tags'];
    _content = jsonObj['content'];
    _author = jsonObj['author'];
  }

  Map <String, dynamic> toJson() =>
      {
        'id': _id,
        'tags': _tags,
        'content': _content,
        'author': _author
      };

  Quote fromJson(Map json){
    _id = json['id'];
    _tags = json['tags'];
    _content = json['content'];
    _author = json['author'];
  }

  String getId(){ return _id; }

  String getTags() { return _tags;}

  String getContent() { return _content;}

  String getAuthor() { return _author;}

}

