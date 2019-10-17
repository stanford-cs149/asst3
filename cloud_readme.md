# Google Cloud Platform Setup Instructions #

For performance testing, you will need to run it on a VM instance on the Google Cloud Platform (GCP). We've already sent you student coupons that you can use for billing purposes. Here are the steps for how to get setup for running on GCP.

NOTE: For those working in teams, it might be desirable for both students to use the same virtual machine. To do so, only one of you should first create the VM instance following the instructions below. Then, follow the instructions at https://cloud.google.com/compute/docs/access/granting-access-to-resources to grant access to your partner.

NOTE #2: __Please don't forget to SHUT DOWN your instances when you're done with your work for the day!  The GPU-enabled cloud VM instances you create for this assignment cost approximately $0.50 per hour.  Leaving it on accidentally for a day could quickly eat up your $50 per student quota for the assignment.__

NOTE #3: __Update your GPU quota (all regions) under IAM & admin ASAP, as new projects need approval for GPU quota in GCP which could block you from starting.__ See https://cloud.google.com/compute/docs/gpus/#restrictions for more details.
   
### Creating a VM with a GPU ###
      
1. Now you're ready to create a VM instance. Click on the button that says `Create Instance`. Fill out the form such that your cloud-based  VM has the following properties: 
  * Region __us-west1__ (Oregon)
  * Type n1-standard-4 (__4 vCPUs__, __15 GB__ memory) 
  * Ubuntu __18.04 LTS__  
  * At least a __20GB__ Standard persistent disk.
  * 1 K80 GPU (see instructions below)
  
To the right of the (vCPU selection, there's a link titled `Customize`. Click this link to see additional instance configuration options.  You see a UI like that shown in the image below.  Make sure you add 1 NVIDIA K80 GPU instance.

![GPU instance creating](handout/gpu_instance.png?raw=true)

Notice the __>$300 monthly cost if you don't shutdown your instance.__

2. Click `Create` to create a VM instance with the above parameters. Now that you've created your VM, you should be able to __SSH__ into it. Either open it from the VM instance page (the one that shows a list of all your VM instances) or use the `gcloud compute ssh` command from your local console or the Google Cloud shell). For example:
~~~~
gcloud compute ssh MY_INSTANCE_NAME
~~~~

You can find `MY_INSTANCE_NAME` in the *VM instances* page.

3. Once you SSH into your VM instance, you'll want to install whatever software you need to make the machine a useful development environment for you.  For example we recommend:
~~~~
sudo apt update
sudo apt install emacs25
sudo apt install make
sudo apt install g++
~~~~

### Installing CUDA ###    

4. Now you need to download the CUDA 10 runtime from NVIDIA. SSH into your GCP instance and run the following:

~~~~
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda
~~~~ 
 
5. `nvcc` is the NVIDIA CUDA compiler. The default install locates CUDA binaries in `/usr/local/cuda/bin/`, so you'll want to add this directory to your path.  For example, from a bash shell that would be:

~~~~
export PATH=$PATH:/usr/local/cuda/bin
~~~~    

In general we recommend that you perform this `$PATH` update on login, so you can add this line to the end of your `.bashrc` file.  Don't forget to `source .bashrc` if you want to have this modification take effect without logging out and back in to the instance.

At this point CUDA should be installed and you should be able to run the `nvidia-smi` command to make sure everything is setup correctly.  The result of the command should indicate that your VM has one NVIDIA K80 GPU.

~~~~
kayvonf@asst4demo:~$ nvidia-smi
Sat Feb 16 19:46:27 2019       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 410.79       Driver Version: 410.79       CUDA Version: 10.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Tesla K80           Off  | 00000000:00:04.0 Off |                    0 |
| N/A   50C    P0    68W / 149W |      0MiB / 11441MiB |    100%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
~~~~

If you're confused about any of the steps, having problems with setting up your account or have any additional questions, reach us out on Piazza!
  
__Again, please don't forget to SHUT DOWN your instances when you're done with your work for the day!__
