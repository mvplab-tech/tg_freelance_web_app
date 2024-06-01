// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProjectState {
  Status get status => throw _privateConstructorUsedError;
  List<ProjectEntity> get available => throw _privateConstructorUsedError;
  List<ProjectEntity> get userResponses => throw _privateConstructorUsedError;
  List<ProjectEntity> get usersProjects => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Status status,
            List<ProjectEntity> available,
            List<ProjectEntity> userResponses,
            List<ProjectEntity> usersProjects)
        mainState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            Status status,
            List<ProjectEntity> available,
            List<ProjectEntity> userResponses,
            List<ProjectEntity> usersProjects)?
        mainState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Status status,
            List<ProjectEntity> available,
            List<ProjectEntity> userResponses,
            List<ProjectEntity> usersProjects)?
        mainState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectMainState value) mainState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectMainState value)? mainState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectMainState value)? mainState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectStateCopyWith<ProjectState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectStateCopyWith<$Res> {
  factory $ProjectStateCopyWith(
          ProjectState value, $Res Function(ProjectState) then) =
      _$ProjectStateCopyWithImpl<$Res, ProjectState>;
  @useResult
  $Res call(
      {Status status,
      List<ProjectEntity> available,
      List<ProjectEntity> userResponses,
      List<ProjectEntity> usersProjects});
}

/// @nodoc
class _$ProjectStateCopyWithImpl<$Res, $Val extends ProjectState>
    implements $ProjectStateCopyWith<$Res> {
  _$ProjectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? available = null,
    Object? userResponses = null,
    Object? usersProjects = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as List<ProjectEntity>,
      userResponses: null == userResponses
          ? _value.userResponses
          : userResponses // ignore: cast_nullable_to_non_nullable
              as List<ProjectEntity>,
      usersProjects: null == usersProjects
          ? _value.usersProjects
          : usersProjects // ignore: cast_nullable_to_non_nullable
              as List<ProjectEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectMainStateImplCopyWith<$Res>
    implements $ProjectStateCopyWith<$Res> {
  factory _$$ProjectMainStateImplCopyWith(_$ProjectMainStateImpl value,
          $Res Function(_$ProjectMainStateImpl) then) =
      __$$ProjectMainStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Status status,
      List<ProjectEntity> available,
      List<ProjectEntity> userResponses,
      List<ProjectEntity> usersProjects});
}

/// @nodoc
class __$$ProjectMainStateImplCopyWithImpl<$Res>
    extends _$ProjectStateCopyWithImpl<$Res, _$ProjectMainStateImpl>
    implements _$$ProjectMainStateImplCopyWith<$Res> {
  __$$ProjectMainStateImplCopyWithImpl(_$ProjectMainStateImpl _value,
      $Res Function(_$ProjectMainStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? available = null,
    Object? userResponses = null,
    Object? usersProjects = null,
  }) {
    return _then(_$ProjectMainStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      available: null == available
          ? _value._available
          : available // ignore: cast_nullable_to_non_nullable
              as List<ProjectEntity>,
      userResponses: null == userResponses
          ? _value._userResponses
          : userResponses // ignore: cast_nullable_to_non_nullable
              as List<ProjectEntity>,
      usersProjects: null == usersProjects
          ? _value._usersProjects
          : usersProjects // ignore: cast_nullable_to_non_nullable
              as List<ProjectEntity>,
    ));
  }
}

/// @nodoc

class _$ProjectMainStateImpl implements ProjectMainState {
  const _$ProjectMainStateImpl(
      {required this.status,
      required final List<ProjectEntity> available,
      required final List<ProjectEntity> userResponses,
      required final List<ProjectEntity> usersProjects})
      : _available = available,
        _userResponses = userResponses,
        _usersProjects = usersProjects;

  @override
  final Status status;
  final List<ProjectEntity> _available;
  @override
  List<ProjectEntity> get available {
    if (_available is EqualUnmodifiableListView) return _available;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_available);
  }

  final List<ProjectEntity> _userResponses;
  @override
  List<ProjectEntity> get userResponses {
    if (_userResponses is EqualUnmodifiableListView) return _userResponses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userResponses);
  }

  final List<ProjectEntity> _usersProjects;
  @override
  List<ProjectEntity> get usersProjects {
    if (_usersProjects is EqualUnmodifiableListView) return _usersProjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_usersProjects);
  }

  @override
  String toString() {
    return 'ProjectState.mainState(status: $status, available: $available, userResponses: $userResponses, usersProjects: $usersProjects)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectMainStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._available, _available) &&
            const DeepCollectionEquality()
                .equals(other._userResponses, _userResponses) &&
            const DeepCollectionEquality()
                .equals(other._usersProjects, _usersProjects));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_available),
      const DeepCollectionEquality().hash(_userResponses),
      const DeepCollectionEquality().hash(_usersProjects));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectMainStateImplCopyWith<_$ProjectMainStateImpl> get copyWith =>
      __$$ProjectMainStateImplCopyWithImpl<_$ProjectMainStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Status status,
            List<ProjectEntity> available,
            List<ProjectEntity> userResponses,
            List<ProjectEntity> usersProjects)
        mainState,
  }) {
    return mainState(status, available, userResponses, usersProjects);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            Status status,
            List<ProjectEntity> available,
            List<ProjectEntity> userResponses,
            List<ProjectEntity> usersProjects)?
        mainState,
  }) {
    return mainState?.call(status, available, userResponses, usersProjects);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Status status,
            List<ProjectEntity> available,
            List<ProjectEntity> userResponses,
            List<ProjectEntity> usersProjects)?
        mainState,
    required TResult orElse(),
  }) {
    if (mainState != null) {
      return mainState(status, available, userResponses, usersProjects);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectMainState value) mainState,
  }) {
    return mainState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectMainState value)? mainState,
  }) {
    return mainState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectMainState value)? mainState,
    required TResult orElse(),
  }) {
    if (mainState != null) {
      return mainState(this);
    }
    return orElse();
  }
}

abstract class ProjectMainState implements ProjectState {
  const factory ProjectMainState(
          {required final Status status,
          required final List<ProjectEntity> available,
          required final List<ProjectEntity> userResponses,
          required final List<ProjectEntity> usersProjects}) =
      _$ProjectMainStateImpl;

  @override
  Status get status;
  @override
  List<ProjectEntity> get available;
  @override
  List<ProjectEntity> get userResponses;
  @override
  List<ProjectEntity> get usersProjects;
  @override
  @JsonKey(ignore: true)
  _$$ProjectMainStateImplCopyWith<_$ProjectMainStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
