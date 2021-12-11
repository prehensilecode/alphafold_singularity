# alphafold_singularity
Singularity recipe for AlphaFold, with example Slurm job script.

This splits off my pull request https://github.com/deepmind/alphafold/pull/166

## Installation Instructions
Check out this repo into the top of the alphafold source tree:
```
$ cd singularity-v2.x.x
$ git clone https://github.com/prehensilecode/alphafold_singularity
```

To use, first install the Python requirements:
```
$ pip install -r alphafold_singularity/requirements.txt
```

Then, build the Singularity image:
```
sudo singularity build alphafold.sif alphafold_singularity/Singularity.def
```

If your `/tmp` directory is small, you may need to set the [`SINGULARITY_TMPDIR`
environment variable](https://sylabs.io/guides/3.3/user-guide/build_env.html#temporary-folders) to a directory on a filesystem with more free space.
