az acr login --name locacao_auto_acr --resource-group locacao_auto_rg

docker tag bff-rent-car-local acr.io/locacao_auto_acr/bff-rent-car-local:latest

docker push acr.io/locacao_auto_acr/bff-rent-car-local:latest

az containerapp env create --name locacao-auto-env --resource-group locacao_auto_rg --location eastus2 --vnet locacao-auto-vnet --subnet locacao-auto-subnet

az containerapp create --name bff-rent-car-local 
--resource-group locacao_auto_rg 
--environment locacao-auto-env 
--image acr.io/locacao_auto_acr/bff-rent-car-local:latest 
--target-port 5001 --ingress 'external' 
--registry-server acr.io/locacao_auto_acr