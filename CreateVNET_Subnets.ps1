# --------------------------------------------------------------------------------------------------------------------------------
#
# Linda - Creating a Virtual network / Subnet 
# 7.24.2022
# https://docs.microsoft.com/en-us/azure/virtual-network/quick-create-powershell
# https://techgenix.com/warning-messages-azure-cmdlets/
#
# These warnings are providing notice that the listed parameters (-ResourceId and -InputObject) will change in a future release, 
# in case you are using them in the invoked cmdlet. The command in the topic uses neither so this warning can be ignored.
# (Set-Item Env:\SuppressAzurePowerShellBreakingChangeWarnings "true")
#
# --------------------------------------------------------------------------------------------------------------------------------

# Connect to a Azure subscription/tenant
# Connect-AzAccount

Set-Item Env:\SuppressAzurePowerShellBreakingChangeWarnings "true"

# Create a Azure Resource Group
$rg = @{
    Name = 'VNET_Demo_ResourceGroup'
    Location = 'EastUS'
}
New-AzResourceGroup @rg



# Configure VNET 
$vnet = @{
      Name = 'DemoVNET' 
      ResourceGroupName = 'VNET_Demo_ResourceGroup'
      Location = 'East US'
      AddressPrefix = '10.0.0.0/16'
}
$virtualNetwork = New-AzVirtualNetwork @vnet


# Confgiure Subnet range within the VNET
$subnet = @{
        Name = 'Demo_Subnet'
        VirtualNetwork = $virtualNetwork
        AddressPrefix = '10.0.0.0/24'
}
$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet


#Associate the newly created subnet to the VNET
$virtualNetwork | Set-AzVirtualNetwork

