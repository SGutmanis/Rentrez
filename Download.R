ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1") #create a vector with the the IDs of 3 different sequences from the 16s gene of Borreliella burgdorferi
library(rentrez)  # call the rentrez package
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") #retrieve specified fasta files from NCBI

#split the vector into 3 strings
Sequences<-strsplit(Bburg, split = "\n\n")
print(Sequences)
Sequences<-unlist(Sequences)

#Next, use regular expressions to separate the sequences from the headers
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)

Sequences$Name <- gsub(">", "", Sequences$Name) # remove newline characters

write.csv(Sequences,"Sequences.csv", row.names = F)
