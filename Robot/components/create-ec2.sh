#!bin/bash
if [ -z "$1" ]; then 
    echo -e "\e[31m Component Name is required \e[0m \t\t"
    echo -e "\t\t\t \e[32m Sample Usage is : $ bash create-ec2.sh user \e[0m"
    exit 1
fi 

AMI_ID=$(aws ec2 describe-images \
    --region us-east-1 \
    --image-ids DevOps-LabImage-CentOS7)
    echo -n "AMI_ID is $AMI_ID"
    # This is a script created to launch EC2 Servers and create the associated Route53 Record 


# AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')
# SGID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b53-allow-all-sg  | jq ".SecurityGroups[].GroupId" | sed -e 's/"//g')
