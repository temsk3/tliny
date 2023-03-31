// ignore_for_file: directives_ordering
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:auto_route_generator/builder.dart' as _i2;
import 'package:flutter_gen_runner/flutter_gen_runner.dart' as _i3;
import 'package:freezed/builder.dart' as _i4;
import 'package:json_serializable/builder.dart' as _i5;
import 'package:retrofit_generator/retrofit_generator.dart' as _i6;
import 'package:riverpod_generator/builder.dart' as _i7;
import 'package:source_gen/builder.dart' as _i8;
import 'dart:isolate' as _i9;
import 'package:build_runner/build_runner.dart' as _i10;
import 'dart:io' as _i11;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(
    r'auto_route_generator:auto_route_generator',
    [_i2.autoRouteBuilder],
    _i1.toDependentsOf(r'auto_route_generator'),
    hideOutput: true,
  ),
  _i1.apply(
    r'auto_route_generator:auto_router_generator',
    [_i2.autoRouterBuilder],
    _i1.toDependentsOf(r'auto_route_generator'),
    hideOutput: false,
  ),
  _i1.apply(
    r'flutter_gen_runner:flutter_gen_runner',
    [_i3.build],
    _i1.toDependentsOf(r'flutter_gen_runner'),
    hideOutput: false,
  ),
  _i1.apply(
    r'freezed:freezed',
    [_i4.freezed],
    _i1.toDependentsOf(r'freezed'),
    hideOutput: false,
  ),
  _i1.apply(
    r'json_serializable:json_serializable',
    [_i5.jsonSerializable],
    _i1.toDependentsOf(r'json_serializable'),
    hideOutput: true,
    appliesBuilders: const [r'source_gen:combining_builder'],
  ),
  _i1.apply(
    r'retrofit_generator:retrofit',
    [_i6.retrofitBuilder],
    _i1.toDependentsOf(r'retrofit_generator'),
    hideOutput: true,
    appliesBuilders: const [r'source_gen:combining_builder'],
  ),
  _i1.apply(
    r'riverpod_generator:riverpod_generator',
    [_i7.riverpodBuilder],
    _i1.toDependentsOf(r'riverpod_generator'),
    hideOutput: true,
    appliesBuilders: const [r'source_gen:combining_builder'],
  ),
  _i1.apply(
    r'source_gen:combining_builder',
    [_i8.combiningBuilder],
    _i1.toNoneByDefault(),
    hideOutput: false,
    appliesBuilders: const [r'source_gen:part_cleanup'],
  ),
  _i1.applyPostProcess(
    r'source_gen:part_cleanup',
    _i8.partCleanup,
  ),
];
void main(
  List<String> args, [
  _i9.SendPort? sendPort,
]) async {
  var result = await _i10.run(
    args,
    _builders,
  );
  sendPort?.send(result);
  _i11.exitCode = result;
}
