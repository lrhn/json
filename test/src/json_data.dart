// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

const simpleJson = '''{
  "key1": ["value11", "value12"],
  "key2": ["value21"],
  "key3": []
}''';

const complexJson = r'''[
  0,
  1.1e+2,
  1.1e-2,
  "",
  "abc",
  "ab\n\r\h\b\f\"\\\/z",
  true,
  false,
  null,
  [],
  [1],
  [1,2],
  {},
  {"x":1},
  {"x":1,"y":2},
  [{"a":[{}]}]
]''';
