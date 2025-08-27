import 'package:catarog_app_flutter/core/network/api_client.dart';
import 'package:catarog_app_flutter/core/network/repository/post_repository.dart';
import 'package:catarog_app_flutter/core/network/response/post_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MockApiClient mockApi;

  setUp(() {
    mockApi = MockApiClient();
  });

  test('getPost success', () async {
    final List<PostResponse> dummyPosts = <PostResponse>[
      const PostResponse(userId: 1, id: 1, title: 'title1', body: 'body1'),
      const PostResponse(userId: 2, id: 2, title: 'title2', body: 'body2'),
    ];

    when(() => mockApi.getPosts()).thenAnswer((_) async => dummyPosts);

    final ProviderContainer container = ProviderContainer(overrides: <Override>[
      apiClientProvider.overrideWithValue(mockApi),
    ]);
    addTearDown(container.dispose);

    final PostRepository postRepository =
        container.read(postRepositoryProvider);

    final List<PostResponse> result = await postRepository.getPosts();
    expect(result, dummyPosts);
    verify(() => mockApi.getPosts()).called(1);
    verifyNoMoreInteractions(mockApi);
  });

  test('getPost failed', () async {
    when(() => mockApi.getPosts()).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/posts'),
        type: DioExceptionType.badResponse,
      ),
    );

    final ProviderContainer container = ProviderContainer(overrides: <Override>[
      apiClientProvider.overrideWithValue(mockApi),
    ]);
    addTearDown(container.dispose);

    final PostRepository postRepository =
        container.read(postRepositoryProvider);

    await expectLater(
      () => postRepository.getPosts(),
      throwsA(
        isA<DioException>(),
      ),
    );
    verify(() => mockApi.getPosts()).called(1);
    verifyNoMoreInteractions(mockApi);
  });
}
