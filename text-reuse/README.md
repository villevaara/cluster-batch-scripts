# README

Some general observations:
* on Puhti, if the data is copied to the local node's fast storage the process speed up significantly. Ofherwise disk i/o forms a bottleneck and adding cores has no real effect.
* Efficiency vs number of cores used scales in a linear fashion. The same job costs roughly the same with eg. 40 or 10 cores, with the 10 core job taking four times as long to complete and ending up using the same amount of credits. If memory use was a more significant factor the higher core count would be cheaper.
* 12G of memory seems to be sufficient, based on observations of actual memory use with `top`.

## Time use estimate


