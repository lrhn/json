// Copyright (c) 2020, the JSONTool project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "sink.dart";

/// A [JsonSink] which does nothing.
class NullJsonSink implements JsonSink {
  const NullJsonSink();

  void addBool(bool value) {}

  void addKey(String key) {}

  void addNull() {}

  void addNumber(num value) {}

  void addString(String value) {}

  void endArray() {}

  void endObject() {}

  void startArray() {}

  void startObject() {}
}
