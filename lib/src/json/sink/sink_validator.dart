// Copyright (c) 2020, the JSONTool project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jsontool/src/json/json_structure_validator.dart';

import "sink.dart";

/// Validating [JsonSink] which checks that methods are only used correctly.
///
/// Maintains an internal state machine which knows whether the sink is
/// currently expecting a top-level value, an array value or an
/// object key or value.
class ValidatingJsonSink implements JsonSink {
  /// The original sink. All method calls are forwarded to this after validation.
  final JsonSink _sink;

  final JsonStructureValidator _validator;

  ValidatingJsonSink(this._sink, bool allowReuse)
      : _validator = JsonStructureValidator(allowReuse: allowReuse);

  void addBool(bool value) {
    _validator.value();
    _sink.addBool(value);
  }

  void addKey(String key) {
    _validator.key();
    _sink.addKey(key);
  }

  @override
  void addNull() {
    _validator.value();
    _sink.addNull();
  }

  @override
  void addNumber(num value) {
    _validator.value();
    _sink.addNumber(value);
  }

  @override
  void addString(String value) {
    _validator.value();
    _sink.addString(value);
  }

  @override
  void endArray() {
    _validator.endArray();
    _sink.endArray();
  }

  @override
  void endObject() {
    _validator.endObject();
    _sink.endObject();
  }

  @override
  void startArray() {
    _validator.startArray();
    _sink.startArray();
  }

  @override
  void startObject() {
    _validator.startObject();
    _sink.startObject();
  }
}
