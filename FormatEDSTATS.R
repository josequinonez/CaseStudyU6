## Asssign initial working vector
edstats1 <- edstats

## Assign names to columns according to content of row 1
names(edstats1) <- gsub(" ", "_", edstats1[1,])

## Eliminate the first row because it corresponds to column names
edstats2 <- edstats1[2:235,]
