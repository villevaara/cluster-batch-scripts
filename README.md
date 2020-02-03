# Cluster (Computing) Batch Scripts

Batch scripts for cluster computing tasks. CSC Taito (discontinued), CSC Puhti. Each subdirectory for a specific cluster computing project, with READMe specifying the environment.

CSC uses SLURM _(Simple Linux Utility for Resource Management)_ to run batch scripts. [Their instructions are here.](https://research.csc.fi/taito-using-slurm-commands-to-execute-batch-jobs)

## CSC Documentation

[Taito Modules 2.1 - Basic usage](https://research.csc.fi/taito-modules-basic-usage#2.1.1)

### Running batch jobs

[CSC Instructions ...](https://research.csc.fi/taito-using-slurm-commands-to-execute-batch-jobs)

To run the [ESTC publishers batch](./estc-publishers) for example:

```console
$ sbatch estc_publishers.sh
```

Pulling latest repo data is included in that one.
