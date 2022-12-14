
<!-- README.md is generated from README.Rmd. Please edit that file -->

# crosshap

<!-- badges: start -->
<!-- badges: end -->

LD-based local haplotype analysis and visualization tool

## What does it do?

Given a genomic variant data for a region of interest, crosshap performs
LD-based local haplotyping. Tightly linked variants are clustered into
Marker Groups (MGs), and individuals are grouped into local haplotypes
by shared allelic combinations of MGs. Following this, crosshap provides
a range of visualization options to examine relevant characteristics of
the linked Marker Groups and local haplotypes.

## Why would I use it?

crosshap was originally designed to explore local haplotype patterns
that may underlie phenotypic variability in quantitative trait locus
(QTL) regions. It is ideally suited to complement and follow-up GWAS
results (takes same inputs). crosshap equips users with the tools to
explain why a region reported a GWAS hit, what variants are causal
candidates, what populations are they present/absent in, and what the
features are of those populations.

Alternatively, crosshap can simply be a tool to identify patterns of
linkage among local variants, and to classify individuals based on
shared haplotypes.

Note: crosshap is designed for in-depth, user-driven analysis of
inheritance patterns in specific regions of interest, not genome-wide
scans.

![alt
text](https://github.com/JacobIMarsh/crosshap/blob/main/images/crosshap_jpg.jpg?raw=true)

## Installation

You can install the development version of crosshap from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("JacobIMarsh/crosshap")
```

## Usage

In short, a typical crosshap analysis workflow involves the following
steps. For a detailed explanation and walk through, see
`Getting_started.Rmd` (coming soon!).

0.  Read in raw inputs

``` r
read_vcf(region.vcf)
read_LD(plink.ld)
read_metadata(metadata.txt)
read_pheno(pheno.txt)
```

1.  Run local haplotyping at a range of epsilon values

``` r
run_haplotyping(vcf, LD, metadata, pheno)
```

2.  Build clustering tree to optimize epsilon value

``` r
run_clustree(pheno)
```

3.  Visualize local haplotypes and Marker Groups

``` r
crosshap_viz(HapObject)
```

From here you can examine haplotype and Marker Group features from the
visualization, and export relevant information from the haplotype
object.

``` r
HapObject$Indfile
HapObject$Varfile
HapObject$Hapfile
```

## Contact

For technical queries feel free to contact me:
<jacob.marsh@research.uwa.edu.au>. Please contact Prof.??David Edwards
for all other queries: <dave.edwards@uwa.edu.au> .
