connect-azAccount
#選定訂閱
Select-AzContext -name "___換成你自己的訂閱名稱___"
Write-Output "-------------------"
#取得訂閱
$sub=get-azcontext
#顯示訂閱名稱
Write-Output "處理訂閱帳戶 --> " $sub.Name
#資源群組
$ResourceGroup=Get-AzResourceGroup
$ResourceGroupCount=($ResourceGroup).Count;
Write-Output "目前共有 $ResourceGroupCount 個資源群組"
Write-Output "-------------------"
#跑所有資源群組
foreach ($item in $ResourceGroup)
{
    #顯示資源群組名稱
    Write-Output "--------------------------"
    $name=$item.ResourceGroupName
    Write-Output $name
    #找出資源群組中的資源數量
    $count = (Get-AzResource | where { $_.ResourceGroupName -eq $name }).Count; 
    #Write-Host $count
    #如果是零...
    if($count -eq 0)
     { 
        Write-Output "資源群組 $name 只擁有 $count 個資源...刪除它..."; 
        Remove-AzResourceGroup -Name $name; 
     } 
     else
     { 
        Write-Output "資源群組 $name 還有 $count 個資源，不動它。"; 
     } 
}

#重新檢視資源群組
$ResourceGroup=Get-AzResourceGroup
$ResourceGroupCount=($ResourceGroup).Count;
Write-Output "處理後，共有 $ResourceGroupCount 個資源群組"
