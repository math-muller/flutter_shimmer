
import 'package:dio/dio.dart';
import 'package:exemplo_shimmer/models/curso_model.dart';

import 'service_config.dart';


class CursoService {
  static final String _endpoint =
      "https://5cb544bd07f233001424ceb8.mockapi.io/fiap";

  static final String _resource = 'curso';

  final ServiceConfig service = new ServiceConfig(_endpoint);

  Future<List<CursoModel>> findAll() async {
    await Future.delayed(Duration(seconds: 10));

    List<CursoModel> lista = new List<CursoModel>();

    try {
      Response response = await service.create().get(_resource);
      if (response.statusCode == 200) {
        response.data.forEach(
          (value) {
            print(value);
            lista.add(
              CursoModel.fromMap(value),
            );
          },
        );
      }
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }

    return lista;
  }

  Future<int> create(CursoModel cursoModel) async {
    try {
      cursoModel.id = 0;
      Response response = await service.create().post(
            _resource,
            data: cursoModel.toMap(),
          );

      if (response.statusCode == 201) {
        var retorno = (response.data["id"] is String)
            ? int.parse(response.data["id"])
            : response.data["id"];
        return retorno;
      }
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }
    return null;
  }

  Future<CursoModel> getById(int id) async {
    try {
      String endpoint = _resource + "/" + id.toString();
      Response response = await service.create().get(endpoint);

      if (response.statusCode == 200) {
        var retorno = CursoModel.fromMap(response.data);
        return retorno;
      }
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }
    return null;
  }

  Future<int> update(CursoModel cursoModel) async {
    try {
      String endpoint = _resource + "/" + cursoModel.id.toString();

      Response response = await service.create().put(
            endpoint,
            data: cursoModel.toMap(),
          );

      var retorno = (response.data["id"] is String)
          ? int.parse(response.data["id"])
          : response.data["id"];
      return retorno;
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }
  }

  Future<void> delete(CursoModel cursoModel) async {
    try {
      String endpoint = _resource + "/" + cursoModel.id.toString();

      Response response = await service.create().delete(
            endpoint,
          );

      if (response.statusCode != 200) {
        throw Exception("Não foi possível excluir o recurso!");
      }
    } catch (error) {
      throw error;
    }
  }
}
