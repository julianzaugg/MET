#!/bin/bash
#
#SBATCH --time=24:00:00
#SBATCH --job-name=Saliva2_MET
#SBATCH --output=./logs/Saliva2_MET.out
#SBATCH --error=./logs/Saliva2_MET.error
#SBATCH --account=a_ace
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

##SBATCH --tasks-per-node=1

module load nextflow/23.04.2

# Directory containing the nextflow.config file and the main.nf script
BASE_DIR=/scratch/project/imos_mgd/julian/GIH_adaptive_sequencing/test_pipeline_final
cd $BASE_DIR
DATA_DIR=/scratch/project/imos_mgd/julian/GIH_adaptive_sequencing/data
SAMPLESHEET=$DATA_DIR/pipeline_samplesheets/saliva_2.csv
OUT_DIR=/scratch/project/imos_mgd/julian/GIH_adaptive_sequencing/pipeline_out/saliva_2_SR

# read_types_retain can be "stop_receiving" or "stop_receiving__no_decision"
nextflow run main.nf \
-c nextflow.config \
--outdir ${OUT_DIR} \
--samplesheet $SAMPLESHEET \
--skip_download_centrifuge_db \
--skip_download_genomad_db \
--read_types_retain stop_receiving \
-resume

