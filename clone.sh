cd freeswitch
rm -rf freeswitch; git clone https://github.com/signalwire/freeswitch.git
rm -rf libks; git clone https://github.com/signalwire/libks.git
rm -rf signalwire-c; git clone https://github.com/signalwire/signalwire-c.git
rm -rf spandsp; git clone https://github.com/freeswitch/spandsp.git
rm -rf sofia-sip; git clone https://github.com/freeswitch/sofia-sip.git
rm -rf mod_mosquitto; git clone https://github.com/freeswitch/mod_mosquitto.git
cd ..
cd opensips
rm -rf opensips
git clone https://github.com/opensips/opensips.git
cd opensips
git submodule update --init
cd ..
git clone https://github.com/opensips/opensips-cli.git
cd ..
