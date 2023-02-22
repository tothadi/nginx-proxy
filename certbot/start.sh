#!/bin/bash

./generate_cf_ini.sh
crontab ./crontab
crond -f
