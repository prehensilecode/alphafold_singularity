# alphafold_singularity
Singularity recipe for AlphaFold, with example Slurm job script.

This splits off my pull request https://github.com/deepmind/alphafold/pull/166

### Unfixed bug in Alphafold tagged release 2.2.2
N.B. https://github.com/deepmind/alphafold/issues/510#issuecomment-1159062272

## What This Code Contains
* `Singularity.def` which is the recipe to build the Singularity image. This is a port of the Dockerfile provided by AlphaFold.
* `run_singularity.py` which is a port of the `run_docker.py` script provided by AlphaFold. It is a wrapper to provide a friendly interface for running the container.

## Installation Instructions
### Build the Singularity image
Check out this repo into the top of the alphafold source tree to a directory called `singularity`:
```
$ cd alphafold-v2.x.x
$ git clone https://github.com/prehensilecode/alphafold_singularity singularity

```

To use, first install the Python requirements:
```
$ pip install -r singularity/requirements.txt
```

Then, build the Singularity image:
```
$ sudo singularity build alphafold.sif singularity/Singularity.def
```

If your `/tmp` directory is small, you may need to set the [`SINGULARITY_TMPDIR`
environment variable](https://sylabs.io/guides/3.3/user-guide/build_env.html#temporary-folders) to a directory on a filesystem with more free space.

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
