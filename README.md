## The Ladies Group Project Step 5 
On Wednesdays, We Write Programs To Perform Genetic Analysis

#### For this portion of our group project, we wanted to make a comparsion between populations of a super cool organism at multiple time points. Which organism? Its yeast, duh! We looked at the last two time points in the data set, the populations at time points 12 and 18. We were specifically interested in comparing the Mean Allele Frequencies over all time points in each replicate population, using both our dataset and other datasets provided for us by other groups. (Its yeast, duh! goes in here somewhere)


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

Thanks to the authors for providing the data sets (found in [this] paper)(http://www.ncbi.nlm.nih.gov/pubmed/25172959) for us to analyze. Four for you Burke et al.

###Workflow
Get in losers, we going coding. Here is a break down of the codes we used to process our data and produce graphs.

#### Data Extraction Using vcftools
#####To understand the allele frequency difference between the time points 12 and 18 we extracted the time points form each generation using vcf tools and placed the subsets into new vcf files. 

#####Extract all generations at time point 18 and use the recode option to place the output into another vcf file.

        vcftools --gzvcf Combined.Q30.recode.vcf.gz --indv
        "YEE\_0112\_03\_02\_18"  "YEE\_0112\_03\_03\_18" --indv
        "YEE\_0112\_03\_05\_18"  "YEE\_0112\_03\_07\_18" --indv
        "YEE\_0112\_03\_10\_18" --recode --recode-INFO-all --out ra.g18

#####Determining the depth in the code below.

        vcftools --vcf ra.g18.recode.vcf --depth --out ra.g18

#####Produce stats files using vcf-stats. Prior to this, the files were compressed usinf bgzip and indexed using tabix.

        bgzip ra.recode.vcf
        tabix -p vcf ra.g18.recode.vcf.gz
        vcf-stats ra.g18.recode.vcf.gz >> ra.g18.stats.txt

#####Compare the allele frequency using vcf-compare. Samples were extracted with the freq option.

        vcftools --gzvcf Combined.Q30.recode.vcf.gz --indv
        "YEE\_0112\_03\_02\_18" --indv  "YEE\_0112\_03\_03\_18" --indv
        "YEE\_0112\_03\_05\_18" --indv  "YEE\_0112\_03\_07\_18" --indv
        "YEE\_0112\_03\_10\_18" --freq --out ra.g18
        
#####Extract samples again to gives an output file showing the number and areas of allele frequency.

        vcftools --gzvcf Combined.Q30.recode.vcf.gz --indv
        "YEE\_0112\_03\_02\_18" --freq --out r1.g18

#####Unfortunately at this point, we discovered that, like Fetch, further analysis of the data was not happening. The format of the .frq file did not allow us to see the true events of allele frequency. We were only able to count the amounts of alleles in the different regions. These values were the same for both generations. However, the number of allele events were not the same between the two timepoints. We were eventually given a new file with the right data to determine these counts and produce subsequent plots. 

####R and Manhattan Plots

#####To produce Manhattan plots to faciliate comparisons between the different time points, we moved from the command line into the statistical program R. We added the qqman package, as well as the qqman library to create these plots.

#####First, we needed to read our data into R. We converted our output files into the .csv format and added them to R. Then we assigned our data to the variable GWAS.
        library(qqman)
        GWAS <- read.csv("ladies.csv")

#####Now, we need to tell R which part of the data we want to use eventually
   
        GWAS$CHR_ID <- as.character(GWAS$CHR_ID)

#####Change Chromosome M to Chromosome 17 for consistency with labelling scheme
        #GWAS[GWAS$CHR_ID=="chrM","CHR_ID"] <- "17"

#####Have Chromosome ID displayed as numeric values
        GWAS$CHR_ID <- as.numeric(GWAS$CHR_ID)

#####Now that the data processing is done, we can tell R to make our Manhattan plots
        manhattan(GWAS, chr="CHR_ID", bp="CHR_POS", p="REP1_FINAL", snp="SNP_ID_CURRENT", ylim=c(0, 1.2), logp=FALSE, ylab="change of allele frequency", genomewideline = FALSE, suggestiveline = FALSE, chrlabs=c(1:16, "chrM"), col =c(1:16, "red", "blues9"))

#####Print the output file in png format so it doesn't have to load every time we want to view it and add a cutoff line to the graphs
        png("rep2_manhattan.png", height=400, width=1000)
        manhattan(GWAS, chr="CHR_ID", bp="CHR_POS", p="REP1_FINAL", snp="SNP_ID_CURRENT", ylim=c(0, 1.2), logp=FALSE, ylab="change of allele frequency", genomewideline = FALSE, suggestiveline = FALSE, chrlabs=c(1:16, "chrM"), col =c(1:16, "red", "blues9"))
        abline(h=c(0.559), col="blue")
        dev.off()


Time Series stuff from Jessie 


###Collaborations with Other Groups
#####Portions of this project had our group sharing data and working with other groups. Below is the code we used to prepare the data to share with other groups.

       > newdata1 <- subset(DUDE, DUDE$REP1_FINAL>0.559, 
        +                   select=c(CHR_ID, CHR_POS, ALT))
        > newdata1 <- subset(DUDE, DUDE$REP1_FINAL>0.559, 
        +                   select=c(CHR_ID, CHR_POS, REF, ALT))
        > newdata2 <- subset(DUDE, DUDE$REP2_FINAL>0.805, 
        +                   select=c(CHR_ID, CHR_POS, REF, ALT))
        > newdata3 <- subset(DUDE, DUDE$REP3_FINAL>0.350, 
        +                   select=c(CHR_ID, CHR_POS, REF, ALT))
        > newdata5 <- subset(DUDE, DUDE$REP5_FINAL>0.303, 
        +                   select=c(CHR_ID, CHR_POS, REF, ALT))
        > newdata7 <- subset(DUDE, DUDE$REP7_FINAL>0.253, 
        +                   select=c(CHR_ID, CHR_POS, REF, ALT))

####Group Member Contributions:
      Keah was responsible for extracting data and statictical calculations
      Jessie was responsible for time series plot and coordinating with other groups  
      Sayma was responsible for generating Manhattan plots for each replicate
      Jennifer was responsible for troubleshooting R codes and repository building in Github


