#!/bin/bash

# The MIT License (MIT)
#
# Copyright (c) 2020 NVIDIA CORPORATION. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# parameters
data_dir=$DATA_DIR
output_dir=$OUTPUT_DIR
run_tag=$RUN_TAG
local_batch_size=$LOCAL_BATCH_SIZE

python /project/rcde/nnisbet/mlperf_hpc/deepcam/src/deepCam/train.py \
       --wireup_method "nccl-slurm" \
       --run_tag ${run_tag} \
       --data_dir_prefix ${data_dir} \
       --output_dir ${output_dir} \
       --model_prefix "segmentation" \
       --optimizer ${OPTIMIZER} \
       --start_lr ${START_LR} \
       --lr_schedule type=${LR_SCHEDULE_TYPE},milestones=${LR_MILESTONE},decay_rate=${LR_DECAY_RATE} \
       --lr_warmup_steps ${LR_WARMUP_STEPS} \
       --lr_warmup_factor ${LR_WARMUP_FACTOR} \
       --weight_decay ${WEIGHT_DECAY} \
       --logging_frequency ${LOGGING_FREQUENCY} \
       --save_frequency 0 \
       --max_epochs 200 \
       --seed $(date +%s) \
       --batchnorm_group_size $BATCHNORM_GROUP_SIZE \
       --local_batch_size ${local_batch_size}
       --seed ${SEED}
       --max_inter_threads ${MAX_THREADS:-4}
       --shuffle_mode "${SHUFFLE_MODE}"
       --precision_mode "${PRECISION_MODE}"
       --enable_nhwc
       --save_frequency 100000
       ${ADDITIONAL_ARGS}