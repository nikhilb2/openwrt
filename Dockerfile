# Use the OpenWrt rootfs image for x86_64
FROM openwrt/rootfs:x86_64

# Update and install required packages
RUN opkg update && \
	opkg install luci uhttpd openvpn-openssl iptables && \
	mkdir -p /etc/config /etc/openvpn && \
	opkg clean

# Expose default LuCI web interface port (HTTP) and OpenVPN port (UDP)
EXPOSE 80/tcp 1194/udp

# Start uHTTPd service on container start
CMD ["/bin/sh", "-c", "/etc/init.d/uhttpd start && tail -f /dev/null"]
