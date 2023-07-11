# Data
export DATA_DIR="/project/rcde/mlperf_data/deepcam/All-Hist"
export OUTPUT_DIR="/project/rcde/nnisbet/output"
export RUN_TAG="mlperf_hpc:deepcam_run1"
export LOCAL_BATCH_SIZE=2

# Hyperparameters
export START_LR=0.0025
export OPTIMIZER="LAMB"
export LR_SCHEDULE_TYPE="multistep"
#export LR_MILESTONES="1100 4096"
#export LR_MILESTONES="4096 8192"
export LR_MILESTONES="4096:8192"
export LR_DECAY_RATE="0.2"
export LR_WARMUP_STEPS=100
export LR_WARMUP_FACTOR=1.
export WEIGHT_DECAY=0.01
export BATCHNORM_GROUP_SIZE=1

# data parameters
export SHUFFLE_MODE="global"
export DATA_FORMAT="dali-es"
export PRECISION_MODE="amp"
export LOCAL_VALIDATION_BATCH_SIZE=8
export MAX_THREADS=8

# auxiliary parameters
export LOGGING_FREQUENCY=1000

# misc args
export ADDITIONAL_ARGS="--enable_jit --disable_comm_overlap --enable_graph"

# run parameter
export NEXP="${NEXP:-5}"

# system parameters
export DGXNGPU=40
export DGXNNODES=20
export DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )

#WALLTIME_MINUTES=20
#export WALLTIME=$(( 15 + (${NEXP} * ${WALLTIME_MINUTES}) ))


