<#
.SYNOPSIS
    Backup teams numbers

.DESCRIPTION
    Connects to Teams and gets phone UserAssignment and VoiceApplicationAssignment details
    Automation Account: XXXXXX

.OUTPUTS
    1 csv file to blob storage

.NOTES
    Version 1.0 CommsVerse 2025
#>

#Prereqs
Import-module az.storage
Connect-MicrosoftTeams -Identity
Connect-MgGraph -Identity

#Get All Users
$allusers = Get-MgUser -All  | Select-Object DisplayName,id,UserPrincipalName

#Get All Users into Hashtable
$allADUSers_Hash = @{};

foreach ($user in $allusers) {
    $allADUSers_Hash[$user.Id] = $user.UserPrincipalName;
}

# Set Variables
# NOTE -  [hostname] is the Azure File Server that is being connected to
$strDate = [datetime]::Now.ToString('ddMMyyyy')
$shareName = "[hostname]"
$filePath = ('All_Numbers_exportdata_{0}.csv' -f $strDate)
$akey = Get-AutomationVariable -name akey
$ctx = New-AzStorageContext -ConnectionString "DefaultEndpointsProtocol=https;AccountName=[hostname];AccountKey=$akey;EndpointSuffix=core.windows.net"

# Get All Numbers
# NOTE - The Get-CsPhoneNumberAssignment cmdlet returns only the first 500 results.
$skip = 0
$AllNumbers = do {
  $csPhoneNumberAssignmentParams = @{
    Skip = $skip
  }
  $res = Get-CsPhoneNumberAssignment @csPhoneNumberAssignmentParams
  $skip += 500
  $res
} while ($res)

# Collate All Numbers with All Users data
$allNumbers | Select-object TelephoneNumber,CapabilitiesContain,IsoCountryCode,PstnAssignmentStatus,NumberType,PstnPartnerName,LocationId,AssignedPstnTargetId,@{Name='UPN'; E={$allADUSers_Hash[$_.AssignedPstnTargetId]}} | Export-csv $filePath -NoTypeInformation

# Output File
Set-AzStorageBlobContent -Context $ctx -Container teamstelephonyfiles -File $filePath -Blob $filePath -Force
