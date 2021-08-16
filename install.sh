#!/bin/bash

# Dirs
mkdir /opt/osmocom2g
mkdir /opt/osmocom2g/.osmocom
mkdir /opt/radios

#Dependencies
apt update && sudo apt upgrade -y
apt install -y net-tools libusb-1.0-0-dev libuhd-dev uhd-host cmake autoconf make git libtool build-essential pkg-config libpcsclite-dev libtalloc-dev libortp-dev libsctp-dev libmnl-dev libdbi-dev libdbd-sqlite3 libsqlite3-dev sqlite3 libc-ares-dev gnutls-bin libghc-gnutls-dev libbctoolbox-dev libsofia-sip-ua-dev automake dahdi-source libsctp-dev libconfig++-dev libconfig-dev libmbedtls-dev cpufrequtils asterisk libtalloc-dev libpcsclite-dev libgtp-dev  libmnl-dev

# Files
cp lime-configs/* /opt/osmocom2g/.osmocom
cp lime-configs/sip.conf /etc/asterisk/
cp lime-configs/extensions.conf /etc/asterisk
cp usrp-configs/osmo-trx-uhd.cfg /opt/osmocom2g/.osmocom

# Install Opencore-amr
cp opencore-amr-0.1.5.tar.gz /opt/osmocom2g
cd /opt/osmocom2g
tar xvzf opencore-amr-0.1.5.tar.gz && cd opencore-amr-0.1.5 && ./configure && make && make install && ldconfig

# Install SoapySDR
cd /opt/radios
git clone https://github.com/pothosware/SoapySDR
cd /opt/radios/SoapySDR
mkdir build && cd build && cmake .. && make -j4 && make install && ldconfig

# Install SoapyUHD
cd /opt/radios
git clone https://github.com/pothosware/SoapyUHD
cd /opt/radios/SoapyUHD
mkdir build && cd build && cmake .. && make -j4 && make install && ldconfig

# Install LimeSuite
add-apt-repository -y ppa:myriadrf/drivers
apt update
apt install -y limesuite liblimesuite-dev limesuite-udev limesuite-images soapysdr-tools soapysdr-module-lms7

# Install BladeRF
cd /opt/radios
git clone https://github.com/nuand/BladeRF
cd /opt/radios/BladeRF
mkdir build && cd build && cmake .. && make -j4 && make install && ldconfig

# Install SoapyBladeRF
cd /opt/radios
git clone https://github.com/pothosware/SoapyBladeRF
cd /opt/radios/SoapyBladeRF
mkdir build && cd build && cmake .. && make -j4 && make install && ldconfig

# Install osmocore
cd /opt/osmocom2g
git clone https://github.com/osmocom/libosmocore
cd /opt/osmocom2g/libosmocore
autoreconf -i && ./configure && make && make install && ldconfig

# Install osmo-abis
cd /opt/osmocom2g
git clone https://github.com/osmocom/libosmo-abis
cd /opt/osmocom2g/libosmo-abis
autoreconf -i && ./configure && make && make install && ldconfig

# Install osmo-netif
cd /opt/osmocom2g
git clone git://git.osmocom.org/libosmo-netif
cd /opt/osmocom2g/libosmo-netif
autoreconf -fi && ./configure && make && make check && make install && ldconfig

# Install osmo-bts 1.2.1
cd /opt/osmocom2g
git clone git://git.osmocom.org/osmo-bts
cd /opt/osmocom2g/osmo-bts
git checkout 1.2.1 && autoreconf -i && ./configure --enable-trx && make && make install && ldconfig

# Install openbsc 1.1.0
cd /opt/osmocom2g
git clone git://git.osmocom.org/openbsc
cd /opt/osmocom2g/openbsc
git checkout 1.1.0
cd /opt/osmocom2g/openbsc/openbsc/
autoreconf -fi && ./configure && make && make install && ldconfig

# Install osmo-trx 1.2.0
apt install -y --no-install-recommends libusb-1.0-0-dev libboost-dev
apt install -y libuhd-dev uhd-host libfftw3-dev libsndfile1-dev libboost-regex-dev libboost-system-dev libboost-thread-dev
cd /opt/osmocom2g
git clone git://git.osmocom.org/osmo-trx
cd /opt/osmocom2g/osmo-trx
git checkout 1.2.0 && autoreconf -i && ./configure --with-lms && make && make install && ldconfig

# Other
apt install -y libsofia-sip-ua-dev libsofia-sip-ua-glib-dev libsofia-sip-ua-glib3 libsofia-sip-ua0 sofia-sip-bin sofia-sip-doc

# Install GPRS osmocom
# Install osmo-sip 1.3.0
cd /opt/osmocom2g
git clone https://github.com/osmocom/libosmo-sccp.git
cd /opt/osmocom2g/libosmo-sccp
git checkout 1.3.0 && autoreconf -fi && ./configure && make && make install && ldconfig

# Install osmp-pcu
cd /opt/osmocom2g
git clone git://git.osmocom.org/osmo-pcu.git
cd /opt/osmocom2g/osmo-pcu
autoreconf -fi && ./configure && make && make install && ldconfig

# Install osmo-hlr
cd /opt/osmocom2g
git clone https://github.com/osmocom/osmo-hlr.git
cd /opt/osmocom2g/osmo-hlr
autoreconf -fi && ./configure && make && make install && ldconfig

# Install libgtpnl
cd /opt/osmocom2g
git clone git://git.osmocom.org/libgtpnl.git
cd /opt/osmocom2g/libgtpnl
git checkout 1.2.0 && autoreconf -fi && ./configure && make && make install && ldconfig

# Install osmo-ggsn 1.6.0
cd /opt/osmocom2g
git clone https://github.com/osmocom/osmo-ggsn.git
cd /opt/osmocom2g/osmo-ggsn
git checkout 1.6.0
cd /opt/osmocom2g/osmo-ggsn
autoreconf -fi
cd /opt/osmocom2g/osmo-ggsn
./configure --enable-gtp-linux
cd /opt/osmocom2g/osmo-ggsn
make
cd /opt/osmocom2g/osmo-ggsn
make install
cd /opt/osmocom2g/osmo-ggsn
ldconfig

# Install osmo-sip-connector 1.3.0
cd /opt/osmocom2g
git clone https://github.com/osmocom/osmo-sip-connector.git
cd /opt/osmocom2g/osmo-sip-connector
git checkout 1.3.0 && autoreconf -fi && ./configure && make && make install && ldconfig

# Install osmo-sgsn 1.6.2
cd /opt/osmocom2g
git clone https://github.com/osmocom/osmo-sgsn.git
cd /opt/osmocom2g/osmo-sgsn
git checkout 1.6.2
cd /opt/osmocom2g/osmo-sgsn
autoreconf -fi
cd /opt/osmocom2g/osmo-sgsn
./configure
cd /opt/osmocom2g/osmo-sgsn
make
cd /opt/osmocom2g/osmo-sgsn
make install
cd /opt/osmocom2g/osmo-sgsn
ldconfig

# Fix osmo-pcu
# Install osmocore 1.4.0
cd /opt/osmocom2g
git clone https://github.com/osmocom/libosmocore
cd /opt/osmocom2g/libosmocore
git checkout 1.4.0 && make clean && autoreconf -i && ./configure && make && make install && ldconfig 

printf "Done!""%s\n"

