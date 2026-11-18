#!/bin/zsh
set -euo pipefail
project_dir="${0:A:h:h}"
qa_device="${1:?Indica el UDID del simulador Compras Rediseño QA}"
qa_name="$(xcrun simctl list devices available -j | python3 -c 'import json,sys; d=json.load(sys.stdin); print(next((x["name"] for group in d["devices"].values() for x in group if x["udid"]==sys.argv[1]), ""))' "$qa_device")"
if [[ "$qa_name" != "Compras Rediseño QA" ]]; then
  print -u2 "Se requiere el simulador independiente Compras Rediseño QA. No se ejecutaron pruebas."
  exit 1
fi
result_dir="$(mktemp -d /private/tmp/compras-redesign-tests.XXXXXX)"
xcodebuild -project "$project_dir/Compras.xcodeproj" -scheme Compras \
  -configuration Debug -destination "platform=iOS Simulator,id=$qa_device" \
  -derivedDataPath /private/tmp/ComprasRedesignBuild -resultBundlePath "$result_dir/Results.xcresult" \
  CODE_SIGNING_ALLOWED=NO test
print "Resultados: $result_dir/Results.xcresult"
