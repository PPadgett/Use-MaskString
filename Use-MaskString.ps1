<#
.Synopsis
   Used to Mask any ASCII String (Example: Text, Email Address, Phone Number, Password) to send via email or chat
.DESCRIPTION
   This is Not Encryption!!! Just best effort to hide a string while sharing infomation with Coworkers
.EXAMPLE
   Use-MaskString EmailAddress

   Output:
   [string](0..11|%{ [char][int](32+("377765737633686882698383").substring(($_*2),2))})-replace " "

.EXAMPLE
   Use-MaskString -String '555-555-5555'

   Output:
   [string](0..11|%{ [char][int](32+("212121132121211321212121").substring(($_*2),2))})-replace " "

.INPUTS
   Input Any String of ASCII
.OUTPUTS
   Outputs a short script that any user can cut and paste into another PowerShell window to translate the Masked text back to a string.
.NOTES
   ##########################################
   # This is Not Encryption                 #
   ##########################################
   # Just Best effort to hide a string      #
   # while sharing infomation with CoWorkers#
   ##########################################
#>
param
(
    # Param1 help description
    [Parameter(Mandatory=$true,
    ValueFromPipeline=$false,
    ValueFromPipelineByPropertyName=$false, 
    ValueFromRemainingArguments=$false, 
    Position=0)]
    [ValidateNotNull()]
    [ValidateNotNullOrEmpty()]
    [string]$String
)

#Load Function
Function Use-MaskString
{
    param
    (
        # Param1 help description
        [Parameter(Mandatory=$false,
        ValueFromPipeline=$false,
        ValueFromPipelineByPropertyName=$false, 
        ValueFromRemainingArguments=$false, 
        Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$String
    )   
    
    "$String" | ForEach-Object { "[string](0..$( $_.Length -1 )|%{ [char][int](32+(`"" + -join ( [int[]][char[]]$_ | ForEach-Object { if ( $_-32 -lt 9 ) { "0$($_-32)" } else { $_-32 } }) + "`").substring((`$_*2),2))})" + '-replace " "'}
}
Use-MaskString -String "$($String)"