# What is candide?
Candide is a PaaS (Platform as a Service) designed to run Drupal and Wordpress sites.

# Why would I want to use it?
Candide provides a dev server environment mirroring a staging and production server environment. This helps negate the "works on my machine" conditions. Even more, it quickly provides a fully configured virtual server with root access.

In addition, creating a new site is easy and can be performed using only a three letter site code and the production url. With only these two pieces, you will have unique user account that includes apache vhost, solr, and database configuration.

Candide lets you focus on developing multiple websites concurrently, while abstracting the server configuration.

# Quick Start Guide
Download and install the latest version of Virtualbox and Virtualbox Extension Pack:

https://www.virtualbox.org/wiki/Downloads


Download and install the latest version of vagrant:

http://downloads.vagrantup.com


Reboot your machine to ensure the kernel drivers load properly.


From the command line, ensure vagrant is installed:

<code>vagrant -v</code>


Next install the following vagrant plugins using these commands:

<code>vagrant plugin install vagrant-omnibus</code>

<code>vagrant plugin install vagrant-berkshelf</code>


Add the following entry to your hosts file:

<code>33.33.33.10                abcdv defdv ghidv jkldv mnodv</code>


Clone the Candide project to your local machine:

<code>git clone git@github.com:coloradobum/candide.git candide</code>


Start up the virtual machine

<code>cd candide</code>

<code>vagrant up</code>


The base image will take about 10 minutes to download and the first build will take about 15 minutes, so grab a cup of coffee. You only need to download the base image once, even after destroying the virtual machine via vagrant destroy.

When the build is complete, open a browser and navigate to one of the test sites below:

<code>http://abcdv</code>

<code>http://defdv</code>

<code>http://ghidv</code>

<code>http://jkldv</code>

<code>http://mnodv</code>


The User 1 credentials are the same as the sitename. For example:

username: abcdv

password: abcdv


To shutdown the virtual machine(frees up diskspace but slower to start):

<code>vagrant halt</code>


To put the virtual machine to sleep (uses diskpace, but faster to start):

<code>vagrant suspend</code>


To activate the virtual machine from a halt or powerdown (either way the startup process will be much faster than the original build step):

<code>vagrant up</code>


To destroy the virtual machine, delete all files and start with a fresh server:

<code>vagrant destroy</code>

<code>vagrant up</code>

# Where do I go from here?
Check out the wiki for task specific details:
https://github.com/coloradobum/candide/wiki

Topics Covered:
How do I create a new account?
How do I view the code and make changes?
How do I connect to the mysql database?
How do I use solr?
Can I use something other than virtualbox?
What's the guiding philosophy for Candide?
Roadmap for Candide.


# Author
Author:: Jeff Thomas (<jeff@bluetent.com>)
