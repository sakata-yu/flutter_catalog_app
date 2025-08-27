import 'package:catarog_app_flutter/core/network/response/comment_response.dart';
import 'package:catarog_app_flutter/features/catalog001/data/count_state.dart';
import 'package:catarog_app_flutter/features/catalog001/view_model/count_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:mocktail/mocktail.dart';

import 'package:catarog_app_flutter/core/network/repository/post_repository.dart';
import 'package:catarog_app_flutter/features/catalog003/view_model/sns_view_model.dart';
import 'package:catarog_app_flutter/features/catalog003/data/sns_state.dart';
import 'package:catarog_app_flutter/core/network/response/post_response.dart';
import 'package:riverpod_test/riverpod_test.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  final MockPostRepository mockPostRepository = MockPostRepository();

  final List<PostResponse> dummyPosts = <PostResponse>[
    const PostResponse(userId: 1, id: 1, title: 'title1', body: 'body1'),
    const PostResponse(userId: 2, id: 2, title: 'title2', body: 'body2'),
  ];
  final List<PostResponse> refreshedDummyPosts = <PostResponse>[
    const PostResponse(userId: 1, id: 1, title: 'title1', body: 'body1'),
    const PostResponse(userId: 2, id: 2, title: 'title2', body: 'body2'),
    const PostResponse(userId: 3, id: 3, title: 'title3', body: 'body3'),
  ];
  final List<CommentResponse> dummyComments = <CommentResponse>[
    const CommentResponse(
        postId: 10, id: 1, name: 'name', email: 'email', body: 'body'),
  ];

  setUp(() {
    reset(mockPostRepository);
  });

  /// countViewModelProvider のテスト
  /// 初期値が0なことを確認
  testProvider(
    'check init value',
    provider: countViewModelProvider,
    expect: () => <CountState>[
      const CountState(count: 0),
    ],
  );

  /// countViewModelProvider のテスト
  /// incrementを2回呼んで2になることを確認
  testStateNotifier(
    'increment',
    provider: countViewModelProvider,
    act: (CountViewModel notifier) {
      notifier.increment();
      notifier.increment();
    },
    expect: () => <CountState>[
      const CountState(count: 1),
      const CountState(count: 2),
    ],
  );

  /// countViewModelProvider のテスト
  /// decrementを2回呼んで-2になることを確認
  testStateNotifier(
    'decrement',
    provider: countViewModelProvider,
    act: (CountViewModel notifier) {
      notifier.decrement();
      notifier.decrement();
    },
    expect: () => <CountState>[
      const CountState(count: -1),
      const CountState(count: -2),
    ],
  );

  /// snsViewModelProvider のテスト
  /// 初回ロードでrequestPostAPIが呼ばれることを確認
  test('SnsViewModel only first build', () async {
    when(() => mockPostRepository.getPosts())
        .thenAnswer((_) async => dummyPosts);

    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        postRepositoryProvider.overrideWithValue(mockPostRepository)
      ],
    );
    addTearDown(container.dispose);

    final List<AsyncValue<SnsState>> events = <AsyncValue<SnsState>>[];

    final ProviderSubscription<AsyncValue<SnsState>> subscribe =
        container.listen(
      snsViewModelProvider,
      (_, AsyncValue<SnsState> next) => events.add(next),
      fireImmediately: true,
    );

    await container.read(snsViewModelProvider.future);

    subscribe.close();

    expect(events.first, isA<AsyncLoading<SnsState>>());
    expect(
      events.last,
      isA<AsyncData<SnsState>>().having(
        (AsyncData<SnsState> data) => data.value.posts,
        'posts',
        equals(dummyPosts),
      ),
    );

    verify(() => mockPostRepository.getPosts()).called(1);
    verifyNoMoreInteractions(mockPostRepository);
  });

  /// snsViewModelProvider のテスト
  /// 初回ロードでrequestPostAPIが呼ばれることを確認し、発生したエラーをAsyncErrorで取れることを確認
  test('SnsViewModel only first build with error', () async {
    when(() => mockPostRepository.getPosts())
        .thenThrow(Exception('Internal Server Error'));

    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        postRepositoryProvider.overrideWithValue(mockPostRepository)
      ],
    );
    addTearDown(container.dispose);

    final List<AsyncValue<SnsState>> events = <AsyncValue<SnsState>>[
      container.read(snsViewModelProvider),
    ];
    final ProviderSubscription<AsyncValue<SnsState>> subscribe =
        container.listen(
      snsViewModelProvider,
      (_, AsyncValue<SnsState> next) => events.add(next),
    );

    await expectLater(
      container.read(snsViewModelProvider.future),
      throwsA(isA<Exception>()),
    );

    subscribe.close();

    expect(events.first, isA<AsyncLoading<SnsState>>());
    expect(
      events.last,
      isA<AsyncError<SnsState>>().having(
          (AsyncError<SnsState> e) => e.error, 'error', isA<Exception>()),
    );

    verify(() => mockPostRepository.getPosts()).called(1);
    verifyNoMoreInteractions(mockPostRepository);
  });

  /// snsViewModelProvider のテスト
  /// refreshを呼んで投稿一覧が更新されることを確認
  test('SnsViewModel call refresh', () async {
    when(() => mockPostRepository.getPosts())
        .thenAnswer((_) async => dummyPosts);

    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        postRepositoryProvider.overrideWithValue(mockPostRepository)
      ],
    );
    addTearDown(container.dispose);

    final List<AsyncValue<SnsState>> events = <AsyncValue<SnsState>>[];

    final ProviderSubscription<AsyncValue<SnsState>> subscribe =
        container.listen(
      snsViewModelProvider,
      (_, AsyncValue<SnsState> next) => events.add(next),
      fireImmediately: true,
    );

    await container.read(snsViewModelProvider.future);
    when(() => mockPostRepository.getPosts())
        .thenAnswer((_) async => refreshedDummyPosts);
    await container.read(snsViewModelProvider.notifier).refresh();

    subscribe.close();

    expect(events.first, isA<AsyncLoading<SnsState>>());
    expect(
      events.last,
      isA<AsyncData<SnsState>>().having(
        (AsyncData<SnsState> data) => data.value.posts,
        'posts',
        equals(refreshedDummyPosts),
      ),
    );

    verify(() => mockPostRepository.getPosts()).called(2);
    verifyNoMoreInteractions(mockPostRepository);
  });

  /// snsViewModelProvider のテスト
  /// selectPostを呼んだときに対象の投稿のコメント一覧が取れ、selectedPostIndexが1になることを確認
  test('SnsViewModel call selectPost', () async {
    when(() => mockPostRepository.getPosts())
        .thenAnswer((_) async => dummyPosts);

    when(() => mockPostRepository.getComments(1))
        .thenAnswer((_) async => dummyComments);

    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        postRepositoryProvider.overrideWithValue(mockPostRepository)
      ],
    );
    addTearDown(container.dispose);

    final List<AsyncValue<SnsState>> events = <AsyncValue<SnsState>>[];
    final ProviderSubscription<AsyncValue<SnsState>> subscribe =
        container.listen(
      snsViewModelProvider,
      (_, AsyncValue<SnsState> next) => events.add(next),
      fireImmediately: true,
    );

    await container.read(snsViewModelProvider.future);
    await container.read(snsViewModelProvider.notifier).selectPost(0);

    subscribe.close();

    expect(events.first, isA<AsyncLoading<SnsState>>());
    expect(
      events.last,
      isA<AsyncData<SnsState>>()
          .having(
            (AsyncData<SnsState> data) => data.value.commentsByPost[1]?.length,
            'commentsByPost[1].length',
            dummyComments.length,
          )
          .having(
            (AsyncData<SnsState> data) => data.value.selectedPostIndex,
            'selectedPostIndex',
            0,
          ),
    );

    // API 呼び出し検証
    verify(() => mockPostRepository.getPosts()).called(1);
    verify(() => mockPostRepository.getComments(1)).called(1);
    verifyNoMoreInteractions(mockPostRepository);
  });

  /// snsViewModelProvider のテスト
  /// selectPostを2回呼んだときにselectedPostIndexが-1(未設定)になることを確認
  test('SnsViewModel call selectPost twice', () async {
    when(() => mockPostRepository.getPosts())
        .thenAnswer((_) async => dummyPosts);

    when(() => mockPostRepository.getComments(1))
        .thenAnswer((_) async => dummyComments);

    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        postRepositoryProvider.overrideWithValue(mockPostRepository)
      ],
    );
    addTearDown(container.dispose);

    final List<AsyncValue<SnsState>> events = <AsyncValue<SnsState>>[];
    final ProviderSubscription<AsyncValue<SnsState>> subscribe =
        container.listen(
      snsViewModelProvider,
      (_, AsyncValue<SnsState> next) => events.add(next),
      fireImmediately: true,
    );

    await container.read(snsViewModelProvider.future);
    await container.read(snsViewModelProvider.notifier).selectPost(0);
    await container.read(snsViewModelProvider.notifier).selectPost(0);

    subscribe.close();

    expect(events.first, isA<AsyncLoading<SnsState>>());
    expect(
      events.last,
      isA<AsyncData<SnsState>>()
          .having(
            (AsyncData<SnsState> data) => data.value.commentsByPost[1]?.length,
            'commentsByPost[1].length',
            dummyComments.length,
          )
          .having(
            (AsyncData<SnsState> data) => data.value.selectedPostIndex,
            'selectedPostIndex',
            -1,
          ),
    );

    // API 呼び出し検証
    verify(() => mockPostRepository.getPosts()).called(1);
    verify(() => mockPostRepository.getComments(1)).called(1);
    verifyNoMoreInteractions(mockPostRepository);
  });

  /// snsViewModelProvider のテスト
  /// selectPostを3回呼んだときにselectedPostIndexが1になり、そのときAPIが呼ばれないことを確認
  test('SnsViewModel call selectPost twice', () async {
    when(() => mockPostRepository.getPosts())
        .thenAnswer((_) async => dummyPosts);

    when(() => mockPostRepository.getComments(1))
        .thenAnswer((_) async => dummyComments);

    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        postRepositoryProvider.overrideWithValue(mockPostRepository)
      ],
    );
    addTearDown(container.dispose);

    final List<AsyncValue<SnsState>> events = <AsyncValue<SnsState>>[];
    final ProviderSubscription<AsyncValue<SnsState>> subscribe =
        container.listen(
      snsViewModelProvider,
      (_, AsyncValue<SnsState> next) => events.add(next),
      fireImmediately: true,
    );

    await container.read(snsViewModelProvider.future);
    await container.read(snsViewModelProvider.notifier).selectPost(0);
    await container.read(snsViewModelProvider.notifier).selectPost(0);
    await container.read(snsViewModelProvider.notifier).selectPost(0);

    subscribe.close();

    expect(events.first, isA<AsyncLoading<SnsState>>());
    expect(
      events.last,
      isA<AsyncData<SnsState>>()
          .having(
            (AsyncData<SnsState> data) => data.value.commentsByPost[1]?.length,
            'commentsByPost[1].length',
            dummyComments.length,
          )
          .having(
            (AsyncData<SnsState> data) => data.value.selectedPostIndex,
            'selectedPostIndex',
            0,
          ),
    );

    // API 呼び出し検証
    verify(() => mockPostRepository.getPosts()).called(1);
    verify(() => mockPostRepository.getComments(1)).called(1);
    verifyNoMoreInteractions(mockPostRepository);
  });
}
