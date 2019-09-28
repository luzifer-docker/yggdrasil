#!/bin/bash
set -euo pipefail

### ---- ###

echo "Switch back to master"
git checkout master
git reset --hard origin/master

### ---- ###

version=$(curl -s "https://lv.luzifer.io/catalog-api/yggdrasil/latest.txt?p=version")
grep -q "YGGDRASIL_VERSION=${version}" Dockerfile && exit 0 || echo "Update required"

sed -Ei \
	-e "s/YGGDRASIL_VERSION=[0-9.]+/YGGDRASIL_VERSION=${version}/" \
	Dockerfile

### ---- ###

echo "Testing build..."
docker build .

### ---- ###

echo "Updating repository..."
git add Dockerfile
git -c user.name='Travis Automated Update' -c user.email='travis@luzifer.io' \
	commit -m "Yggdrasil ${version}"
git tag v${version}

git push -q https://${GH_USER}:${GH_TOKEN}@github.com/luzifer-docker/yggdrasil master --tags
