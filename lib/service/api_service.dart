import 'package:dio/dio.dart';
import 'package:notetaker/model/model.dart';

class ApiSercice {
  Dio dio = Dio();
  var endpointUrl = 'https://65618241dcd355c08323e66b.mockapi.io/notes';

  Future<List<NoteModel>> getNotes() async {
    try {
      Response response = await dio.get(endpointUrl);
      if (response.statusCode == 200) {
        var jsonList = response.data as List;
        List<NoteModel> notes = jsonList.map((json) {
          return NoteModel.fromJson(json);
        }).toList();

        return notes;
      } else {
        throw Exception('Failed to load notes');
      }
    } catch (error) {
      throw Exception('Failed to load notes: $error');
    }
  }

  createNotes(NoteModel value)async{
    try {
      await dio.post(endpointUrl,data: value.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
  deleteNotes({required id})async{
    var deleteUrl = 'https://65618241dcd355c08323e66b.mockapi.io/notes/$id';
    try{
      await dio.delete(deleteUrl);
    }catch (e){
      throw Exception(e);
    }
  }
  editNotes({required NoteModel value,required id,})async{
    try{
      await dio.put('https://65618241dcd355c08323e66b.mockapi.io/notes/$id',data: value.toJson());
    }catch (e){
      throw Exception(e);
    }
  }
}
