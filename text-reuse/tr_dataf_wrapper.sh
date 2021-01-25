echo "Array: $1"
sbatch --array=$1 tr_data_finalizer_puhti_wrapped.sh
