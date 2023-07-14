# Pytorch Benchmarks
This benchmark trains resnet50 for 1 epoch on the [ImageNet](https://www.image-net.org/) dataset located at `/zfs/citi/datasets/imagenet/ILSVRC/Data/CLS-LOC`. The benchmark measures the total application time including setup, training, and evaluation. 

This benchmark depends on the [Pytorch image models](https://github.com/rwightman/pytorch-image-models) library. For stability of the benchmarks, a [specific commit](https://github.com/rwightman/pytorch-image-models/commit/e069249a2dab0056a7687d5e48043757c46e7525) from this library is packaged in the current repository. Later versions would likely fail to run due to unmet dependencies.

## Environment setup

### Apptainer environment using Nvidia's Pytorch container
Set NGC authentication variables and build the image. Warning: building the image can use a large amount of memory. It is recommended to build with at least 64GB of RAM. 
```{bash}
export APPTAINER_DOCKER_USERNAME='$oauthtoken'
export APPTAINER_DOCKER_PASSWORD=<your ngc token>
apptainer build /zfs/citi/benchmarks/palmetto_benchmark/pytorch/ngc_pytorch.simg \
    docker://nvcr.io/nvidia/pytorch:22.04-py3
```

### Conda environment
Run the following from the project's root directory. This creates a new conda environment called `pytorch_bench` and installs the necessary dependencies. 
```{bash}
module load anaconda3/2022.05-gcc/9.5.0
conda env create --file environment.yml
```

## Run the benchmark
Run the benchmark using
```{bash}
qsub -v RUNTIME=<runtime>,STORAGE=<storage> run.pbs
```
where `<runtime>` is one of:
* "nvidia_ngc": apptainer image based on nvidia's Pytorch container
* "conda": Pytorch installed in a conda environment

and `<storage>` is one of (see [docs](https://docs.rcd.clemson.edu/palmetto/storage/store#storage-hardware-grid)):
* "zfs": read the data from zfs
* "vast": read the data from vast

The job executes with the following PBS settings:
```
#PBS -N pytorch_benchmark
#PBS -l select=1:ncpus=56:mem=372gb:ngpus=1:gpu_model=a100:phase=27,walltime=02:00:00
#PBS -q wficai
#PBS -j oe
```

## Results 
After running the benchmark, insert results into the table below. Move the corresponding log file into the "saved_logs" folder. 

| Event                     | Date       | Runtime    | Storage | run time (s) | avg. img/s | Test Acc@1 | Config |
|---------------------------|------------|------------|---------|--------------|------------|------------|--------|
| July 2023 Post-maintenance| 2023-07-14 | nvidia_ngc | vast    | 1,139        | 1192.27    | 22.08%     | Phase 29 -- 20cpu, 100gb, 1 gpu |
| "                         | "          | "          | "       | 1,141        | 1190.91    | 22.08%     | Phase 28 -- 20cpu, 100gb, 1 gpu |
| "                         | "          | "          | "       | 1,224        | 1088.85    | 22.08%     | Phase 27 -- 20cpu, 100gb, 1 gpu |
| July 2023 Pre-maintenance | 2023-07-10 | nvidia_ngc | vast    | 1,123        | 1188.76    | 22.08%     | Phase 29 -- 20cpu, 100gb, 1 gpu |
| "                         | "          | "          | "       | 1,114        | 1197.74    | 22.08%     | Phase 28 -- 20cpu, 100gb, 1 gpu |
| "                         | "          | "          | "       | 1,262        | 1061.14    | 25.36%     | Phase 27 -- 20cpu, 100gb, 1 gpu |
| "                         | "          | "          | "       | 1,241        | 1095.24    | 22.08%     | Phase 27 -- Full Node, 1 gpu |
| Added vast storage option | 2023-03-02 | nvidia_ngc | vast    | 1,235        | 1175.31    | 22.08%     | Phase 27 -- Full Node, 1 gpu |
| Initial test              | 2023-02-20 | nvidia_ngc | zfs     | 1,270        | 1058.28    | 25.36%     | Phase 27 -- Full Node, 1 gpu |
| "                         | "          | conda      | zfs     | 1,349        | 992.47     | 25.54%     | Phase 27 -- Full Node, 1 gpu |
