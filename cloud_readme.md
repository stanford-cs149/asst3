# AWS Setup Instructions #

For performance testing, you will need to run this assignment on a VM instance on Amazon Web Services (AWS). Here are the steps for how to get setup for running on AWS.

By now you should have already received the AWS login credentials for your group. If not, make a private Ed post and we will create login credentials for you.

### Connect to VM ###

1. Log in to the [AWS console](https://cs149-fall23.signin.aws.amazon.com/console) by entering your credentials. The Account ID is `744774966508` and the Account Alias `cs149-fall23`.

2. Now you should see the AWS management console. Search for **Lightsail** in the top left search bar.
![console](handout/console.png?raw=true)

3. After you entered the Lightsail page, click **Lightsail for Research** at the top middle.
![lightsail](handout/lightsail.png?raw=true)

4. Click on the menu button at the top left, and you should see your instance under "virtual computers".
![lightsail_for_research](handout/lightsail_for_research.png?raw=true)

5. Select your instance. You should be able to start your instance by clicking "Start Computer" on the top right. After the instance is started, you can launch the GUI by clicking on **launch Ubuntu**
![instance](handout/instance.png?raw=true)

__Note: `g4dn.xlarge` instances cost $0.526 / hour, so leaving one running for a whole day will consume $12.624 worth of your AWS coupon. Remmeber to shut off the instance when you're not using it!__

6. Now you have logged into your instance! To copy your local files to the instance, directly drag them to the GUI. To open the terminal, click **Activities** at the top left in the GUI, and then click on the terminal icon at the bottom middle:
![GUI](handout/GUI.png?raw=true)

### Setting up the VM environment ###

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

### Cloning the assignment ###

11. Clone the repository with the following command: `git clone https://github.com/stanford-cs149/asst3.git`.

### Fetching your code from AWS ###

12. Once you've completed your assignment, you can download your code using the File Storage console by clicking on the double-arrow button at top left:
![file_storage](handout/file_storage.png?raw=true)
![download](handout/download.png?raw=true)