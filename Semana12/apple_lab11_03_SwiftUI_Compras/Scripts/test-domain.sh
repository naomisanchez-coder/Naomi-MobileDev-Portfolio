#!/bin/zsh
set -euo pipefail
project_dir="${0:A:h:h}"
test_dir="$(mktemp -d /private/tmp/compras-tests.XXXXXX)"
swiftc -module-cache-path "$test_dir/cache" -parse-as-library \
  "$project_dir/Compras/Models.swift" \
  "$project_dir/Compras/Business.swift" \
  "$project_dir/Tests/BusinessTests.swift" -o "$test_dir/business-tests"
"$test_dir/business-tests"
