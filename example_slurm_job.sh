#!/bin/bash
#SBATCH --partition=gpu
#SBATCH --time=2:00:00
#SBATCH --gpus=4
#SBATCH --cpus-per-gpu=12
#SBATCH --mem-per-gpu=36G

### NOTE
### This job script cannot be used without modification for your specific environment.

module load python/gcc/3.11
module load alphafold/2.3.2-1

### Check values of some environment variables
echo INFO: SLURM_GPUS_ON_NODE=$SLURM_GPUS_ON_NODE
echo INFO: SLURM_JOB_GPUS=$SLURM_JOB_GPUS
echo INFO: SLURM_STEP_GPUS=$SLURM_STEP_GPUS
echo INFO: ALPHAFOLD_DIR=$ALPHAFOLD_DIR
echo INFO: ALPHAFOLD_DATADIR=$ALPHAFOLD_DATADIR
echo INFO: TMP=$TMP

###
### README This runs AlphaFold 2.3.2 on the T1050.fasta file
###

# AlphaFold should use all GPU devices available to the job by default.
#
# To run the CASP14 evaluation, use:
#   --model_preset=monomer_casp14
#   --db_preset=full_dbs (or delete the line; default is "full_dbs")
#
# On a test system with 4x Tesla V100-SXM2, this took about 50 minutes.
#
# To benchmark, running multiple JAX model evaluations (NB this 
# significantly increases run time):
#   --benchmark
#
# On a test system with 4x Tesla V100-SXM2, this took about 6 hours.

# Create output directory in $TMP (which is cleaned up by Slurm at end
# of job).
output_dir=$TMP/output
mkdir -p $output_dir

echo INFO: output_dir=$output_dir

# Run AlphaFold; default is to use GPUs
python3 ${ALPHAFOLD_DIR}/singularity/run_singularity.py \
    --use_gpu \
    --output_dir=$output_dir \
    --data_dir=${ALPHAFOLD_DATADIR} \
    --fasta_paths=T1050.fasta \
    --max_template_date=2020-05-14 \
    --model_preset=monomer \
    --db_preset=reduced_dbs

echo INFO: AlphaFold returned $?

### Copy Alphafold output back to directory where "sbatch" command was issued.
mkdir $SLURM_SUBMIT_DIR/Output-$SLURM_JOB_ID
cp -R $output_dir $SLURM_SUBMIT_DIR/Output-$SLURM_JOB_ID

