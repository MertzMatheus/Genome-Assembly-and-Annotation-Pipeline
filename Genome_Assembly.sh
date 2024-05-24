#!/bin/bash

# Genome Assembly and Annotation Pipeline

## Set input and output directories
INPUT_DIR="path/to/input/directory"
OUTPUT_DIR="path/to/output/directory"

## Create output directories
mkdir -p $OUTPUT_DIR/trimmed
mkdir -p $OUTPUT_DIR/assembly
mkdir -p $OUTPUT_DIR/annotation

## Quality Control
echo "Running FastQC for quality control..."
fastqc -o $OUTPUT_DIR/trimmed $INPUT_DIR/*.fastq.gz

## Trimming
echo "Trimming sequences using Trimmomatic..."
java -jar /path/to/Trimmomatic-0.39/trimmomatic.jar PE \
     -threads 4 \
     $INPUT_DIR/*_R1_*.fastq.gz $INPUT_DIR/*_R2_*.fastq.gz \
     $OUTPUT_DIR/trimmed/*_R1_trimmed.fastq.gz $OUTPUT_DIR/trimmed/*_R1_unpaired.fastq.gz \
     $OUTPUT_DIR/trimmed/*_R2_trimmed.fastq.gz $OUTPUT_DIR/trimmed/*_R2_unpaired.fastq.gz \
     ILLUMINACLIP:/path/to/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

## Genome Assembly
echo "Performing genome assembly using SPAdes..."
spades.py -o $OUTPUT_DIR/assembly \
         -1 $OUTPUT_DIR/trimmed/*_R1_trimmed.fastq.gz \
         -2 $OUTPUT_DIR/trimmed/*_R2_trimmed.fastq.gz \
         --threads 8 \
         --memory 32

## Genome Annotation
echo "Annotating assembled genomes using Prokka..."
prokka --outdir $OUTPUT_DIR/annotation \
       --prefix sample \
       --threads 4 \
       $OUTPUT_DIR/assembly/contigs.fasta

## 16S rRNA Analysis
echo "Performing 16S rRNA analysis using BLAST..."
blastn -query $OUTPUT_DIR/assembly/contigs.fasta \
      -db /path/to/16S_rRNA_database \
      -out $OUTPUT_DIR/annotation/16S_rRNA_results.txt \
      -num_threads 4 \
      -max_target_seqs 10 \
      -outfmt 6

echo "Pipeline completed. Results are available in the output directory." 
