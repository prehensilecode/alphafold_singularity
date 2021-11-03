#!/bin/bash
#SBATCH --partition=gpu
#SBATCH --time=2:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-gpu=12
#SBATCH --mem-per-gpu=30G

module load alphafold

# the alphafold modulefile should define:
# * ALPHAFOLD_DIR -- install location AlphaFold
# * ALPHAFOLD_DATADIR -- the DOWLOAD_DIR set in scripts/download_all_data.sh

# Run AlphaFold; default is to use GPUs, i.e. "--use_gpu"
python3 ${ALPHAFOLD_DIR}/singularity/run_singularity.py \
  --fasta_paths=T1050.fasta \
  --max_template_date=2020-05-14 \
  --preset=reduced_dbs

# AlphaFold should use all GPU devices available to the job.
# To explicitly specify use of GPUs, and the GPU devices to use, add
#   --use_gpu --gpu_devices=${SLURM_JOB_GPUS}

# To run the CASP14 evaluation, use:
#   --preset=casp14

# To benchmark, running multiple JAX model evaluations:
#   --benchmark

# Copy all output from AlphaFold back to directory where "sbatch" command was issued
cp -R $TMPDIR $SLURM_SUBMIT_DIR

