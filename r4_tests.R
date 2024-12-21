
usa = read.csv('usa.csv',header = TRUE)


### 1 -TEST DE CHI-2 ###


### 1a - Candidat/Régions

tab_cont = table(usa$PartUSA,usa$Candidat)

test <- chisq.test(tab_cont)

test$statistic #: la statistique du Chi2.
test$parameter #: le nombre de degrés de libertés.
test$p.value #: la p-value.
test$observed #: la matrice observée de départ.
test$expected #: la matrice attendue sous l'hypothèse nulle d'absence de biais.



### 1a - Candidat/Régions

tab_cont = table(usa$PartUSA,usa$Candidat)

test <- chisq.test(tab_cont)

test$statistic #: la statistique du Chi2.
test$parameter #: le nombre de degrés de libertés.
test$p.value #: la p-value.
test$observed #: la matrice observée de départ.
test$expected #: la matrice attendue sous l'hypothèse nulle d'absence de biais.


### 1b - /Régions

tab_cont2 = table(usa$BorderSea,usa$Candidat)

test2 <- chisq.test(tab_cont2)

test2$statistic #: la statistique du Chi2.
test2$parameter #: le nombre de degrés de libertés.
test2$p.value #: la p-value.
test2$observed #: la matrice observée de départ.
test2$expected #: la matrice attendue sous l'hypothèse nulle d'absence de biais.


var.test(usa$WHITEp, usa$NODIPLOMp)




### 2 - TESTS DE COMPARAISONS ###

#Réparation des données en fonction des candidats
trump = usa[usa$Candidat == 'Trump',]
clinton = usa[usa$Candidat == 'Clinton',]

#moyennes de la population blanche
moyblanc_trump = mean(trump$WHITEp)
moyblanc_clinton = mean(clinton$WHITEp)

#écart-types de la population blanche
sdblanc_trump = sd(trump$WHITEp)
sdblanc_clinton = sd(clinton$WHITEp)


var.test(trump$WHITEp, clinton$WHITEp)  # test F



# Comparaison d'une moyenne observée 

# à une moyenne théorique mu
t.test(trump$WHITEp, mu=0)
t.test(clinton$WHITEp, mu=0)


# Test de student non-apparié
# Comparaison des moyennes de deux groupes (x et y)
t.test(trump$WHITEp, clinton$WHITEp)

# Test de student apparié
t.test(trump$WHITEp, clinton$WHITEp, paired=TRUE)



### 3 - TESTS DE CORRELATIONS ###

#Récupération des colonnes utiles 
usa_quant = usa[,10:29]
cor(usa_quant)

usa_quant = round(usa_quant,2)#arrondir
usa_quant

mat_cor = round(cor(usa_quant),2) #matrice de corrélation 
mat_cor

library(corrplot)
corrplot(mat_cor, type="upper", order="hclust", tl.col="black", tl.srt=45)


#Enregistrer la matrice de corrélation
write.csv(mat_cor,'matcor.csv')




#### 3-C Différentes test de corrélation


hispa = usa$HISPAp
non_diplome = usa$NODIPLOMp
rev_60p =  usa$F60TO80p + usa$F80TO100p
univ = usa$GRADUATEp

####test de Pearson
pearson1 <-cor.test(hispa,non_diplome, method="pearson")
pearson2 <-cor.test(rev_60p,univ, method="pearson")

pearson1
pearson2

####test de Kendall
kendall1 <- cor.test(hispa,non_diplome, method = "kendall")
kendall2 <- cor.test(rev_60p,univ, method = "kendall")

kendall1
kendall2

####test de spearman
spearman1 <- cor.test(hispa,non_diplome, method = "spearman")
spearman2 <- cor.test(rev_60p,univ, method = "spearman")

spearman1
spearman2
