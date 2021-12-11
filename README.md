# alphafold_singularity
Singularity recipe for AlphaFold, with example Slurm job script.

This splits off my pull request https://github.com/deepmind/alphafold/pull/166

To use, first install the Python requirements:
```
pip install -r requirements.txt
```

Then, build the Singularity image:
```
sudo singularity build alphafold.sif Singularity.def
```

If your `/tmp` directory is small, you may need to set the `SINGULARITY_TMPDIR`
environment variable to a directory on a filesystem with more free space.
