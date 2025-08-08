#!/bin/bash
set -e -x

PWD=$(pwd)
cd "$(dirname "$0")" && cd ../../

date_format=$(date +%Y-%m-%d)
dir="history/$date_format"
url="https://app.stainless.com/api/spec/documented/openai/openapi.documented.yml"
newurl="https://shalk.github.io/openai-swagger-ui/$dir/openapi.yaml"

mkdir -p "$dir"
rm -f "$dir/openapi.yaml" "$dir/index.html"

if ! curl "$url" -o "$dir/openapi.yaml"; then
    echo "Error downloading openapi.yaml from $url"
    exit 1
fi

cp -f index.html "$dir/index.html"

sed -i "s#$url#$newurl#" "$dir/index.html"

cd "$PWD"
