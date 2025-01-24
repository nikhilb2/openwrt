# Use the OpenWrt rootfs image for x86_64
FROM openwrt/rootfs:x86_64

# Fix repository URLs and install packages
RUN mkdir -p /var/lock && \
	echo "src/gz openwrt_core https://downloads.openwrt.org/releases/23.05.0/targets/x86/64/packages" > /etc/opkg/distfeeds.conf && \
	echo "src/gz openwrt_base https://downloads.openwrt.org/releases/23.05.0/packages/x86_64/base" >> /etc/opkg/distfeeds.conf && \
	echo "src/gz openwrt_luci https://downloads.openwrt.org/releases/23.05.0/packages/x86_64/luci" >> /etc/opkg/distfeeds.conf && \
	echo "src/gz openwrt_packages https://downloads.openwrt.org/releases/23.05.0/packages/x86_64/packages" >> /etc/opkg/distfeeds.conf && \
	echo "src/gz openwrt_routing https://downloads.openwrt.org/releases/23.05.0/packages/x86_64/routing" >> /etc/opkg/distfeeds.conf && \
	echo "src/gz openwrt_telephony https://downloads.openwrt.org/releases/23.05.0/packages/x86_64/telephony" >> /etc/opkg/distfeeds.conf && \
	opkg update && \
	opkg install luci uhttpd openvpn-openssl iptables && \
	mkdir -p /etc/config /etc/openvpn && \
	opkg clean

# Expose default LuCI web interface port (HTTP) and OpenVPN port (UDP)
EXPOSE 80/tcp 1194/udp

# Start uHTTPd service on container start
CMD ["/bin/sh", "-c", "/etc/init.d/uhttpd start && tail -f /dev/null"]
