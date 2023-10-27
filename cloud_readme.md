# AWS Setup Instructions #

For performance testing, you will need to run this assignment on a VM instance on Amazon Web Services (AWS). Here are the steps for how to get setup for running on AWS.

By now you should have already received the AWS login credentials. If not, make a private Ed post and we will create login credentials for you.

NOTE: __Please don't forget to SHUT DOWN your instances when you're done for the day!__

## Connect to VM ##

1. Log in to the [AWS console](https://cs149-fall23.signin.aws.amazon.com/console) by entering your credentials. The Account ID is `744774966508` and the Account Alias `cs149-fall23`. You can enter either one.

2. Now you should see the AWS management console. Search for **Lightsail** in the top left search bar.
![console](handout/console.png?raw=true)

3. After you entered the Lightsail page, click **Lightsail for Research** at the top middle.
![lightsail](handout/lightsail.png?raw=true)

4. Click on the menu button at the top left, and you should see your instance under "virtual computers" (the instance name should include your SUNet id).

*Oct 25 2:42PM: Lightsail web page is currently bugged where you will see lots of red boxes with errors. You can ignore the errors (close all red boxes) and continue to work with your instance.*
![lightsail_for_research](handout/lightsail_for_research.png?raw=true)

5. Select your instance. You should be able to start your instance by clicking "Start Computer" on the top right. After the instance is started, you can launch the GUI by clicking on **launch Ubuntu**
![instance](handout/instance.png?raw=true)

__Note: The instance automatically shuts off after 15 minutes of inactivity (CPU usage < 2%), please make sure to save your work frequently!__

6. Now you have logged into your instance! To copy your local files to the instance, simply drag them to the GUI. To open the terminal, click **Activities** at the top left in the GUI, and then click on the terminal icon at the bottom middle:
![GUI](handout/GUI.png?raw=true)

__Note: The web GUI accepts only one connection, so two people cannot use the GUI at the same time. If you would like to have multiple persons using the instance at the same time, please use SSH, which involves a more complicated setup.__

### How to set up SSH connection to the VM ###
**Note:** The first step targets MacOS/Linux Users, if you are using windows, you can do a similar process to generate your keypair (https://www.purdue.edu/science/scienceit/ssh-keys-windows.html), and then Proceed to step 2. If you have any issues, please don't hesitate to make a Ed post or go to office hours!

1. Use `ssh-keygen` to generate a key pair, which includes one public key (named `<key-name>.pub`) and one private key (named `<key-name>`). The dialog will be like the following. Choose the save location of your key pair (`./mykey` in the example below), and passphrase can be empty (just hit enter).
~~~~
$ ssh-keygen         
Generating public/private rsa key pair.
Enter file in which to save the key (/.ssh/id_rsa): ./mykey
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in mykey
Your public key has been saved in mykey.pub
~~~~

2. Print the content of public key by using `cat <path-to-your-public-key>` (Or you can also open the file using a text editor). Copy the content and we will upload the public key to the instance.

3. Open the web GUI and start a terminal. Create a ssh config file `authorized_keys` under the folder `~/.ssh/` using your favorite editor. We will use `nano` as an example. Add your public key in a line like the following. Save the file and exit after you finished editing.
![ip](handout/authorized_keys.png?raw=true)

4. We need to change the permissions of the created file. Also change permissions of its parent directories.
~~~~
chmod 600 /home/lightsail-user/.ssh/authorized_keys
chmod 700 /home/lightsail-user/.ssh
chmod go-w /home/lightsail-user
~~~~

5. Now we have completed our key pair setup. Find your instance's IP address in the console. After starting your Lightsail instance, you can find its IP address here. Try refreshing the page if its empty. **Note: the IP of your instance changes every time it is restarted!**
![ip](handout/ip.png?raw=true)

6. Finally, you can SSH into your instance using generated private key with the following command!
~~~~
ssh -i <path-to-your-private-key> lightsail-user@<instance-IP-addr>
~~~~

## Setting up the VM environment ##

1. We have provided an installation script in the assignment repo to install CUDA and other necessary packages. Clone the assignment repo to your instance using the following command.
~~~~
git clone https://github.com/stanford-cs149/asst3.git
~~~~

2. Add execute permissions, and run the installation script. If you encounter any issues, please make a post on Ed!
~~~~
chmod +x ./asst3/install.sh
./asst3/install.sh
~~~~

3. Run the following command to update your path.
~~~~
source ~/.bashrc
~~~~

4. After running the script, CUDA should be installed. You can double check the cuda version using `nvidia-smi`, which should be **12.3**. The GPU we are using is **Tesla T4**. 

(If the command errors, try restarting the terminal/restarting the instance, and if error persists, make an Ed post and TAs will help!)
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

## Fetching your code from AWS ##

Once you've completed your assignment, you can download your code using the File Storage console by clicking on the double-arrow button at top left:
![file_storage](handout/file_storage.png?raw=true)
![download](handout/download.png?raw=true)

If you are using SSH, you can fetch your code using `scp` command like following in your local machine:
~~~~
scp -i <path-to-your-private-key> lightsail-user@<instance-IP-addr>:/path/to/file /path/to/local_file
~~~~

## Shutting down VM ##
When you're done using the VM, you can shut it down by clicking "stop computer" in the web page, or using the command below in the terminal.
~~~~
sudo shutdown -h now
~~~~

 