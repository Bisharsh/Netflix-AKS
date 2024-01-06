variable  "backendrg"  {
   type                =  string
   description  =  "The  name  of  the  backend  storage  account  resource  group"
   default          =  "backend-rg"
}
  
variable  "backendsa"  {
   type                =  string
   description  =  "The  name  of  the  backend  storage  account"
   default          =  "backendbsa"
}
  
variable  "backendcontainer"  {
   type  =  string
   description  =  "The  container  name  for  the  backend  config"
   default  =  "backend-container"
}
  
variable  "backendkey"  {
   type  =  string
   description  =  "The  access  key  for  the  storage  account"
   default  =  "devpipeline.terraform.tfstate"
}
  
variable  "tags"  {
   type                =  map(string)
   description  =  "Tags  used  for  the  deployment"
   default  =  {
       "Environment"  =  "development"
   }
}
  
variable  "resource_group"  {
   type                =  string
   description  =  "name  of  resource  group"
}
  
variable  "location"  {
   type                =  string
   description  =  "location  of  resource  group"
}