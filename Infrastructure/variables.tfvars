name = ax-ae1-dev-zentac_rg
location = "east us"
vnetsecuritygroup = ax-ae1-dev-zentac-nsg
virtual_network = ax-ae1-dev-zentac-network
network_interface = ax-ae1-dev-zentac-nic
application_security_group = ax-ae1-dev-zentac-asg
webAppName = ax-ae1-dev-zentac-webapp
publicip = 10.0.0.4
appgateway = ax-ae1-dev-zentac-appgateway
wafpolicy = ax-ae1-dev-zentac-wafpolicy
dbusername = dbadmin
loginpassword = $(loginpassword)  # extract password from Keyvault




