# takes one parameter
# 1$ batch number
# takes three parameters
# -c [number of cores to use]
# -i [iteration]

usage()
{
    echo "usage: tr_longrun_single_cores [-f cores] [-i iter]"
}

cores=10000
iter=10000
error=0

while [ "$1" != "" ]; do
    case $1 in
        -c | --cores )          shift
                                cores=$1
                                ;;
        -i | --iter )           shift
                                iter=$1
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ $cores -eq 10000 ]
then
    echo "Set cores (-c | --cores) to value between 1-40."
    error=1
fi
if [ $iter -eq 10000 ]
then
    echo "Set iter (-i | --iter) value."
    error=1
fi
if [ $error -eq 1 ]
then
    exit 1
fi

echo "tr longrun i$iter cores: $cores"
sbatch --job-name=tr_i$iter --output=logs/tr_i$iter_%j.out --error=logs/err/tr_i$iter_%j.err --cpus-per-task=$cores text_reuse_blast_batches_main_longrun_single_cores.sh $iter $cores
