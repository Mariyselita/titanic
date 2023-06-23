## Dsitribución de Chi Cuadrada
## Alumna: Marisela Cadena


library(tidyverse)
library(reticulate)
library(gmodels)

names(titanic_dataset)
str(titanic_dataset)
summary(titanic_dataset)


titanic_dataset$Survived <- factor(titanic_dataset$Survived, 
                              levels = c(0,1), 
                              labels = c("Dead", "Survived"))

titanic_dataset$Sex <- factor(titanic_dataset$Sex,
                         levels = c("male","female"),
                         labels = c("Male","Female"))

titanic_dataset$Embarked <- factor(titanic_dataset$Embarked, levels = c("C", "Q", "S"))

titanic_dataset$Pclass <- factor(titanic_dataset$Pclass, 
                            levels = c(1,2,3),
                            labels = c("First Class", 
                                       "Second Class", 
                                       "Third Class"))

rand.impute <- function(x) {
  missing <- is.na(x) 
  n.missing <- sum(missing)
  x.obs <- x[!missing]
  imputed <- x
  imputed[missing] <- sample(x.obs, n.missing, replace = TRUE)
  return (imputed)
}

titanic_dataset$Age <- rand.impute(titanic_dataset$Age)

#Sobrevivientes en función del sexo
CrossTable(titanic_dataset$Sex, titanic_dataset$Survived, dnn = c("Sex", "Survived"))

titanic_dataset %>% 
  ggplot() +
  geom_bar(mapping = aes(Sex, fill = Survived))

#Sobrevivientes en función de la clase

CrossTable(titanic_dataset$Pclass, titanic_dataset$Survived, dnn = c("Pclass", "Survived"))

titanic_dataset %>% 
  ggplot()+
  geom_bar(mapping = aes(x = Pclass, fill = Survived))

#Sobrevivientes en función de la edad
titanic_dataset$Age.cat <- cut(titanic_dataset$Age, 
                          breaks = c(0, 14, 24, 64, Inf),
                          labels = c("Niño", "Joven", "Adulto", "Mayor"))

round(prop.table(table(titanic_dataset$Age.cat, 
                       titanic_dataset$Survived,
                       dnn =  c("Age", "Survived(%)")), 1)*100,2)

titanic_dataset %>% 
  ggplot()+
  geom_bar(aes(Age.cat, fill = Survived))

#Sobrevivientes en función del embarque

CrossTable(titanic_dataset$Embarked, 
           titanic_dataset$Survived, 
           dnn = c("Embarked", "Survived"))
titanic_dataset %>% 
  ggplot()+
  geom_bar(mapping = aes(x = Embarked, fill = Survived))

#Sobrevivientes en función al  número de Hermanos/Cónyuges a bordo del Titanic 

titanic_dataset %>% 
  ggplot()+
  geom_bar(mapping = aes(x = SibSp, fill = Survived))


 
#Sobrevivientes en función al número de Padres/Hijos a bordo del Titanic

titanic_dataset %>% 
  ggplot()+
  geom_bar(mapping = aes(x = Parch, fill = Survived))





