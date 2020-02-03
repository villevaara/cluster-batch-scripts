# README

## Environment:

CSC Puhti.

## Scripts:

* **install_blast.sh** - Compile modified version of BLAST on CSC Puhti.
* **text_reuse_data_preparer.sh** - Prepares BLAST database from database -ready data (specific tar.gz compressed JSON format). Needs to be run before the _blast_batches_ -scripts. 
* **text_reuse_blast_batches_main[?].sh** - Blast is run in batches. These run specific iterations of those batches.
* **text_reuse_interactive.sh** - asks for interactive shell for testing / debugging. Reasonable resources for this, probably.

## General notes:

* on Puhti, if the data is copied to the local node's fast storage the process speed up significantly. Ofherwise disk i/o forms a bottleneck and adding cores has no real effect.
* Efficiency vs number of cores used scales in a linear fashion. The same job costs roughly the same with eg. 40 or 10 cores, with the 10 core job taking four times as long to complete and ending up using the same amount of credits. If memory use was a more significant factor the higher core count would be cheaper.
* 12G of memory seems to be sufficient, based on observations of actual memory use with `top`.

## Finding database size (from avjves instructions):
```
cd output_folder ##output_folder is the name given when running data_preparer etc.
cd db
blastp -db textdb
```

## Current version DB size

29.1.2020 DB size was 1,302,141 texts.
text_count=1302141
qpi 1000
1303 queries
index of last query=1302 (starts with 0)

## Steps

1. prepare database with `text_reuse_data_preparer.sh`
2. run `text_reuse_blast_batches[...].sh` for each iteration.
   * Number of iterations needed to run is number of items in DB / qpi (queries per iteration) rounded up.
   * qpi 1000 seems to work fine with large DB.

## Submitted jobs

| iter | CPU | CPU% | MEM | MEM% |
| ---- | --- | ---- | --- | ---- |
| 0    | 40  |      | 15  |      |
| 1    | 40  |      | 15  |      |
| 600  | 40  |      | 15  |      |

## Completed jobs

| iter | CPU | CPU% | MEM | MEM% |
| ---- | --- | ---- | --- | ---- |
|      |     |      |     |      |
