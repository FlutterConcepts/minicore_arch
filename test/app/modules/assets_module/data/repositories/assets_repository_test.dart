import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/app/modules/assets_module/data/repositories/assets_repository.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/models/assets_model.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/models/location_model.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/repositories/i_assets_repository.dart';
import 'package:minicore_arch_example/app/shared/errors/http_client_error.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/http_response.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/i_http_client.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements IHttpClient {}

void main() {
  late final IAssetsRepository repository;
  late final IHttpClient httpClient;

  setUpAll(() {
    httpClient = HttpClientMock();
    repository = AssetsRepository(httpClient);
  });

  group('Get assets list', () {
    const String responseAssetsJson =
        '''[{"gatewayId":"TLQ367","id":"60fc4e837dfb4f001fad3f30","locationId":"60fc4e7007a5ec001e81aca9","name":"Sensor 203 - vibration","parentId":null,"sensorId":"CFP481","sensorType":"vibration","status":"alert"},{"gatewayId":"VEQ023","id":"60fc4e83513295001f4dd7b7","locationId":"60fc4e7007a5ec001e81aca9","name":"Sensor 204 - vibration","parentId":null,"sensorId":"CXW988","sensorType":"vibration","status":"alert"}]''';

    test(
        'Must return a list of AssetsModel when http client return response with success',
        () async {
      // mock
      when(() => httpClient.get(any())).thenAnswer((_) async =>
          HttpResponse(data: jsonDecode(responseAssetsJson), statusCode: 200));

      // act
      final (:assetsList, :errorMessage) =
          await repository.getAssetsList('companyId');

      // assert
      expect(assetsList, isA<List<AssetsModel>>());
      expect(assetsList.length, equals(2));
      expect(errorMessage.isEmpty, true);
    });

    test(
        'Must return a empty list of AssetsModel when http client throws a error',
        () async {
      // mock
      when(() => httpClient.get(any())).thenThrow(const HttpClientError(
          data: {'message': 'Expired token'},
          message: '401 - Authentication invalid',
          stackTrace: null));

      // act
      final (:assetsList, :errorMessage) =
          await repository.getAssetsList('companyId');

      // assert
      expect(assetsList.isEmpty, true);
      expect(errorMessage, equals('401 - Authentication invalid'));
    });
  });

  group('Get location list', () {
    const String responseLocationJson =
        '''[{"id":"60fc4c8707a5ec001e8cc82f","name":"Location 3791","parentId":"60fc4c87513295001f4dd53b"},{"id":"60fc620486cd05001d229cf8","name":"Location 3792","parentId":"60fc61767dfb4f001fad58e9"}]''';

    test(
        'Must return a list of LocationModel when http client return response with success',
        () async {
      // mock
      when(() => httpClient.get(any())).thenAnswer((_) async => HttpResponse(
          data: jsonDecode(responseLocationJson), statusCode: 200));

      // act
      final (:locationList, :errorMessage) =
          await repository.getLocationList('companyId');

      // assert
      expect(locationList, isA<List<LocationModel>>());
      expect(locationList.length, equals(2));
      expect(errorMessage.isEmpty, true);
    });

    test(
        'Must return a empty list of LocationModel when http client throws a error',
        () async {
      // mock
      when(() => httpClient.get(any())).thenThrow(const HttpClientError(
          data: {'message': 'Expired token'},
          message: '401 - Authentication invalid',
          stackTrace: null));

      // act
      final (:locationList, :errorMessage) =
          await repository.getLocationList('companyId');

      // assert
      expect(locationList.isEmpty, true);
      expect(errorMessage, equals('401 - Authentication invalid'));
    });
  });
}
