import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('test todo list api', () {
    test('test todo status api success', () async {
      final mockClient = MockClient();

      // Define the response data
      when(mockClient.get(Uri.parse('https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=0&limit=20&sortBy=createdAt&isAsc=true&status=TODO')))
          .thenAnswer((_) async => http.Response('{"key1": "value1"}', 200));

      // Use the mock client in your code
      final response = await mockClient.get(Uri.parse('https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=0&limit=20&sortBy=createdAt&isAsc=true&status=TODO'));

      // Perform your assertions based on the mock response
      expect(response.statusCode, 200);
      expect(response.body, '{"key1": "value1"}');
    });

    test('test doing status api success', () async {
      final mockClient = MockClient();

      // Define the response data
      when(mockClient.get(Uri.parse('https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=0&limit=20&sortBy=createdAt&isAsc=true&status=DOING')))
          .thenAnswer((_) async => http.Response('{"key1": "value1"}', 200));

      // Use the mock client in your code
      final response = await mockClient.get(Uri.parse('https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=0&limit=20&sortBy=createdAt&isAsc=true&status=DOING'));

      // Perform your assertions based on the mock response
      expect(response.statusCode, 200);
      expect(response.body, '{"key1": "value1"}');
    });

    test('test done status api success', () async {
      final mockClient = MockClient();

      // Define the response data
      when(mockClient.get(Uri.parse('https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=0&limit=20&sortBy=createdAt&isAsc=true&status=DONE')))
          .thenAnswer((_) async => http.Response('{"key1": "value1"}', 200));

      // Use the mock client in your code
      final response = await mockClient.get(Uri.parse('https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=0&limit=20&sortBy=createdAt&isAsc=true&status=DONE'));

      // Perform your assertions based on the mock response
      expect(response.statusCode, 200);
      expect(response.body, '{"key1": "value1"}');
    });
  });
}