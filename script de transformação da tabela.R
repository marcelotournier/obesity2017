setwd("C:/R/obeso")
# Para o pacote tabulizer funcionar, é necessário instalar o jdk
library(tabulizer)
library(dplyr)
library(reshape)

# TABELA 1 - "t1.pdf"

#extrair tabela do pdf
out <- extract_tables("t1.pdf")
final <- do.call(rbind, out)

# PADRONIZAR NOMES DE PAÍSES PARA O WORLD BANK

# corrigir nomes dos países
final[23,1]= "Bosnia and Herzegovina"
final[34,1]="Central African Republic"
final[51,1] = "Egypt, Arab Rep."
final[131,1] = "St. Vincent and the Grenadines"


# tirar as duas primeiras colunas da tabela
final2 <- as.data.frame(final[-c(1:2),])

# colocar os nomes no Data frame


names(final2) <-c("Country","2014","2025","2014","2025")


# limpar os dados
f2 <- final2[,c(1,2)]
f3 <- final2[,c(1,3)]
f4 <- final2[,c(1,4)]
f5 <- final2[,c(1,5)]

fin2 <- melt(f2, id=1)
fin3 <- melt(f3, id=1)
fin4 <- melt(f4, id=1)
fin5 <- melt(f5, id=1)

#colocar a coluna de ano nas tabelas fin2 a fin5

fin2$Year <- 2014
fin3$Year <- 2025
fin4$Year <- 2014
fin5$Year <- 2025

fin2$variable <- "Estimated prevalence of obesity (% of all adults)"
fin3$variable <- "Estimated prevalence of obesity (% of all adults)"
fin4$variable <- "Number of adults (thousands) with obesity BMI 30+"
fin5$variable <- "Cost (US$ Millions) to reduce number of adults with obesity by 1%"

# juntar tudo em um data frame

obeso1 <- rbind(fin2,fin3,fin4,fin5)

# TABELA 2 - "t2.pdf"
#extrair tabela do pdf

out2 <- extract_tables("t2.pdf")
bfinal <- do.call(rbind, out2)

# PADRONIZAR NOMES DE PAÍSES PARA O WORLD BANK

# Corrigir nomes de países na tabela

bfinal[1,1] = "Country"
bfinal[7,1] = "Antigua and Barbuda"
bfinal[13,1] = "Bahamas, The"
bfinal[22,1] = "Bolivia"
bfinal[23,1] = "Bosnia and Herzegovina"
bfinal[30,1] = "Cabo Verde"
bfinal[34,1] = "Central African Repuplic"
bfinal[40,1] = "Congo, Rep."
bfinal[42,1] = "Cote d'Ivoire"
bfinal[51,1] = "Egypt, Arab Rep."
bfinal[60,1] = "Gambia, The"
bfinal[87,1] = "Kyrgyz Republic"
bfinal[88,1] = "Lao PDR"
bfinal[104,1] = "Micronesia, Fed. Sts."
bfinal[130,1] = "St. Lucia"
bfinal[131,1]= "St. Vincent and the Grenadines"
bfinal[133,1]= "Sao Tome and Principe"
bfinal[164,1]="United Arab Emirates"
bfinal[166,1]="United States"
bfinal[171,1]="Yemen, Rep."
bfinal[174,1] = "World"

# tirar as duas primeiras colunas da tabela

bfinal2 <- as.data.frame(bfinal)

names(bfinal2) <- bfinal[1,]

bfinal2 <- bfinal2[-1,][-1,]

obeso2 <- melt(bfinal2,id = "Country", variable_name = "Year")

obeso2[,4]="Healthcare cost of consequences of high BMI (US$ Million - purchasing power parity)"

# mudar ordem das colunas para igualar ao Data frame obeso1

obeso2 <- obeso2[c(1,4,3,2)]

# mudar nome das colunas para igualar ao Data frame obeso1

names(obeso2) <- c("Country","variable","value","Year")

# TABELA 3 - "t5.pdf"
#extrair tabela do pdf

out3 <- extract_tables("t5.pdf")

cfinal <- rbind(out3[[1]],out3[[2]],out3[[3]],out3[[4]])

# tabela possui incoerencias na ultima pagina (objeto "cfinal2"), que precisa ser corrigiga...

cfinal2 <- rbind(out3[[5]])

cfinal2[11,9] <- cfinal2[11,8]

cfinal2 <- cfinal2[,-c(2,8,11)]

cfinal2[8,2:13] <- cfinal2[11,2:13]

cfinal2[8,1]="World"

# juntar pagina 5 com as demais páginas

cfinalf <- rbind(cfinal, cfinal2)

# PADRONIZAR NOMES DE PAÍSES PARA O WORLD BANK


cfinalf[1,1]="Country"
cfinalf[12,1]="Bahamas, The"
cfinalf[29,1]="Cabo Verde"
cfinalf[39,1]="Congo, Rep."
cfinalf[41,1]="Cote d'Ivoire"
cfinalf[46,1]="Congo, Dem. Rep."
cfinalf[51,1]="Egypt, Arab Rep."
cfinalf[61,1]="Gambia, The"
cfinalf[77,1]="Iran, Islamic Rep."
cfinalf[89,1]="Kyrgyz Republic"
cfinalf[98,1]="Macedonia, FYR"
cfinalf[108,1]="Micronesia, Fed. Sts."
cfinalf[136,1]="St. Lucia"
cfinalf[137,1]="St. Vincent and the Grenadines"
cfinalf[173,1]="United States"
cfinalf[177,1]="Venezuela, RB"
cfinalf[179,1]="Yemen, Rep."

cfinalf <- as.data.frame(cfinalf[2:182,])

names(cfinalf) <- c("Country","2014","2014","2014","2014","2014","2014","2025","2025","2025","2025","2025","2025")


# Preparar as subtabelas para o bind...

cf1 <- c("","Total Adult Population (thousands)", "Adult population - not overweight (thousands)", "Adult population - BMI 25-30 (thousands)","Adult population - BMI 30-35 (thousands)","Adult population - BMI 35-40 (thousands)","Adult population - BMI > 40 (thousands)","Total Adult Population (thousands)", "Adult population - not overweight (thousands)", "Adult population - BMI 25-30 (thousands)","Adult population - BMI 30-35 (thousands)","Adult population - BMI 35-40 (thousands)","Adult population - BMI > 40 (thousands)")

cf2 <- cfinalf[,c(1,2)]
cf3 <- cfinalf[,c(1,3)]
cf4 <- cfinalf[,c(1,4)]
cf5 <- cfinalf[,c(1,5)]
cf6 <- cfinalf[,c(1,6)]
cf7 <- cfinalf[,c(1,7)]
cf8 <- cfinalf[,c(1,8)]
cf9 <- cfinalf[,c(1,9)]
cf10 <- cfinalf[,c(1,10)]
cf11 <- cfinalf[,c(1,11)]
cf12 <- cfinalf[,c(1,12)]
cf13 <- cfinalf[,c(1,13)]

cf2 <- melt(cf2,id = "Country", variable_name = "Year")
cf3 <- melt(cf3,id = "Country", variable_name = "Year")
cf4 <- melt(cf4,id = "Country", variable_name = "Year")
cf5 <- melt(cf5,id = "Country", variable_name = "Year")
cf6 <- melt(cf6,id = "Country", variable_name = "Year")
cf7 <- melt(cf7,id = "Country", variable_name = "Year")
cf8 <- melt(cf8,id = "Country", variable_name = "Year")
cf9 <- melt(cf9,id = "Country", variable_name = "Year")
cf10 <- melt(cf10,id = "Country", variable_name = "Year")
cf11 <- melt(cf11,id = "Country", variable_name = "Year")
cf12 <- melt(cf12,id = "Country", variable_name = "Year")
cf13 <- melt(cf13,id = "Country", variable_name = "Year")

cf2[,4]=cf1[2]
cf3[,4]=cf1[3]
cf4[,4]=cf1[4]
cf5[,4]=cf1[5]
cf6[,4]=cf1[6]
cf7[,4]=cf1[7]
cf8[,4]=cf1[8]
cf9[,4]=cf1[9]
cf10[,4]=cf1[10]
cf11[,4]=cf1[11]
cf12[,4]=cf1[12]
cf13[,4]=cf1[13]

obeso5 <- rbind(cf2,cf3,cf4,cf5,cf6,cf7,cf8,cf9,cf10,cf11,cf12,cf13)

# mudar ordem das colunas para igualar ao Data frame obeso1

obeso5 <- obeso5[c(1,4,3,2)]

# mudar nome das colunas para igualar ao Data frame obeso1

names(obeso5) <- c("Country","variable","value","Year")

# Juntar todas as tabelas e salvar como um arquivo CSV

obesity = rbind(obeso1,obeso2,obeso5)

# Se necessário, substituir os pontos da coluna de "values" por virgulas:
# obesity[,3]=gsub("\\.",",",obesity[,3])

# encontrar strings erradas na coluna "Country"
# which(obeso$Country == "Antigua and Barbud")
# a=which(obeso$Country == "Antigua and Barbud")
# obeso[a,1]="Antigua and Barbuda"

# which(obeso$Country == "All Countries")
# a=which(obeso$Country == "All Countries")
# a=as.data.frame(a)
# obeso[a,1]="World"

# nomes certos: #################3
# Antigua and Barbuda
# World
# Bahamas, The (Bahamas)
# Bolivia (Bolivia Plurinational)
# Bosnia and Herzegovina (Bosnia and Herzegov, Bosnia and Herzegovin)
# Cabo Verde (Cabo Verde Republic, Cabo Verde Republic of)
# Central African Republic (Central African Repu, Central African Republi)
# Congo, Rep. (Congo)
# Congo, Dem. Rep. (Congo, Dem. Rep. , DR Congo)
# Egypt, Arab Rep. (Egypt)
# Macedonia, FYR (FYR Macedonia, Macedonia)
# Gambia, The (Gambia)
# Iran, Islamic Rep. (Iran)
# Kyrgyz Republic (Kyrgyzstan)
# Lao PDR (Lao People's Democ)
# Micronesia, Fed. Sts. (Micronesia (Fed), "(Micronesia (Federat")
# St. Lucia (Saint Lucia)
# St. Vincent and the Grenadines (St. Vincent and th, St. Vincent and the G)
# Sao Tome and Principe (Sao Tome and Princ)
# United Arab Emirates (United Arab Emirate)
# United States (United States of Am, United States of Americ)
# Venezuela, RB (Venezuela)
# Yemen, Rep. (Yemen)


# ajustes finais do Data Frame para exportar

obesity$value = as.numeric(as.character(obesity$value))

# export to CSV

write.table(obesity, file = "obesi.csv", sep = "\t" , dec = ",", row.names = F)
