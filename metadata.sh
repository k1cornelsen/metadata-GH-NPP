#!/bin/bash



if [ "$1" == "" ] || [ "$2" == "" ]; then

    echo "Extensoes: pdf,doc,docx,xls,xlsx,ppt,pptx"

    echo "Modo de uso: $0 target.com pdf"

else

    lynx_output=$(lynx --dump "https://google.com/search?q=site:$1+ext:$2" | grep ".$2" | cut -d "=" -f2 | egrep -v "site|google" | sed 's/...$//' | grep -v /search)



    if [ -z "$lynx_output" ]; then

        echo "Nada encontrado."

    else

        echo "$lynx_output" > metabase

        for url in $(cat metabase); do wget -q $url;done

        echo "Conteúdo atualizado em metabase."

        echo "Metabase do conteudo: "

        cat metabase 

        exiftool *.$2

        rm -rf metabase

    fi

fi

