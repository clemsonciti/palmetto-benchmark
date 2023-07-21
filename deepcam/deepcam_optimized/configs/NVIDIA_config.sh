#!/bin/bash

# this should never be exceeded by any benchmark
export MAX_EPOCHS=50

# auxiliary parameters
export LOGGING_FREQUENCY=0

# run parameters
export NEXP="${NEXP:-5}"

# system parameters
export DGXNGPU=2
export DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )

# hyperparameters
export LOCAL_BATCH_SIZE=1
export START_LR=0.0055
export OPTIMIZER="LAMB"
export LR_SCHEDULE_TYPE="multistep"
export LR_MILESTONES="4000"
export LR_DECAY_RATE="0.1"
export LR_WARMUP_STEPS=400
export LR_WARMUP_FACTOR=1.
export WEIGHT_DECAY=0.01
export BATCHNORM_GROUP_SIZE=1

# data parameters
export SHUFFLE_MODE="global"
export DATA_FORMAT="dali-es-gpu"
export DATA_OVERSAMPLING_FACTOR=1
export PRECISION_MODE="amp"
export LOCAL_VALIDATION_BATCH_SIZE=1
export MAX_THREADS=1

# misc args
export ADDITIONAL_ARGS="--disable_comm_overlap --enable_graph --enable_jit"

# system parameters
export DGXNNODES=18
WALLTIME_MINUTES=1000
export WALLTIME=$(( 15 + (${NEXP} * ${WALLTIME_MINUTES}) ))
#export SBATCH_NETWORK="sharp"
