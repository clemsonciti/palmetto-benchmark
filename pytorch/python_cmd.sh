#!/bin/bash
start=`date +%s`
python train.py \
    --model resnet50d \
    --epochs 1 \
    --warmup-epochs 0 \
    --lr 0.4 \
    --batch-size 512 \
    --sched none \
    --amp \
    -j 15 \
    $DATA_DIR
end=`date +%s`
runtime=$((end-start))
echo "Total runtime (s): "${runtime}

