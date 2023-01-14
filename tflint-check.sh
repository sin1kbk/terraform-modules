#!/bin/bash

cd "$(dirname "$0")" || exit 1

find ../ -type f -name '*.tf' -exec dirname {} \; | sort -u | xargs -n 1 tflint --enable-rule=terraform_unused_declarations

if [ "$?" -ne 0 ]; then
  echo "======================================================================="
else
  echo "Ok. ==================================================================="
fi