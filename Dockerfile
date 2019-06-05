# Start with ubuntu base image
FROM ubuntu:18.04

MAINTAINER Jigar Patel (jpatel@ucsd.edu)

################################# VERSIONS #################################
# If you need a different version of the tool, change it below.
ARG samtool_version=1.9
ARG bedtools_version=2.27.1
ARG bwa_version=0.7.17
ARG bamutil_version=1.0.14
ARG fastqc_version=0.11.8
ARG varscan_version=2.4.3
ARG snpeff_version=4.3.1
ARG picard_version=2.20.2
############################################################################


# Install the apt and its dependenciees
RUN apt-get update && apt-get install -y vim curl wget make build-essential

# Changes the working directory
WORKDIR /tmp
# Downloads the Anaconda 2018.12 with Python 3.7
RUN curl -O https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh
RUN sh Anaconda3-2018.12-Linux-x86_64.sh -b

# Exports the path of anaconda
ENV PATH="/root/anaconda3/bin:${PATH}"

# Installs the common bioinformatics tools
RUN conda install -c bioconda samtools=$samtools_version \
        bedtools=$bedtools_version \
        bwa=$bwa_version \
        bamutil=$bamutil_version \
        fastqc=$fastqc_version \
        snpeff=$snpeff_version \
        picard=$picard_version \
        varscan=$varscan_version -y

WORKDIR /home/smedix
# Downloads the hg19 reference genome and saves it at /hg19 as hg19.fa
RUN mkdir /hg19
RUN wget --timestamping 'ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/*'
RUN ls
RUN gzip -d *.gz
RUN cat chr*.fa > /hg19/hg19.fa
