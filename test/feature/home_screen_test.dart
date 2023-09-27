import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockService extends Mock {
  Future<http.Response> fetchItems(Uri uri) async {
    when(http.get(uri)).thenAnswer((_) async => http.Response('{"key1": "value1"}', 200));

    return http.Response('{"key1": "value1"}', 200);
  }
}

void main() {
  group('test todo list api', () {
    test('test todo status api success', () async {
      final mockService = MockService();
      final uri = Uri.parse('https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=0&limit=20&sortBy=createdAt&isAsc=true&status=TODO');

      // Now, call the mock's 'fetchData' method.
      final response = await mockService.fetchItems(uri);

      // Perform your assertions based on the mock response
      expect(response.statusCode, 200);
      expect(response.body, '{"key1": "value1"}');
    });

    test('test doing status api success', () async {
      final mockClient = MockService();
      final uri = Uri.parse('https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=0&limit=20&sortBy=createdAt&isAsc=true&status=DOING');

      // Define the response data
      when(http.get(uri)).thenAnswer((_) async => http.Response('{"key1": "value1"}', 200));

      // Use the mock client in your code
      final response = await mockClient.fetchItems(uri);

      // Perform your assertions based on the mock response
      expect(response.statusCode, 200);
      expect(response.body, '{"key1": "value1"}');
    });

    test('test done status api success', () async {
      final mockClient = MockService();
      final uri = Uri.parse('https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=0&limit=20&sortBy=createdAt&isAsc=true&status=DONE');

      // Define the response data
      when(http.get(uri)).thenAnswer((_) async => http.Response('{"key1": "value1"}', 200));

      // Use the mock client in your code
      final response = await mockClient.fetchItems(uri);

      // Perform your assertions based on the mock response
      expect(response.statusCode, 200);
      expect(response.body, '{"key1": "value1"}');
    });
  });
}