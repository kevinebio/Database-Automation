#! /usr/bin/bash

hiroTest='test-aurora-mysql-57.cluster-caqvsmapmeil.ap-northeast-1.rds.amazonaws.com'
hiroApi= 'api-aurora-mysql-57.cluster-caqvsmapmeil.ap-northeast-1.rds.amazonaws.com'

echo "Servers: "
sed -rn 's/^\s*Host\s+(.*)\s*/\1/ip' ~/.ssh/config
echo ">> Which server would you like to connect? <<"
read server
	if [ $server = "hiro-test" ];
	then
		echo "***** Great! Successfully connected to ${server} *****"
		echo ">> Which database would you like to connect? <<"
		read dbname

		echo ">> Would you like to import or export ${dbname}? <<"
		read action
			if [ $action = "import" ];
			then
				##### Back up current database #####
				ssh ${server} mysqldump --host $hiroTest -u admin -p ${dbname} > "${dbname} -$(date +"%Y-%m-%d-%H%M%S").sql"
				echo "Backup successful and saved in: ${PWD}"

				##### UPLOADING BACKUP FILE TO REMOTE SERVER #####

				echo ">> Here are the list of backup on your local machine: "
				echo "$( ls | grep *.sql )"

				echo "Which backup would you like to import?"
				read backup

				echo "user input: ${backup}"

				##### DROPPING EXISTING DATABASE #####



				##### RECREATE THE DATABASE #####

			elif [ $action = "export" ];
			then

				##### WITH COMPRESSION #####
				ssh ${server} mysqldump --host $hiroTest -u admin -p ${dbname} | gzip --best > "${dbname} -$(date +"%Y-%m-%d-%H%M%S").sql.gz"

				##### WITHOUT COMPRESSION #####
				# ssh ${server} mysqldump --host $hiroTest -u admin-p ${dbname} > "${dbname} -$(date +"%Y-%m-%d-%H%M%S").sql"
				echo "Backup successful and saved in: ${PWD}"

			else
				echo "You've entered an invalid option. Please re-run the script. Thank you!";
			fi
	elif [ $server = "hiro-api" ];
		then
		echo "***** Great! Successfully connected to ${server} *****"
		echo ">> Which database would you like to connect? <<"
		read dbname

		echo ">> Would you like to import or export ${dbname}? <<"
		read action
			if [ $action = "import" ];
			then
				##### Back up current database #####
				ssh ${server} mysqldump --host $hiroApi -u admin -p ${dbname} > "${dbname} -$(date +"%Y-%m-%d-%H%M%S").sql"
				echo "Backup successful and saved in: ${PWD}"

				##### UPLOADING BACKUP FILE TO REMOTE SERVER #####

				echo ">> Here are the list of backup on your local machine: "
				echo "$( ls | grep *.sql )"

				echo "Which backup would you like to import?"
				read backup

				echo "user input: ${backup}"

				##### DROPPING EXISTING DATABASE #####



				##### RECREATE THE DATABASE #####

			elif [ $action = "export" ];
			then

				##### WITH COMPRESSION #####
				ssh ${server} mysqldump --host $hiroApi -u admin -p ${dbname} | gzip --best > "${dbname} -$(date +"%Y-%m-%d-%H%M%S").sql.gz"

				##### WITHOUT COMPRESSION #####
				# ssh ${server} mysqldump --host $hiroApi -u admin-p ${dbname} > "${dbname} -$(date +"%Y-%m-%d-%H%M%S").sql"
				echo "Backup successful and saved in: ${PWD}"

			else
				echo "You've entered an invalid option. Please re-run the script. Thank you!";
			fi
	fi