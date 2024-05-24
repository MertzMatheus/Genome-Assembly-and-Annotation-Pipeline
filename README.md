Got it, here's the updated README.md file with the additional information:

# Genome Assembly and Annotation Pipeline

## Project Description
This bioinformatics pipeline aims to perform genome assembly and annotation of genomic sequences from DNA sequencing data. The pipeline includes the following main steps:

1. **Quality Control**: Utilization of FastQC to evaluate the quality of DNA sequences.
2. **Trimming**: Use of Trimmomatic to remove Illumina adapters and perform quality-based trimming of low-quality bases.
3. **Genome Assembly**: Employing SPAdes for genome assembly from the trimmed DNA sequences.
4. **Annotation**: Utilization of Prokka for functional annotation of the assembled genomes.
5. **16S rRNA Analysis**: Performing a BLAST search against a 16S rRNA sequence database for taxonomic identification.

## Prerequisites
To run this pipeline, you will need the following packages/programs installed on your system:

- FastQC (version 0.11.8 or higher)
- Trimmomatic (version 0.39 or higher)
- SPAdes (version 3.15.0 or higher)
- Prokka (version 1.14.6 or higher)
- BLAST+ (version 2.10.0 or higher)
- Python 3 (version 3.7 or higher)
- Java Runtime Environment (version 8 or higher)

Ensure that all these packages are installed and configured correctly in your working environment.

## Usage Instructions
1. Clone this repository to your working directory:
```
git clone https://github.com/your-username/genome-assembly-pipeline.git
```

2. Navigate to the project directory:
```
cd genome-assembly-pipeline
```

3. Edit the `genome_assembly_pipeline.sh` file and update the following parameters:
   - `INPUT_DIR`: Set the directory containing the input FASTQ files.
   - `OUTPUT_DIR`: Set the directory where the results will be saved.
   - Verify and update the paths to the programs, if necessary.

4. Make the script executable:
```
chmod +x genome_assembly_pipeline.sh
```

5. Run the pipeline:
```
./genome_assembly_pipeline.sh
```

The pipeline will execute the steps of quality control, trimming, genome assembly, annotation, and 16S rRNA analysis. The results will be stored in the `trimmed`, `assembly`, and `annotation` directories within the `OUTPUT_DIR`.

## Trimming Adapters
The trimming step in this pipeline uses Trimmomatic to remove Illumina adapters from the input sequences. If you have data from other sequencing platforms, such as PacBio or Nanopore, you can modify the adapter trimming step accordingly.

For PacBio adapters, you can use the following Trimmomatic command:
```
ILLUMINACLIP:/path/to/PacBio_adapters.fa:2:30:10
```

For Nanopore adapters, you can use the following Trimmomatic command:
```
ILLUMINACLIP:/path/to/Nanopore_adapters.fa:2:30:10
```

## SPAdes and Prokka Options
The pipeline uses the default settings for SPAdes and Prokka. If you would like to customize the parameters, you can modify the corresponding commands in the `genome_assembly_pipeline.sh` script.

For example, you can adjust the SPAdes parameters to use different assembly algorithms or enable additional features:
```
spades.py -o $OUTPUT_DIR/assembly \
         -1 $OUTPUT_DIR/trimmed/*_R1_trimmed.fastq.gz \
         -2 $OUTPUT_DIR/trimmed/*_R2_trimmed.fastq.gz \
         --careful \
         --cov-cutoff auto \
         --threads 8 \
         --memory 32
```

Similarly, you can modify the Prokka parameters to include additional annotation features or change the output format:
```
prokka --outdir $OUTPUT_DIR/annotation \
       --prefix sample \
       --kingdom Bacteria \
       --locustag SAMPLE \
       --threads 4 \
       $OUTPUT_DIR/assembly/contigs.fasta
```

## Credits and License
This pipeline was developed by [Your Name] and is made available under the [License Type, e.g 
## Credits and License
This pipeline was developed by Matheus Mertz  and is made available under the [License Type, e.g., MIT License].

Acknowledgments to the following tools and libraries used:
- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)
- [SPAdes](https://cab.spbu.ru/software/spades/)
- [Prokka](https://github.com/tseemann/prokka)
- [BLAST+](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download)

If you have any questions or suggestions, feel free to contact me or open an issue in this repository. 
