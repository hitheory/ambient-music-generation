#!/bin/bash

echo 'music transformer shell script v0.2'
python /src/train.py --save_path /pfs/out --input_path /pfs/transformer_preprocess \
    --epochs 500 --batch_size 2 --max_seq 2048
