#!/bin/bash
set -e


#####################################
# Stop idle 
#
#####################################

# PARAMETERS
IDLE_TIME=3600

echo "Fetching the autostop script"
wget https://raw.githubusercontent.com/aws-samples/amazon-sagemaker-notebook-instance-lifecycle-config-samples/master/scripts/auto-stop-idle/autostop.py

echo "Starting the SageMaker autostop script in cron"
(crontab -l 2>/dev/null; echo "*/5 * * * * /usr/bin/python $PWD/autostop.py --time $IDLE_TIME --ignore-connections") | crontab -

#####################################
# Keys
#####################################
echo "Linking private key"
ln -s /home/ec2-user/SageMaker/.ssh/id_rsa /home/ec2-user/.ssh/id_rsa
echo "Setting Kaggle key"
mkdir /home/ec2-user/.kaggle
chown ec2-user:ec2-user /home/ec2-user/.kaggle
ln -s /home/ec2-user/SageMaker/.kaggle/kaggle.json /home/ec2-user/.kaggle/kaggle.json
