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
