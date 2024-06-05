// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TonState {
  Status get status => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Status status) mainState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Status status)? mainState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Status status)? mainState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonMainState value) mainState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonMainState value)? mainState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonMainState value)? mainState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TonStateCopyWith<TonState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TonStateCopyWith<$Res> {
  factory $TonStateCopyWith(TonState value, $Res Function(TonState) then) =
      _$TonStateCopyWithImpl<$Res, TonState>;
  @useResult
  $Res call({Status status});
}

/// @nodoc
class _$TonStateCopyWithImpl<$Res, $Val extends TonState>
    implements $TonStateCopyWith<$Res> {
  _$TonStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TonMainStateImplCopyWith<$Res>
    implements $TonStateCopyWith<$Res> {
  factory _$$TonMainStateImplCopyWith(
          _$TonMainStateImpl value, $Res Function(_$TonMainStateImpl) then) =
      __$$TonMainStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Status status});
}

/// @nodoc
class __$$TonMainStateImplCopyWithImpl<$Res>
    extends _$TonStateCopyWithImpl<$Res, _$TonMainStateImpl>
    implements _$$TonMainStateImplCopyWith<$Res> {
  __$$TonMainStateImplCopyWithImpl(
      _$TonMainStateImpl _value, $Res Function(_$TonMainStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$TonMainStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
    ));
  }
}

/// @nodoc

class _$TonMainStateImpl implements TonMainState {
  const _$TonMainStateImpl({required this.status});

  @override
  final Status status;

  @override
  String toString() {
    return 'TonState.mainState(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonMainStateImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TonMainStateImplCopyWith<_$TonMainStateImpl> get copyWith =>
      __$$TonMainStateImplCopyWithImpl<_$TonMainStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Status status) mainState,
  }) {
    return mainState(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Status status)? mainState,
  }) {
    return mainState?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Status status)? mainState,
    required TResult orElse(),
  }) {
    if (mainState != null) {
      return mainState(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonMainState value) mainState,
  }) {
    return mainState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonMainState value)? mainState,
  }) {
    return mainState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonMainState value)? mainState,
    required TResult orElse(),
  }) {
    if (mainState != null) {
      return mainState(this);
    }
    return orElse();
  }
}

abstract class TonMainState implements TonState {
  const factory TonMainState({required final Status status}) =
      _$TonMainStateImpl;

  @override
  Status get status;
  @override
  @JsonKey(ignore: true)
  _$$TonMainStateImplCopyWith<_$TonMainStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
