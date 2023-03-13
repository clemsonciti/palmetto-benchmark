#!/bin/bash

project_dir='/zfs/citi/benchmarks/palmetto_benchmark/pytorch'
current_date=`date` 

# set appropriate data path based on storage
data_dir='/zfs/citi/datasets/imagenet/ILSVRC/Data/CLS-LOC'

echo "---------------------------------"
echo "Using AMD Container runtime."
echo ${current_date}
echo "---------------------------------"

img_file=${project_dir}/amd_pytorch.sif

apptainer exec --rocm \
  --bind ${project_dir}/pytorch-image-models:/home \
  --bind ${data_dir}:/data \
  --bind ${project_dir}/python_cmd.sh:/run/python_cmd.sh \
  --pwd /home \
  --env DATA_DIR=/data \
  ${img_file} \
  /bin/bash /run/python_cmd.sh




