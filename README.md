# Cluster (Computing) Batch Scripts

Batch scripts for cluster computing tasks. CSC Taito (discontinued), CSC Puhti. Each subdirectory for a specific cluster computing project, with READMe specifying the environment.

CSC uses SLURM _(Simple Linux Utility for Resource Management)_ to run batch scripts. [Their instructions are here.](https://research.csc.fi/taito-using-slurm-commands-to-execute-batch-jobs)

## CSC Documentation

[Taito Modules 2.1 - Basic usage](https://research.csc.fi/taito-modules-basic-usage#2.1.1)
[More recent CSC docs - Array jobs](https://docs.csc.fi/computing/running/array-jobs/)

### Running batch jobs

[CSC Instructions ...](https://research.csc.fi/taito-using-slurm-commands-to-execute-batch-jobs)

To run the [ESTC publishers batch](./estc-publishers) for example:

```console
$ sbatch estc_publishers.sh
```

Pulling latest repo data is included in that one.

### Passing variables to SLURM scripts

https://stackoverflow.com/questions/55867700/how-to-pass-an-argument-in-the-sbatch-command-line

#### Seems you can't use those values in the SBATCH -lines at the start of the script (job name, logs, etc ...):

https://help.rc.ufl.edu/doc/Using_Variables_in_SLURM_Jobs
