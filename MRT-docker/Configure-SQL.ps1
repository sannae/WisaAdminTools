# Create a volume for SQL Data and run the SQL container instance

docker volume create sql-data
docker run --name sql --publish 1433:1433 --detach --volume sql-data:C:/temp/ --env attach_dbs="[{'dbName':'MRT','dbFiles':['C:\\temp\\MRT.mdf','C:\\temp\\MRT_log.ldf']}]" --env sa_password='Micro!Mpw147' --env ACCEP_EULA=Y microsoft/mssql-server-windows-express:latest

# Test internal connection

docker exec -it sql sqlcmd

# Get the sql container's IPv4

$IP = docker inspect --format '{[.NetworkSettings.Networks.nat.IPAddress}]' sql

# Test external connection

sqlcmd -U sa -S $IP

