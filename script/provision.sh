#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

if [ ! -f ~/vagrant-already-provisioned ]; then
  #/tmp/vagrant-already-provisioned gets created by inline script that gets touched after puppet finished

  # Set the Timezone to something useful
  echo "America/Chicago" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

  # Update the server
  apt-get update --fix-missing

  # Install the essentials
  apt-get -y install build-essential git-core unzip xvfb firefox chromium-browser ruby1.9.1 ruby1.9.1-dev libxml2-dev libxslt1-dev qt4-qmake libqtwebkit-dev libicu48

  gem install bundler pry

  mkdir -p /home/vagrant/downloads
  mkdir -p /home/vagrant/bin
  chown -R vagrant:vagrant /home/vagrant/bin

  if [ -f "/home/vagrant/bin/chromedriver" ]; then
    echo "Chromedriver already installed"
  else
    echo "export PATH=\"/home/vagrant/bin:$PATH\"" >> /home/vagrant/.profile
    echo "export PATH=\"/home/vagrant/bin:$PATH\"" >> /home/vagrant/.zshenv
    wget -q http://chromedriver.googlecode.com/files/chromedriver_linux64_21.0.1180.4.zip
    unzip chromedriver_linux64_21.0.1180.4.zip
    chown vagrant:vagrant chromedriver && mv chromedriver /home/vagrant/bin/chromedriver
  fi
fi
