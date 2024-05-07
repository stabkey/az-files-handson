---
title: BicepでVM作成
marp: true
---

## はじめに

Azure CLIとBicepを用いて、M1台とその周辺のリソースを構築します。

---

## 事前の準備

Bicepのファイルをシェルを実行しているディレクトリと同じ場所に配置します。

---

## VMの作成

👇️Azureにサインインする。ブラウザで認証を行います。

```PowerShell
az login
```

---

👇️使用可能なサブスクリプションを確認します。  
複数ある場合は、この後の手順で使用するサブスクリプションを指定します。

```PowerShell
az account list --output table
```

---

👇️使用するサブスクリプションを切り替えます。  
対象のサブスクリプションの「SubscriptionId」を変数に格納します。

```PowerShell
$subscriptionID=<サブスクリプションID> # 書き換えます。

az account set --subscription $subscriptionID --output table
```

👇️リソースグループをCLIで作成します。  
その後Bicepでリソースを作成します。  
VMのローカル管理者のパスワードを求められるのでコンソールに入力します。

```PowerShell
$prefix="sun"
$rgName= $prefix + "-rg"
$location="japaneast"
$admin_username="testadmin"

# リソースグループ作成。
az group create --name $rgName --location $location

# Bicepでリソースを作成。
az deployment group create `
--resource-group $rgName `
--template-file sample.bicep `
--parameters prefix=${prefix} `
--parameters adminUsername=${admin_username}
```

---

👇️各リソースが作成されているか確認します。

```PowerShell
az resource list --resource-group $rgName --output table
```

👇️成功すれば以下のように出力されます。

---

```PowerShell
Name                                              ResourceGroup     Location    Type                                          Status
------------------------------------------------  ----------------  ----------  --------------------------------------------  --------default-NSG                                       files-handson-rg  japaneast   Microsoft.Network/networkSecurityGroups
bootdiags526nosmsagvrk                            files-handson-rg  japaneast   Microsoft.Storage/storageAccounts
mon-vm/GuestAttestation                           files-handson-rg  japaneast   Microsoft.Compute/virtualMachines/extensions
mon-vnet                                          files-handson-rg  japaneast   Microsoft.Network/virtualNetworks
mon-vm                                            files-handson-rg  japaneast   Microsoft.Compute/virtualMachines
myPublicIP                                        files-handson-rg  japaneast   Microsoft.Network/publicIPAddresses
mon-vm-Nic                                        files-handson-rg  japaneast   Microsoft.Network/networkInterfaces
mon-vm_OsDisk_1_6d42b14d5ab349c591107a6698129467  FILES-HANDSON-RG  japaneast   Microsoft.Compute/disks
```