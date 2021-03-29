#!/bin/bash

##  NAME: storageReport.sh
##  AUTHOR: Gustavo Gidzinski Gomes
##  DATE: 11/02/2021
##  VERSION: 2.0
##  COMPANY: T-Systems do Brasil
##  DESCRIPTION: CRIA UM REPORT GERAL CHAMADO <NOME DO STORAGE>_REPORT.TXT POR EQUIPAMENTO DO AMBIENTE DSI

#DECLARANDO VARIAVEIS
SSH=/usr/bin/ssh
ECHO=/bin/echo
ECHOSPACE="echo """
TEMPDIR=/home/gsilva10/tmp
STORAGELISTPATH=/home/gsilva10/Storage_list

#FOR PARA COLETA DE INFORMAÇÕES E ARMAZENAMENTO EM ARQUIVO TXT
for storage in `cat "$STORAGELISTPATH"`;
do
		VFILERLISTPATH=/home/gsilva10/tmp/"$storage"
		REPORTPATH=/home/gsilva10/report/"$storage"_Report.txt
		
		$ECHO "$storage"
        	$ECHO "##### $storage" > "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### SYSCONFIG -A" >> "$REPORTPATH"
		$SSH $storage sysconfig -a >> "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### DF -AK" >> "$REPORTPATH"
		$SSH $storage df -Ak >> "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### AGGR SHOW_SPACE" >> "$REPORTPATH"
		$SSH $storage aggr show_space >> "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
        	$ECHO "##### DF -KV" >> "$REPORTPATH"
		$SSH $storage df -kV >> "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### IFCONFIG -A" >> "$REPORTPATH"
		$SSH $storage ifconfig -a >> "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### NETSTAT -RN" >> "$REPORTPATH"
		$SSH $storage netstat -rn >> "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### VFILER STATUS -A" >> "$REPORTPATH"
		$SSH $storage vfiler status -a >> "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### IGROUP SHOW" >> "$REPORTPATH"
        	$SSH $storage vfiler run "*" igroup show >> "$REPORTPATH"
        	$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### LUN SHOW -M" >> "$REPORTPATH"
        	$SSH $storage vfiler run "*" lun show -m >> "$REPORTPATH"
        	$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### LUN SHOW -V" >> "$REPORTPATH"
        	$SSH $storage vfiler run "*" lun show -v >> "$REPORTPATH"
        	$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### LUN STATS" >> "$REPORTPATH"
        	$SSH $storage vfiler run "*" lun stats -a >> "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### QTREE STATS" >> "$REPORTPATH"
		$SSH $storage vfiler run "*" qtree stats >> "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### EXPORTS" >> "$REPORTPATH"
		$SSH $storage vfiler run "*" exportfs >> "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### QUOTAS" >> "$REPORTPATH"
		$SSH $storage vfiler run "*" quota report >> "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### SNAPMIRROR STATUS" >> "$REPORTPATH"
		$SSH $storage snapmirror status >> "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### SNAPVAULT STATUS" >> "$REPORTPATH"
		$SSH $storage snapvault status >> "$REPORTPATH"
		$ECHOSPACE >> "$REPORTPATH"
		
		$ECHO "##### RMTAB" >> "$REPORTPATH"
		$SSH $storage vfiler status |grep -v vfiler |awk {'print $1'} >> "$VFILERLISTPATH"
		for vfiler in `cat "$VFILERLISTPATH"` #LOOP PARA LISTAR OS VFILERS DE CADA STORAGE E COLETAR O ARQUIVO RMTAB UM POR UM
		do
			RMTABFILEPATH=/vol/"$vfiler"_ROOT/etc/rmtab
			
			$ECHO "===== "$vfiler"" >> "$REPORTPATH"
			$ECHOSPACE >> "$REPORTPATH"
			$SSH $storage rdfile "$RMTABFILEPATH" >> "$REPORTPATH"
			$ECHOSPACE >> "$REPORTPATH"
		done
done

#LIMPAR ARQUIVOS TEMPORARIOS GERADOS NA EXECUÇÃO DO SCRIPT
rm -f "$TEMPDIR"/*
