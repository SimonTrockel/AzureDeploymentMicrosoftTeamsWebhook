Param(
    [parameter(Mandatory=$true)]
    [String]
    [ValidateNotNullOrEmpty()]  $FunctionUrl,
    [parameter(Mandatory=$true)]
    [String]
    [ValidateNotNullOrEmpty()]  $TeamsWebHookUrl
)

[string] $teamsParam = $TeamsWebHookUrl;

if ($teamsParam.StartsWith("https://"))
{
    $teamsParam = $teamsParam.Substring(8)
}

$url = "$($FunctionUrl)?teamshookuri=$teamsParam"
$url

$testJson = (
    '{
  "id": "35231bc679a97c590dfbee6444f4cf694ccc1c45",
  "status": "success",
  "statusText": "",
  "authorEmail": "john.doe@outlook.com",
  "author": "John Doe",
  "message": "Merge pull request #260 from johndoe/develop\n\nFix for CSS issue.",
  "progress": "",
  "deployer": "GitHub",
  "receivedTime": "2017-01-17T02:21:07.0154934Z",
  "startTime": "2017-01-17T02:21:07.1404915Z",
  "endTime": "2017-01-17T02:44:01.990012Z",
  "lastSuccessEndTime": "2017-01-17T02:44:01.990012Z",
  "complete": true,
  "siteName": "johndoecorp",
  "hostName": "johndoecorp-johndoecorpslot.scm.azurewebsites.net"
}',
'{
  "id": "35231bc679a97c590dfbee6444f4cf694ccc1c45",
  "status": "failed",
  "statusText": "",
  "authorEmail": "john.doe@outlook.com",
  "author": "John Doe",
  "message": "Merge pull request #261 from johndoe/develop\n\nBad Fix for CSS issue.",
  "progress": "",
  "deployer": "GitHub",
  "receivedTime": "2017-01-17T02:21:07.0154934Z",
  "startTime": "2017-01-17T02:21:07.1404915Z",
  "endTime": "2017-01-17T02:44:01.990012Z",
  "lastSuccessEndTime": "2017-01-17T02:44:01.990012Z",
  "complete": true,
  "siteName": "johndoecorp",
  "hostName": "johndoecorp-johndoecorpslot.scm.azurewebsites.net"
}'
)

$testJson | % {Invoke-RestMethod -Method Post -Uri $url -ContentType 'application/json; charset=utf-8' -Body $_ }
