# alphafold_singularity
Singularity recipe for [AlphaFold](https://github.com/deepmind/alphafold/), with example Slurm job script.

This splits off my pull request https://github.com/deepmind/alphafold/pull/166

Disclaimer: this project is not affiliated with DeepMind.

### Unfixed bug in Alphafold tagged release 2.2.2
N.B. https://github.com/deepmind/alphafold/issues/510#issuecomment-1159062272

## Prebuilt Singularity image
A prebuilt image is hosted on cloud.sylabs.io: [https://cloud.sylabs.io/library/prehensilecode/alphafold_singularity/alphafold](https://cloud.sylabs.io/library/prehensilecode/alphafold_singularity/alphafold)

## What This Code Contains
* `Singularity.def` which is the recipe to build the Singularity image. This is a port of the [Dockerfile](https://github.com/deepmind/alphafold/blob/main/docker/Dockerfile) provided by AlphaFold.
* `run_singularity.py` which is a port of the [`run_docker.py`](https://github.com/deepmind/alphafold/blob/main/docker/run_docker.py) script provided by AlphaFold. It is a wrapper to provide a friendly interface for running the container.

## Installation Instructions
### Download AlphaFold and alphafold_singularity:
N.B. The AlphaFold version and the alphafold_singularity versions must match.

```
$ export ALPHAFOLD_VERSION=2.2.4
$ wget https://github.com/deepmind/alphafold/archive/refs/tags/v${ALPHAFOLD_VERSION}.tar.gz -O alphafold-${ALPHAFOLD_VERSION}.tar.gz
...
2023-02-08 17:28:50 (1.24 MB/s) - ‘alphafold-x.x.x.tar.gz’ saved [5855095]
$ tar -xvf alphafold-${ALPHAFOLD_VERSION}.tar.gz
$ cd alphafold-${ALPHAFOLD_VERSION}
$ wget https://github.com/prehensilecode/alphafold_singularity/archive/refs/tags/v${ALPHAFOLD_VERSION}.tar.gz -O alphafold_singularity-${ALPHAFOLD_VERSION}.tar.gz
...
2023-02-08 17:42:18 (1.58 MB/s) - ‘alphafold_singularity-x.x.x.tar.gz’ saved [10148]
$ tar -xf alphafold_singularity-${ALPHAFOLD_VERSION}.tar.gz
$ mv alphafold_singularity-${ALPHAFOLD_VERSION} singularity
$ python3 -m pip install -r singularity/requirements.txt
$ sudo singularity build alphafold.sif singularity/Singularity.def
```

### Build the Singularity image
First install the Python requirements:
```
$ python3 -m pip install -r singularity/requirements.txt
```

Then, build the Singularity image:
```
$ sudo singularity build alphafold.sif singularity/Singularity.def
```

If your `/tmp` directory is small, you may need to set the [`SINGULARITY_TMPDIR`
environment variable](https://sylabs.io/guides/3.3/user-guide/build_env.html#temporary-folders) to a directory on a filesystem with more free space.
My builds have consumed up to 15 GiB of space. The resulting image file may be up to 10 GiB.

### Install and run
To run, modify the `$ALPHAFOLD_SRC/singularity/run_singularity.py` and change the 
section marked `USER CONFIGURATION`. At the least, you will need to modify the values
of:
- `singularity_image` - absolute path to the `alphafold.sif` Singularity image

E.g.
```
#### USER CONFIGURATION ####
# AlphaFold Singularity image.
singularity_image = Client.load(os.path.join(os.environ['ALPHAFOLD_DIR'], 'alphafold.sif'))
```

### Run as a Slurm job on a cluster
See the example job script [`example_slurm_job.sh`](https://github.com/prehensilecode/alphafold_singularity/blob/main/example_slurm_job.sh)
