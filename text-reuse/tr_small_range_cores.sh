# takes three parameters
# -c [number of cores to use]
# -s [first iteration]
# -e [last iteration]

usage()
{
    echo "usage: tr_small_range_cores [-f cores] [-s start] [-e end]"
}

cores=10000
start=10000
end=10000
error=0

while [ "$1" != "" ]; do
    case $1 in
        -c | --cores )          shift
                                cores=$1
                                ;;
        -s | --start )          shift
                                start=$1
                                ;;
        -e | --end )            shift
                                end=$1
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
if [ $start -eq 10000 ]
then
    echo "Set start (-s | --start) value."
    error=1
fi
if [ $end -eq 10000 ]
then
    echo "Set end (-e | --end) value."
    error=1
fi
if [ $error -eq 1 ]
then
    exit 1
fi

echo "tr small i$start-$end cores: $cores"
sbatch --job-name=tr_i$start-$end --output=logs/tr_i$start-$end.out --error=logs/err/tr_i$start-$end.err --cpus-per-task=$cores text_reuse_blast_batches_main_small_range_cores.sh $start $end $cores
