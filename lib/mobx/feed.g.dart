// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Feed on _Feed, Store {
  final _$oCurrentUserAtom = Atom(name: '_Feed.oCurrentUser');

  @override
  Observable<User> get oCurrentUser {
    _$oCurrentUserAtom.reportRead();
    return super.oCurrentUser;
  }

  @override
  set oCurrentUser(Observable<User> value) {
    _$oCurrentUserAtom.reportWrite(value, super.oCurrentUser, () {
      super.oCurrentUser = value;
    });
  }

  final _$oPostsAtom = Atom(name: '_Feed.oPosts');

  @override
  List<Post> get oPosts {
    _$oPostsAtom.reportRead();
    return super.oPosts;
  }

  @override
  set oPosts(List<Post> value) {
    _$oPostsAtom.reportWrite(value, super.oPosts, () {
      super.oPosts = value;
    });
  }

  final _$_FeedActionController = ActionController(name: '_Feed');

  @override
  void setPost(Post post, {bool last = false}) {
    final _$actionInfo =
        _$_FeedActionController.startAction(name: '_Feed.setPost');
    try {
      return super.setPost(post, last: last);
    } finally {
      _$_FeedActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
oCurrentUser: ${oCurrentUser},
oPosts: ${oPosts}
    ''';
  }
}
