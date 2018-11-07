#!/bin/bash

TEMPLATE_CONFIG=$1
SET_CONFIG=$2

PROD_URL="localhost"
DEV_URL="localhost"

# PROD_URL="https://localhost"
# DEV_URL="https://localhost"

cp $TEMPLATE_CONFIG $SET_CONFIG

sed -i "s#PROD_URL#$PROD_URL#g" $SET_CONFIG
sed -i "s#DEV_URL#$DEV_URL#g" $SET_CONFIG