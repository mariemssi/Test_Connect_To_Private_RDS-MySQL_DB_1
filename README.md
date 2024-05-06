# Testing Connection to a Private RDS MySQL DB 

![image](https://github.com/mariemssi/Test_Connect_To_Private_RDS-MySQL_DB_1/assets/69463864/460c5bdf-a95a-4f49-8a47-70845bfb8407)





## Provisioning Test Infrastructure with Terraform
1. Clone the GitHub Repository: `git clone <repository_url>`
  
2. Ensure that Terraform is installed on your local machine or Install it
   
3. Set Up your AWS Credentials AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY.
        
4. Generate SSH Key pair: `ssh-keygen -f mykey`

   This command generates 2 files mykey (private key) and mykey.pub (public key). Place the public key file in the root directory of your terraform code.

   You can also reference an AWS key pair if you have already one. Ensure to update ec2_bastion_host.tf accordingly.

   
   
5. Initialize Terraform: `terraform init`
   
6. Review Terraform Plan (Optional): `terraform plan`
   
   You can preview the changes Terraform will make to your infrastructure. For this, you should provide the Input Variables defined in variables.tf. You can define its values as default in the variables.tf file or you can define it as parameters of terraform plan and terraform apply commands
   or Terraform will prompt you to provide their values during the terraform apply process.

   😱 USERNAME and DB-PASSWORD are secrets and It's important to note that using these methods for secrets is not a best practice in production environments.
   For handling secrets securely, consider using more robust methods available in Terraform, such as using external secret management systems or environment variables.  
  
7. Apply Terraform Changes: `terraform apply`

    Wait for Terraform to Complete, this process may take some time. Once complete, Terraform will display a summary of the changes made.

## Testing the Connexion to the DB

### With command Lines
 
1. SSH into the bastion-host using the private key: `ssh -i "path-to-private-key" bastion-host-dns-name`
 
2. Install MySQL on EC2-BH if it is not already installed

3. Connect to the database from the EC2-BH: `mysql -h database-endpoint -p 3306 -u username -p`

![image](https://github.com/mariemssi/Test_Connect_To_Private_RDS-MySQL_DB_1/assets/69463864/97c22cd9-4b82-4aaa-a7a1-65008ccd9723)



5. Run SQL queries After successfully connecting
 


### With MySQL Workbench

1. Define the needed parameters of the connexion like the screeshot below:
   
![image](https://github.com/mariemssi/Test_Connect_To_Private_RDS-MySQL_DB_1/assets/69463864/70a39a9c-e370-4710-9899-1483c1264894)




2. Run SQL queries After successfully connecting
 
## Destroying Test Infrastructure
  Destroy Resources (Optional): `terraform destroy`
  Once you have finished testing, it's important to destroy the test environment to avoid incurring unnecessary charges from AWS 😉.

Additional details can be found [here](https://medium.com/@meriemiag/exploring-ways-to-connect-to-mysql-rds-database-102aec995673)

*Please note that the environment presented here is designed solely for testing purposes and may not adhere to best practices.*
