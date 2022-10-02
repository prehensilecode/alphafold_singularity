#!/bin/bash
#SBATCH -p gpu
#SBATCH --time=18:00:00
#SBATCH --gpus=4
#SBATCH --cpus-per-gpu=12
#SBATCH --mem=140G

module load alphafold/2.2.4
module load python/gcc/3.10

### Check values of some environment variables
echo SLURM_JOB_GPUS=$SLURM_JOB_GPUS
echo ALPHAFOLD_DIR=$ALPHAFOLD_DIR
echo ALPHAFOLD_DATADIR=$ALPHAFOLD_DATADIR

###
### README This runs AlphaFold 2.2.2 on the T1050.fasta file
###

# AlphaFold should use all GPU devices available to the job by default.
# To explicitly specify use of GPUs, and the GPU devices to use, add
#   --use_gpu --gpu_devices=${SLURM_JOB_GPUS}
#
# To run the CASP14 evaluation, use:
#   --model_preset=monomer_casp14
#
# To benchmark, running multiple JAX model evaluations (NB this 
# significantly increases run time):
#   --benchmark

# Run AlphaFold; default is to use GPUs, i.e. "--use_gpu" can be omitted.
python3 ${ALPHAFOLD_DIR}/singularity/run_singularity.py \
    --use_gpu --gpu_devices=${SLURM_JOB_GPUS} \
    --data_dir=${ALPHAFOLD_DATADIR} \
    --fasta_paths=T1050.fasta \
    --max_template_date=2020-05-14 \
    --model_preset=monomer_casp14 \
    --benchmark

echo INFO: AlphaFold returned $?

### Copy Alphafold output back to directory where "sbatch" command was issued.
mkdir $SLURM_SUBMIT_DIR/Output-$SLURM_JOB_ID
cp -R $TMPDIR $SLURM_SUBMIT_DIR/Output-$SLURM_JOB_ID

