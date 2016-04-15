## The Ladies Group Project Step 5 
####Comparsion of time points 12 and 18 in each replicate population and Comparison of Mean Allele Frequencies over all time points in each replicate population


###Goals
#####The overall goal of this project was to identify regions of the yeast genome with substantial genetic change over time. Because we were given the last time points, we collected data from other groups with earlier time points to show change in allele frequencies over the entire experiment.

####Sample IDs used in analysis
    YEE_0112_03_02_12
    YEE_0112_03_02_18
    YEE_0112_03_03_12
    YEE_0112_03_03_18
    YEE_0112_03_05_12
    YEE_0112_03_05_18
    YEE_0112_03_07_12
    YEE_0112_03_07_18
    YEE_0112_03_10_12
    YEE_0112_03_10_18

[Source Paper](http://www.ncbi.nlm.nih.gov/pubmed/25172959)

####Stats stuff from Keah? If we can ever figure out how to interpret the output of the stats program.

###Workflow

##### Data Extraction Using vcftools
###To understand the allele frequency difference between the time points 12 and 18 we extracted the time points form each generation 
using vcf tools and placed the subsets into new vcf files. In this example we extracted all generations at time point 18 and used 
the recode option to place the output into another vcf file.

        vcftools --gzvcf Combined.Q30.recode.vcf.gz --indv
        "YEE\_0112\_03\_02\_18"  "YEE\_0112\_03\_03\_18" --indv
        "YEE\_0112\_03\_05\_18"  "YEE\_0112\_03\_07\_18" --indv
        "YEE\_0112\_03\_10\_18" --recode --recode-INFO-all --out ra.g18

###We later determined we needed to extract each generation and time point to a seperate file. However, these vcf files were utilized 
in determinig the depth in teh code below.

        vcftools --vcf ra.g18.recode.vcf --depth --out ra.g18

###The vcf files were also utilized to produce stats files using vcf-stats. Prior to this, the files were compressed usinf bgzip and
indexed using tabix.

        bgzip ra.recode.vcf
        tabix -p vcf ra.g18.recode.vcf.gz
        vcf-stats ra.g18.recode.vcf.gz >> ra.g18.stats.txt

###In order to compare the allele frequency, we utilized vcf-compare. Samples were extracted utilizing the freq ooption and then compared
as you can see in this example.

        vcftools --gzvcf Combined.Q30.recode.vcf.gz --indv
        "YEE\_0112\_03\_02\_18" --indv  "YEE\_0112\_03\_03\_18" --indv
        "YEE\_0112\_03\_05\_18" --indv  "YEE\_0112\_03\_07\_18" --indv
        "YEE\_0112\_03\_10\_18" --freq --out ra.g18
        
###Samples were extracted again using the vcftool option freq that gives us an output file shouwing the number and areas of allele frequency.
Here is an example of this code option:

        vcftools --gzvcf Combined.Q30.recode.vcf.gz --indv
        "YEE\_0112\_03\_02\_18" --freq --out r1.g18

###Even though frequency was able to be determined, the format of the .frq file did not allow to add teh thrue events of allele frequency. 
We were only able to count the amounts of alleles in thta region. These values were teh same for both generations, however the number of 
allel events were not the same bwetween teh two timepoints. Due to this, we were given a file in order to determine these counts and 
produce subsequent plots.

###R and Manhattan Plots

#Rep 1
        library(qqman)
        GWAS <- read.csv("ladies.csv")

#change factor to char.
        GWAS$CHR_ID <- as.character(GWAS$CHR_ID)

#replace chrM with 17
        #GWAS[GWAS$CHR_ID=="chrM","CHR_ID"] <- "17"

#char. to number
        GWAS$CHR_ID <- as.numeric(GWAS$CHR_ID)

#plot group project allele frequencies
        manhattan(GWAS, chr="CHR_ID", bp="CHR_POS", p="REP1_FINAL", snp="SNP_ID_CURRENT", ylim=c(0, 1.2), logp=FALSE, ylab="change of allele frequency", genomewideline = FALSE, suggestiveline = FALSE, chrlabs=c(1:16, "chrM"), col =c(1:16, "red", "blues9"))

        png("rep2_manhattan.png", height=400, width=1000)
        manhattan(GWAS, chr="CHR_ID", bp="CHR_POS", p="REP1_FINAL", snp="SNP_ID_CURRENT", ylim=c(0, 1.2), logp=FALSE, ylab="change of allele frequency", genomewideline = FALSE, suggestiveline = FALSE, chrlabs=c(1:16, "chrM"), col =c(1:16, "red", "blues9"))
        abline(h=c(0.559), col="blue")
        dev.off()


Time Series stuff from Jessie 

Example Outputs???

####Group Member Contributions:
      Keah was responsible for extracting data and statictical calculations
      Jessie was responsible for time series plot and coordinating with other groups  
      Sayma was responsible for generating Manhattan plots for each replicate
      Jennifer was responsible for troubleshooting R codes and repository building in Github
