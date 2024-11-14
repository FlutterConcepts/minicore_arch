import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/app/modules/home/data/repositories/home_repository_impl.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/models/company_model.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/repositories/home_repository.dart';
import 'package:minicore_arch_example/app/shared/errors/http_client_error.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/http_client.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/http_response.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late final HttpClient httpClient;
  late final HomeRepository repository;

  setUpAll(() {
    httpClient = HttpClientMock();
    repository = HomeRepositoryImpl(httpClient);
  });

  group('HomeRepository.getCompaniesList | ', () {
    test('Must return a list of CompanyModel when http client return response with succes', () async {
      // Arrange
      const String responseJson =
          '''[{"id":"662fd0ee639069143a8fc387","name":"Jaguar"},{"id":"662fd0fab3fd5656edb39af5","name":"Tobias"},{"id":"662fd100f990557384756e58","name":"Apex"}]''';
      when(() => httpClient.get(any()))
          .thenAnswer((_) async => HttpResponse(data: jsonDecode(responseJson), statusCode: 200));

      // Act
      final (:companiesList, :errorMessage) = await repository.getCompaniesList();

      // Assert
      expect(companiesList, isA<List<CompanyModel>>());
      expect(companiesList, hasLength(3));
      expect(companiesList, [
        isA<CompanyModel>()
            .having((company) => company.id, 'id', equals('662fd0ee639069143a8fc387'))
            .having((company) => company.name, 'name', equals('Jaguar')),
        isA<CompanyModel>()
            .having((company) => company.id, 'id', equals('662fd0fab3fd5656edb39af5'))
            .having((company) => company.name, 'name', equals('Tobias')),
        isA<CompanyModel>()
            .having((company) => company.id, 'id', equals('662fd100f990557384756e58'))
            .having((company) => company.name, 'name', equals('Apex')),
      ]);
      expect(errorMessage, isEmpty);
    });

    test('Must return an empty list of CompanyModel when http client throws an error', () async {
      // Arrange
      when(() => httpClient.get(any())).thenThrow(const HttpClientError(
          data: {'message': 'Expired token'}, message: '401 - Authentication invalid', stackTrace: null));

      // Act
      final (:companiesList, :errorMessage) = await repository.getCompaniesList();

      // Assert
      expect(companiesList, isEmpty);
      expect(
          errorMessage,
          allOf(
            equals('401 - Authentication invalid'),
            contains('401'),
            contains('Authentication invalid'),
          ));
    });
  });
}
