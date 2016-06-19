## Asssign initial working vector
edstats1 <- edstats

## Identify the initial number of rows at EDSTATS
InitialNumofRowsEDSTATS <- dim(edstats1)[1]

## Assign names to columns according to content of row 1
names(edstats1) <- gsub(" ", "_", edstats1[1,])

## Eliminate the first row because it corresponds to column names
edstats2 <- edstats1[2:InitialNumofRowsEDSTATS,]

## Eliminate rows with missing countryCode or Income_Group
Missing_values <- (is.na(edstats2$CountryCode)) | (edstats2$CountryCode == "") | (is.na(edstats2$Income_Group)) | (edstats2$Income_Group == "")
edstats3 <- edstats2[!Missing_values,]

## Identify the final number of rows at EDSTATS
FinalNumofRowsEDSTATS <- dim(edstats3)[1]

## The number of eliminated rows is 235 - 210 = 25