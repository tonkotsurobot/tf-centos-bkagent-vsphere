Provision buildkite-agent-vm-1 from centos-buildkite-agent VM template 

#Set variables on your build machine
export VCENTER_SERVER=CHANGEME
export VCENTER_USERNAME=CHANGEME
export VCENTER_PASSWORD=CHANGEME


#download necessary terraform modules
terraform init


#Deploy machine
terraform plan -out=tfplan -input=false -var template_name=centos-buildkite-agent -var vm_name=centos-buildkite-agent -var octet=60 -var vsphere_password=${VCENTER_PASSWORD} -var vsphere_datastore=esx-nfs-1

terraform apply "tfplan"

OR 

terraform apply -input=false -var template_name=centos-buildkite-agent -var vm_name=centos-buildkite-agent -var octet=60 -var vsphere_password=${VCENTER_PASSWORD} -var vsphere_datastore=esx-nfs-1 -auto-approve


#Destroy machine
terraform destroy -input=false -var template_name=centos-buildkite-agent -var vm_name=centos-buildkite-agent -var octet=60 -var vsphere_password=${VCENTER_PASSWORD} -var vsphere_datastore=esx-nfs-1 -auto-approve

