dataset = r.titanic_dataset

import re

Title = []
patron_title = re.compile(' ([A-Za-z]+)\.')

for name in dataset["Name"]:
  extract = patron_title.findall(name)
  Title.append(extract[0])
  
dataset["Title"] = Title

# Título presentes:
print(dataset["Title"].unique())
dataset["Title"] = dataset["Title"].replace(["Mlle", "Ms", "Lady", "Countess"], "Miss")
dataset["Title"] = dataset["Title"].replace(["Sir", "Don"], "Mr")
dataset["Title"] = dataset["Title"].replace("Mme", "Mr")
dataset["Title"] = dataset["Title"].replace(['Rev', 'Dr', 'Col', 'Major','Capt', 'Jonkheer', 'Dona'], 'Rare')
