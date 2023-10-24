# AWS Setup Instructions #

For performance testing, you will need to run this assignment on a VM instance on Amazon Web Services (AWS). Here are the steps for how to get setup for running on AWS.

NOTE: __Please don't forget to SHUT DOWN your instances when you're done for the day!__

## Connect to VM ##

1. Log in to the [AWS console](https://cs149-fall23.signin.aws.amazon.com/console) by entering your credentials. The Account ID is `744774966508` and the Account Alias `cs149-fall23`. You can enter either one.

2. Now you should see the AWS management console. Search for **Lightsail** in the top left search bar.
![console](handout/console.png?raw=true)

3. After you entered the Lightsail page, click **Lightsail for Research** at the top middle.
![lightsail](handout/lightsail.png?raw=true)

4. Click on the menu button at the top left, and you should see your instance under "virtual computers".
![lightsail_for_research](handout/lightsail_for_research.png?raw=true)

5. Select your instance. You should be able to start your instance by clicking "Start Computer" on the top right. After the instance is started, you can launch the GUI by clicking on **launch Ubuntu**
![instance](handout/instance.png?raw=true)

__Note: The instance automatically shuts off after 15 minutes of inactivity (CPU usage < 2%), please make sure to save your work frequently!__

6. Now you have logged into your instance! To copy your local files to the instance, simply drag them to the GUI. To open the terminal, click **Activities** at the top left in the GUI, and then click on the terminal icon at the bottom middle:
![GUI](handout/GUI.png?raw=true)

__Note: The web GUI accepts only one connection, so two people cannot use the GUI at the same time. If you would like to have multiple persons using the instance at the same time, please use SSH, which involves a more complicated setup.__

### How to set up SSH connection to the VM ###

**Warning:** Setting up SSH to LightSail instance is pretty complicated. This guide is freshly written, so if you encountered error at some step, or if you have found a better/easier way to SSH into the instance, please don't hesitate to make an Ed post/go to office hours!

1. Install AWS CLI
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

2. Install jq
https://jqlang.github.io/jq/download/

3. First we need to generate access keys to configure the AWS CLI. Go to AWS console and select **Security Credentials** from the dropdown menu on the top right.
![security_credentials](handout/security_credentials.png?raw=true)

4. Scroll down and find "Access Keys" Section. Ignore all the other permission errors. Click on **Create access key**
![accesskeys](handout/accesskeys.png?raw=true)

5. In the next page, select use case as "Command Line Interface (CLI)" and select the confirmation box at the bottom. Skip the tag creation and you should get your access keys. Click the **Download .csv file** button and save it in your computer.
![create_accesskey](handout/create_accesskey.png?raw=true)

6. Now we are ready to use the access key to configure the AWS CLI. Open a terminal (or command line) and run
~~~~
aws configure
~~~~
Follow the instructions to input your Access key ID and Secret Access Key. Default region name should be **us-west-2** and default output format should be **json**.

7. Now we are ready to generate the key pair for SSH. Use the following command to generate the key pair using AWS CLI. **Use your SUNet id as the key pair name**. Key pair details are saved into `pkp-details.json`
~~~~
aws lightsail create-key-pair --key-pair-name <your-sunet-id> > pkp-details.json
~~~~

8. Extract and save the public key from the json file. Change the permissions of the resulting key.
~~~~
cat pkp-details.json | jq -r '.privateKeyBase64' > cs149_pa3_private_key
chmod 600 cs149_pa3_private_key
~~~~

9. Extract public key from the json file by using the following command, and then copy the output to your clipboard. Now we are ready to upload the public key to the instance.
~~~~
cat pkp-details.json | jq -r '.publicKeyBase64'
~~~~

10. Open the web GUI and start a terminal. First, we need to change our user to `ubuntu`
~~~~
sudo su - ubuntu
~~~~

11. Then open the ssh config file `.ssh/authorized_keys` using your favorite editor. We will use `nano` as an example. You should see there's already a key in this file. Add your key in a new line like the following. **The new line should start with only one "ssh-rsa"**. Save the file and exit after you finished editing.
![ip](handout/authorized_keys.png?raw=true)

12. Now we have completed our key pair setup. Find your instance's IP address in the console. After starting your Lightsail instance, you can find its IP address here. Try refresh the page if its empty.
![ip](handout/ip.png?raw=true)

13. Finally, you can SSH into your instance using the following command with your instance's IP address!
~~~~
ssh -i cs149_pa3_private_key ubuntu@<instance_ip_addr>
~~~~
Due to permission issues, you can only SSH into the lightsail VM as user `ubuntu`, however, when you use the web GUI you are logged in as `lightsail-user`. To avoid any file permission issues when you switch between web GUI and SSH, please run the following command to switch to `lightsail-user` everytime you SSH into the instance.
~~~~
sudo su - lightsail-user
~~~~

## Setting up the VM environment ##

For this assignment, you don't need to do any additional setup. We have set up the machine for you! You can double check the cuda version, which should be 12.3. The GPU we are using is Tesla T4.
~~~~
lightsail-user@ip-172-26-12-153:~$ nvidia-smi
Mon Oct 23 16:08:43 2023       
+---------------------------------------------------------------------------------------+
| NVIDIA-SMI 545.23.06              Driver Version: 545.23.06    CUDA Version: 12.3     |
|-----------------------------------------+----------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
|                                         |                      |               MIG M. |
|=========================================+======================+======================|
|   0  Tesla T4                       On  | 00000000:00:1E.0 Off |                    0 |
| N/A   43C    P0              26W /  70W |    255MiB / 15360MiB |      0%      Default |
|                                         |                      |                  N/A |
+-----------------------------------------+----------------------+----------------------+
                                                                                         
+---------------------------------------------------------------------------------------+
| Processes:                                                                            |
|  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
|        ID   ID                                                             Usage      |
|=======================================================================================|
|    0   N/A  N/A      2527      C   /usr/lib/x86_64-linux-gnu/dcv/dcvagent      249MiB |
+---------------------------------------------------------------------------------------+
~~~~

## Cloning the assignment ##

Clone the repository with the following command: `git clone https://github.com/stanford-cs149/asst3.git`.

## Fetching your code from AWS ##

Once you've completed your assignment, you can download your code using the File Storage console by clicking on the double-arrow button at top left:
![file_storage](handout/file_storage.png?raw=true)
![download](handout/download.png?raw=true)

If you are using SSH, you can fetch your code using `scp` command like following in your local machine:
~~~~
scp -i <path_to_the_key_file> ubuntu@<VM_IP_address>:/path/to/file /path/to/local_file
~~~~
 