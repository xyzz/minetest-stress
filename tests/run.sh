#!/bin/bash

STRESS_DIR=$(pwd)
DIR="$(mktemp -d)"

cd $DIR
wget http://minetest.ru/bin/minimal.tar.gz
tar xf minimal.tar.gz
cd minimal
ln -s $STRESS_DIR $DIR/minimal/games/minimal/mods/stress
echo "Stress.config.debug = true" >> $STRESS_DIR/config.lua
./bin/minetestserver --gameid minimal
