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
conda create --file environment.yml
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

| Event                     | Date       | Runtime    | Storage | run time (s) | avg. img/s | Test Acc@1 | Log file                  |
|---------------------------|------------|------------|---------|--------------|------------|------------|---------------------------|
| Added vast storage option | 2023-03-02 | nvidia_ngc | vast    | 1,235        | 1175.31    | 22.08%     | pytorch_benchmark.o202908 |
| Initial test              | 2023-02-20 | nvidia_ngc | zfs     | 1,270        | 1058.28    | 25.36%     | pytorch_benchmark.o176760 |
| "                         | "          | conda      | zfs     | 1,349        | 992.47     | 25.54%     | pytorch_benchmark.o176787 |