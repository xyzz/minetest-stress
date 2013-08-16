#!/bin/bash

STRESS_DIR=$(pwd)
DIR="$(mktemp -d)"

cd /tmp/
wget -N http://minetest.ru/bin/minimal.tar.gz

cd $DIR
tar xf /tmp/minimal.tar.gz
cd minimal
ln -s $STRESS_DIR $DIR/minimal/games/minimal/mods/stress
echo "Stress.config.debug = true" > $STRESS_DIR/config.local.lua
./bin/minetestserver --gameid minimal || exit

lua luacov_s -c=$STRESS_DIR/tests/luacov.lua
cat luacov.report.out
