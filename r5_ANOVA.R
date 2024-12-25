#Ouverture du fchier 



#Choix des variables
pop_hispa = usa$HISPAp
region = usa$PartUSA



### POPULATION HISPANIQUE ###

population = usa$POP10
pop_hispa
population
sum(pop_hispa)


#fonction permettant de calculer le nombre total d'habitant 
hispa_tot <- function(x,y){
  s = 0
  for (i in 1:length(x)){
    s = s + (x[i]*(y[i]/100))
  }
  return(s)
}

hispanique <- hispa_tot(usa$POP10,usa$HISPAp)
round(hispanique)

#% d'hispanique dans le pays
p_hispa = round(hispanique)/pop_total

### Boite à moustache
boxplot(pop_hispa,main= "Distribution des populations hispaniques", col = 'orange',ylim=c(0,60))




### POPULATION HISPANIQUE PAR REGIONS ####








#boite à moustache
boxplot(pop_hispa~region,
        main= "Distribution des populations hispaniques selon la région où ils vivent",
        col = c('red','blue','green','brown','orange'),
        ylim=c(0,60))

#Analyse global
var(pop_hispa)
mean(pop_hispa)



#Découpage des données en régions

### Nord-EST ###

NE = usa[usa$PartUSA == 'North-East',]
mean(NE$HISPAp)
var(NE$HISPAp)

hispa_NE <- hispa_tot(NE$POP10,NE$HISPAp)
round(hispa_NE)


### Nord-Ouest ###

NO = usa[usa$PartUSA == 'North-West',]
mean(NO$HISPAp)
var(NO$HISPAp)

hispa_NO <- hispa_tot(NO$POP10,NO$HISPAp)
round(hispa_NO)


### Sud-Ouest ###
SO = usa[usa$PartUSA == 'South-West',]
mean(SO$HISPAp)
var(SO$HISPAp)

hispa_SO <- hispa_tot(SO$POP10,SO$HISPAp)
round(hispa_SO)


### Sud-Est ###
SE = usa[usa$PartUSA == 'South-East',]
mean(SE$HISPAp)
var(SE$HISPAp)

hispa_SE <- hispa_tot(SE$POP10,SE$HISPAp)
round(hispa_SE)


### Autres ###
O = usa[usa$PartUSA == 'OTHER',]
mean(O$HISPAp)
var(O$HISPAp)

hispa_O <- hispa_tot(O$POP10,O$HISPAp)
round(hispa_O)




### liste de population par régions ###

region_hispa <-c(round(hispa_NE),
                 round(hispa_NO),
                 round(hispa_SO),
                 round(hispa_SE),
                 round(hispa_O))

region_hispa_p <-c(round(hispa_NE)/49225154,
                 round(hispa_NO)/49225154,
                 round(hispa_SO)/49225154,
                 round(hispa_SE)/49225154,
                 round(hispa_O)/49225154)


# on reporte ce résultat en diagramme circulaire
pie(region_hispa_p,
    main = "Répartition des populations hispaniques")


# Load ggplot2
library(ggplot2)

# Create Data
data <- data.frame(
  group=c('Nord-Est','Nord-Ouest','Sud-Ouest','Sud-Est','Autres'),
  value=c(round(hispa_NE)/49225154,
          round(hispa_NO)/49225154,
          round(hispa_SO)/49225154,
          round(hispa_SE)/49225154,
          round(hispa_O)/49225154))

# Basic piechart
ggplot(data, aes(x="", y=value, fill=group)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0)



### Méthodes ANOVA ####





### Somme des Carrées - INTER-GROUPE  ###


#fonction permettant de calculer le nombre total d'habitant 
#pour les écarts inter-groupes
ecart_sqrt <- function(x,y,n){
  s = 0
  for (i in 1:length(x)){
    s = s + (n[i]*(x[i]-y)^2)
  }
  return(s)
}


#nombre de communes par région en liste
reg_taille <- c(372,103,210,224,8)

po_moyenne <-c(4.82,7.89,29.06,6.44,7.59)

moy_hispa <- mean(usa$HISPAp)


#Calcul de la somme des carrées inter
SCE_inter <- ecart_sqrt(po_moyenne,moy_hispa,reg_taille)


#Calcul de la variance inter-groupe
var_inter <- SCE_inter/(length(reg_taille)-1)




### Somme des Carrées - INTRA-GROUPE  ###

ecart_intra <- function(x){
  s = 0
  for (i in 1:length(x)){
    s = s + ((x[i]-mean(x))^2)
  }
  return(s)
}

  
#Calcul de la somme des écart total   
SCE_intra <- ecart_intra(NE$HISPAp)+ecart_intra(NO$HISPAp)+ecart_intra(SO$HISPAp)+ecart_intra(SE$HISPAp)+ecart_intra(O$HISPAp)

var_intra <-SCE_intra/(length(usa$HISPAp)-length(reg_taille))



#Test de Fisher

stat_fisher = var_inter/var_intra

## la statistiques de fisher est largement supérieur au seuil critique
## on peut déduire qu'il y a une dépendance à la répartition des hispaniques

