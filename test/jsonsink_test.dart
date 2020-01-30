// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:convert";
import "package:test/test.dart";
import "package:jsontool/jsontool.dart";

import "src/json_data.dart";

void main() {
  test("simple rebuild", () {
    var simple = jsonDecode(simpleJson);
    var builtSimple;
    JsonReader.fromString(simpleJson).expectAnyValue(jsonObjectWriter((result) {
      builtSimple = result;
    }));
    expect(simple, builtSimple);
  });

  test("simple toString", () {
    var simple = jsonEncode(jsonDecode(simpleJson));
    var buffer = StringBuffer();
    JsonReader.fromString(simpleJson).expectAnyValue(jsonStringWriter(buffer));
    expect(simple, buffer.toString());
  });

  group("validating sink,", () {
    test("single value", () {
      var sink = validateJsonSink(nullJsonSink);
      expectValue(sink);
      sink.addNumber(1);
      expectDone(sink);
    });
    test("single value, reusable", () {
      var sink = validateJsonSink(nullJsonSink, allowReuse: true);
      expectValue(sink);
      sink.addNumber(1);
      expectValue(sink);
      sink.addString("x");
    });
    test("composite", () {
      var sink = validateJsonSink(nullJsonSink);
      expectValue(sink);
      sink.startArray();
      expectValue(sink, insideArray: true);
      sink.addString("x");
      expectValue(sink, insideArray: true);
      sink.startObject();
      expectKey(sink);
      sink.addKey("x");
      expectValue(sink);
      sink.startArray();
      expectValue(sink, insideArray: true);
      sink.endArray();
      expectKey(sink);
      sink.endObject();
      expectValue(sink, insideArray: true);
      sink.endArray();
      expectDone(sink);
    });
  });
}

// Utility functions for checking validating sink.
void expectNoKey(JsonSink sink) {
  expect(() => sink.addKey("a"), throwsStateError);
}

void expectNoValue(JsonSink sink) {
  expect(() => sink.addBool(true), throwsStateError);
  expect(() => sink.addNull(), throwsStateError);
  expect(() => sink.addNumber(1), throwsStateError);
  expect(() => sink.addString(""), throwsStateError);
  expect(() => sink.startArray(), throwsStateError);
  expect(() => sink.startObject(), throwsStateError);
}

void expectKey(JsonSink sink) {
  expectNoValue(sink);
  expect(() => sink.endArray(), throwsStateError);
}

void expectValue(JsonSink sink, {bool insideArray = false}) {
  expectNoKey(sink);
  expect(() => sink.endObject(), throwsStateError);
  if (!insideArray) {
    expect(() => sink.endArray(), throwsStateError);
  }
}

void expectDone(JsonSink sink) {
  expectNoValue(sink);
  expectNoKey(sink);
  expect(() => sink.endObject(), throwsStateError);
  expect(() => sink.endArray(), throwsStateError);
}
