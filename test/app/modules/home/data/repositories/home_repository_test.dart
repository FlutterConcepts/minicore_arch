import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/app/modules/home/data/repositories/home_repository.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/models/company_model.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/repositories/i_home_repository.dart';
import 'package:minicore_arch_example/app/shared/errors/http_client_error.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/http_response.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/i_http_client.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements IHttpClient {}

void main() {
  late final IHomeRepository repository;
  late final IHttpClient httpClient;

  const String responseJson =
      '''[{"id":"662fd0ee639069143a8fc387","name":"Jaguar"},{"id":"662fd0fab3fd5656edb39af5","name":"Tobias"},{"id":"662fd100f990557384756e58","name":"Apex"}]''';

  setUpAll(() {
    httpClient = HttpClientMock();
    repository = HomeRepository(httpClient);
  });

  test('Must return a list of CompanyModel when http client return response with succes', () async {
    // mock
    when(() => httpClient.get(any()))
        .thenAnswer((_) async => HttpResponse(data: jsonDecode(responseJson), statusCode: 200));

    // act
    final (:companiesList, :errorMessage) = await repository.getCompaniesList();

    // assert
    expect(companiesList, isA<List<CompanyModel>>());
    expect(companiesList.length, equals(3));
    expect(errorMessage.isEmpty, true);
  });

  test('Must return a empty list of CompanyModel when http client throws a error', () async {
    // mock
    when(() => httpClient.get(any())).thenThrow(const HttpClientError(
        data: {'message': 'Expired token'}, message: '401 - Authentication invalid', stackTrace: null));

    // act
    final (:companiesList, :errorMessage) = await repository.getCompaniesList();

    // assert
    expect(companiesList.isEmpty, true);
    expect(errorMessage, equals('401 - Authentication invalid'));
  });
}
