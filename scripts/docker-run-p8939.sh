#!/bin/zsh
docker stop illustor3
docker rm illustor3
docker run --name illustor3 -p 8939:80 -d chiyoi/illustor3
