#!/bin/bash
#SBATCH --account=p32307     ## <-- EDIT THIS TO BE YOUR ALLOCATION
#SBATCH --partition=long   ## <-- EDIT THIS TO BE YOUR QUEUE NAME
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=5GB
#SBATCH --job-name=train_hib
#SBATCH --array=1-100
#SBATCH --error=arrayJob_%A_%a.err
#SBATCH --output=arrayJob_%A_%a.out 
#SBATCH --mail-type=ALL ## BEGIN, END, FAIL or ALL
#SBATCH --mail-user=cody.fitzgerald@northwestern.edu

module purge all

module load DAHSI 
#commenting out python compile.py
#python compile.py

python main_loop.py ${SLURM_ARRAY_TASK_ID}
