#!/bin/zsh
set -euo pipefail
project_dir="${0:A:h:h}"
destination="${1:-platform=iOS Simulator,name=iPhone 17 Pro}"
result_path="$(mktemp -d /private/tmp/compras-ui.XXXXXX)/Results.xcresult"
xcodebuild -project "$project_dir/Compras.xcodeproj" -scheme Compras \
  -configuration Debug -destination "$destination" \
  -derivedDataPath /private/tmp/ComprasBuild -resultBundlePath "$result_path" \
  CODE_SIGNING_ALLOWED=NO test
print "Evidencia XCTest: $result_path"
