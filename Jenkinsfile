node {
 	// Clean workspace before doing anything
    deleteDir()

    try {
        stage ('Clone') {
        	checkout scm
        }
        stage ('Init Terraform') {
        	sh "terraform init -input=false"
        }
        stage ('Build kube worker nodes') {
		                    sh  " terraform plan -out=tfplan -input=false -var template_name=centos-kube -var vm_name=worker-node  -var vsphere_password=${VCENTER_PASS} -var vsphere_datastore=${DATASTORE} -var count=3 -var octet=43 ; terraform apply tfplan "
        }
      	stage ('Cleanup') {
      		sh "rm -rf .terraform"
	}
    } catch (err) {
        currentBuild.result = 'FAILED'
        throw err
    }
}

