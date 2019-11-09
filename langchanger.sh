#!/bin/bash

if test -x "`which zenity`"
  then
    GUI="zenity"
  elif test -x "`which kdialog`"
  then
    GUI="kdialog"
  else
    GUI="cli"
fi

cd "`dirname "$0"`"

if [ -f platform/resource/vgui_english.txt ]
  then 
    true
  else 
    case $GUI in
      "zenity")
	zenity --title "LangChanger" --error --text "Error, game not found!"
	;;
      "kdialog")
	kdialog --title "LangChanger" --error "Error, game not found!"
	;;
      "cli")
	echo "Error, game not found!"
	;;
    esac
    exit
fi

LIST=`find . -name vgui_*.txt | grep platform/resource/vgui_ | sort`
LIST=${LIST//'./platform/resource/vgui_'}
LIST=${LIST//.txt}

if [ -f langchanger.cfg ]
  then 
    CURRENTLANG=`cat langchanger.cfg | awk 'NR==1'`
  else
    CURRENTLANG=english
fi

LANG=$1

if [ "$LANG" = "" ]
  then
    case $GUI in
      "zenity")
	zenity --title "LangChanger" --error --text "Language not selected!"
	;;
      "kdialog")
	kdialog --title "LangChanger" --error "Language not selected!"
	;;
      "cli")
	echo "Language not selected!"
	;;
    esac
    exit
  else
    true
fi

if [ -f langchanger.cfg ]
  then
    for f in `cat langchanger.cfg | awk 'NR > 1'`; do
      mv -f ${f//$CURRENTLANG/english} $f
    done
    tar -xf language.bak.tar
    rm language.bak.tar langchanger.cfg
  else
    true
fi

if [ "$LANG" = english ]
  then
    true
  else
    echo $LANG > langchanger.cfg
    find . -name *_$LANG* >> langchanger.cfg
    FILES=`cat langchanger.cfg | awk 'NR > 1'`
    tar -cf language.bak.tar ${FILES//$LANG/english} &> /dev/null
    for f in ${FILES}; do
      mv -f $f ${f//$LANG/english}
    done
fi

case $GUI in
  "zenity")
    zenity --title "LangChanger" --info --text "Language change is complete."
    ;;
  "kdialog")
    kdialog --title "LangChanger" --msgbox "Language change is complete."
    ;;
  "cli")
    echo "Language change is complete."
    ;;
esac
