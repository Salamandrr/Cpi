#!/bin/sh
# On a $1 = le dossier de télechargement
# J'ai rajouté des options pour qu'on ait plus de libertes
# Variables de base du programme
musique_file=./
dowload_dir=$1
delete=false

# Options
while getopts "f" option
do
	case $option in
		# On choisit ou on extrait la musique
		f)shift
		# On stocke le nom du repertoire dans une variable
		musique_file=$2
		;;
		# Autre chose que l'option f
		?)echo "usage: option inconnue"
		exit 1;;
esac
done

# On recupere le nom du repertoire de telechargement
download_dir=$1

# Liste tous les fichiers musicaux dans le dossier de telechargement
musique=`ls $download_dir | grep -P ".*- Jamendo - MP3.zip" >/tmp/musique.$$`

# On va extraire les archives une a une
while read line
do
	# On va prendre le nom du dossier a creer
	namedir=`echo $line | cut -d'-' -f1,2`

	#On extrait l'archive sans afficher,sans remplacer les fichiers exitants
	unzip -qn $download_dir/"$line" -d $musique_file/"$namedir"
	echo "$line extrait" 
	
	#On change les droits
	chmod 554 $musique_file/"$namedir"/*

done < /tmp/musique.$$

#Je supprime mon fichier temp
rm -f /tmp/musique.$$
