PASSWD ?= "Sarmat12345678"

boot:
	docker kill mssql 2>/dev/null
	docker rm mssql 2>/dev/null
	docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=$(PASSWD)" -p 1433:1433 --name mssql --hostname mssql -d mcr.microsoft.com/mssql/server:2022-latest
	docker exec -u root -it mssql "ln" "-s" " /opt/mssql-tools/bin/sqlcmd" "/usr/bin/sqlcmd"
shell:
	docker exec -it mssql "bash"
sql:
	docker exec -it mssql "/opt/mssql-tools/bin/sqlcmd" "-S" "localhost" -U SA -P "$(PASSWD)"
