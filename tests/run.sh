#!/bin/bash

STRESS_DIR=$(pwd)
DIR="$(mktemp -d)"

cd $DIR
wget http://minetest.ru/bin/minimal.tar.gz
tar xf minimal.tar.gz
cd minimal
ln -s $STRESS_DIR $DIR/minimal/games/minimal/mods/stress
echo "Stress.config.debug = true" > $STRESS_DIR/config.local.lua
./bin/minetestserver --gameid minimal

lua luacov_s -c=$STRESS_DIR/tests/luacov.lua
cat luacov.report.out
