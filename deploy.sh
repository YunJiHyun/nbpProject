#!/bin/bash
rm -rf JihyunYun

git clone https://oss.navercorp.com/2017-msd-summer-internship/JihyunYun.git

cd JihyunYun

mvn clean package

cd target

