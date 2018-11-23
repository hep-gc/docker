FROM danikam/csv2_private_web:latest

USER root

WORKDIR /jobs

ADD init_setup.sh /jobs

# Install supervisor
RUN easy_install supervisor

# Add supervisor's configuration file to the container. Note: This config file is referred by supervisord once started inside container
COPY supervisord.conf /usr/etc/supervisord.conf

# Expose needed ports
EXPOSE 80 443 444 3306 947 9618
EXPOSE 40000-40500

# Replace NETWORK_INTERFACE line in condor_config.local with the current host's IP address
#RUN /bin/bash -c public_ip=$(curl -s http://whatismyip.akamai.com/); sed -i '/^NETWORK_INTERFACE =/ d' /etc/condor/condor_config.local; LINE="NETWORK_INTERFACE = $public_ip"; FILE=/etc/condor/condor_config.local; grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE" 

# Execute supervisord as entrypoint into the container
CMD ["/usr/bin/supervisord"]