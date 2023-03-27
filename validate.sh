#!/bin/sh
err() { echo "[ERROR]: $*" >&2 ; }
cd "${0%/*}"
this_path="$(pwd)"
root_path="${this_path}"

error=false

command="docker run --rm -i -v $(pwd):/workspace kickthemooon/devops-utils"
temp_output_path="/tmp/helm-output.yaml"

${command} helm template app charts/helm-interface -f examples/values-simple.yaml > "${temp_output_path}"
cat "${temp_output_path}" | ${command} kubeconform
if [ "${?}" != "0" ]; then
  error=true
fi

${command} helm template app charts/helm-interface -f examples/values-full.yaml > "${temp_output_path}"
cat "${temp_output_path}" | ${command} kubeconform
if [ "${?}" != "0" ]; then
  error=true
fi

if $error; then
  err "some error occurred. failing ..."
  exit 1
fi