#!/bin/sh

# Define default options and variables
VERSION="1.0"
DHUS_SERVER_URL="https://sentinel-hub.inpe.br"
DHUS_USER="XXXX"
DHUS_PASSWD="XXXX"
JSON_OPT=false
VERBOSE=false
RESULT_LIST=""

# Display version
show_version()
{
   echo "\n"
   echo "**** Hello Word! Este script está na versão: $VERSION ****"
}

show_version

echo "\n"
echo "Digite o valores para pesquisa:"
echo "Periodo inicial:"
read periodo_inicial;
echo "Periodo final:"
read periodo_final;
echo "Satelite:"
read satelite;
echo "Produto:"
read produto;
echo "Cobertura de Nuvens:"
read nuvens;

#2020-03-01 2020-04-01 Sentinel-2 S2MSI2A 20%

curl -u $DHUS_USER:$DHUS_PASSWD -data-urlencode "$DHUS_SERVER_URL/search?q=(beginPosition:%5B$periodo_inicial""T00:00:00.000Z%20TO%20$periodo_final""T23:59:59.999Z%5D%20AND%20endPosition:%5B$periodo_inicial""T00:00:00.000Z%20TO%20$periodo_final""T23:59:59.999Z%5D)AND((platformname:$satelite)AND(producttype:$produto)AND(cloudcoverpercentage:%5B0%20TO%20$nuvens%5D))" > test1.txt

#sleep 2;

result=$(grep "<opensearch:totalResults>" ./test1.txt | cut -d">" -f2 | cut -d"<" -f1)

echo "***"
echo "No periodo entre $periodo_inicial até $periodo_final, o $satelite com produto $produto, encontrou $result, com cobertura de nuvens $nuvens""0%!"

echo "Produtos: (10 primeiros)"
produtos=$(grep "filename" ./test1.txt | cut -d">" -f2 | cut -d"." -f1 | sed 's/ /\n/g')
echo $produtos

 
