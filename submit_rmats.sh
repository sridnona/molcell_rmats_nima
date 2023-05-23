#!/bin/bash
set -o nounset
set -o pipefail
group=$1
out=$2
MT=$3
WT=$4
libtype=$5
readlen=$6

gtf=/storage1/fs1/bga/Active/gmsroot/gc2560/core/GRC-human-build38_human_95_38_U2AF1_fix/rna_seq_annotation/Homo_sapiens.GRCh38.95.gtf
bsub -G compute-timley -q timley -g /sridnona \
-J ${group}-turbo -n 10 \
-R"select[mem>64000] rusage[mem=64000] span[hosts=1]" \
-M 64000000 -oo ${group}.out -eo ${group}.err \
-a "docker(sridnona/rmats_turbo_4.1.0:v2)" /bin/bash -c \
"/usr/bin/rmats.py \
--b1 ${MT} \
--b2 ${WT} \
--gtf ${gtf} \
--od ${out}/${group} \
--tmp ${out}/${group} \
-t paired \
--libType ${libtype} \
--readLength ${readlen} \
--variable-read-length \
--nthread 10 \
--tstat 10"
