#!/bin/zsh
set -euo pipefail
project_dir="${0:A:h:h}"
destination="${1:-platform=iOS Simulator,name=iPhone 17 Pro}"
xcodebuild -project "$project_dir/Compras.xcodeproj" -scheme Compras \
  -configuration Debug -destination "$destination" \
  -derivedDataPath /private/tmp/ComprasBuild CODE_SIGNING_ALLOWED=NO build
