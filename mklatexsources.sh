#!/bin/bash

if [ -f latexsources.zip ]; then
    rm latexsources.zip
fi
    
git ls-files --exclude-standard -co | zip -@ latexsources.zip

# Si la première commande échoue, soit git n'est pas disponible, soit nous ne 
# somme pas dans un dépôt git. On tente d'interpréter le gitignore et on espère
# que ça marche. C'est mieux que rien.

if [ ! -f latexsources.zip ]; then
    find . -name .git -prune -o -print | grep -v -f <(grep -Ev '^#|^$' < .gitignore | sed 's/\([.|]\)/\\\1/g; s/\?/./g ; s/\*/.*/g') | zip -9 -@ latexsources.zip
fi


