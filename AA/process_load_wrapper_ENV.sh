#!/bin/bash
##
## Created:   2016-02-15
## Creator:   Chris Cousin (ccousin@agentace.com)
## Modified:  2016-02-15
## Version:   v1.0
##
##

echo -e "\e[0;32mThis script is deisgned to configured your basic local environment
to be able to run the rets process_load_wrapper on a local ubuntu VM.
This script will ask you a few questions in order to setup things properly.
This script will also install a few packages which may require for you to enter
your password in order to obtain sudo.  This script assume that you have already
cloned git@gitlabs.agentace.com:agentace/rets.git somewhere on your system
----------------------------------------------------------------------------
\e[0m"

sudo apt-get -y install php5-curl php5-cli

if [ -e /opt/feeds/ ] && [ -e /opt/data/rets ] && [ -e /opt/log ]
  then
    echo "/opt/feeds /opt/data /opt/log already exist skipping creation of DIRs"
    echo "Have you already setup your environment and would like to stop this script? (Y/N): "
    read $CONT
      if [[ $CONT =~ ^[Yy]$ ]]
        then
          echo "Stopping script"
          exit 1
        else
          echo "Will continue with rets environment setup"
     fi
  else
    sudo mkdir -p /opt/feeds /opt/data/ /opt/log
fi

if [ `cat /etc/passwd |grep otto` 2> /dev/null ]
  then
    echo "otto already exists"
  else
    echo "creating otto user and adding to sudoers"
    sudo adduser otto
    sudo adduser otto sudo
fi

sudo chown -R $(whoami):otto /opt/feeds /opt/data /opt/log
cd /opt/feeds
echo "Please enter the path of your rets repo: "
read RETS_LOCAL_REPO
ln -s $RETS_LOCAL_REPO rets
cd /opt/feeds/rets/
cd $RETS_LOCAL_REPO
ln -s /opt/data/rets csv

echo "Your rets environment has been configured to run all the scripts within the rets repo"
echo DONE
exit 0
