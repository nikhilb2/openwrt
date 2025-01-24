# Use the OpenWrt rootfs image for x86_64
FROM openwrt/rootfs:x86_64

# Create necessary directories and update repository URLs
RUN mkdir -p /var/lock && \
	echo "src/gz openwrt_core https://downloads.openwrt.org/releases/23.05.0/targets/x86/64/packages" > /etc/opkg/distfeeds.conf && \
	echo "src/gz openwrt_base https://downloads.openwrt.org/releases/23.05.0/packages/x86_64/base" >> /etc/opkg/distfeeds.conf && \
	echo "src/gz openwrt_luci https://downloads.openwrt.org/releases/23.05.0/packages/x86_64/luci" >> /etc/opkg/distfeeds.conf && \
	echo "src/gz openwrt_packages https://downloads.openwrt.org/releases/23.05.0/packages/x86_64/packages" >> /etc/opkg/distfeeds.conf && \
	echo "src/gz openwrt_routing https://downloads.openwrt.org/releases/23.05.0/packages/x86_64/routing" >> /etc/opkg/distfeeds.conf && \
	echo "src/gz openwrt_telephony https://downloads.openwrt.org/releases/23.05.0/packages/x86_64/telephony" >> /etc/opkg/distfeeds.conf && \
	opkg update && \
	opkg install luci uhttpd && \
	mkdir -p /etc/config /etc/openvpn

# Expose default LuCI web interface port (HTTP)
EXPOSE 80/tcp

# Start uHTTPd service on container start
CMD ["/bin/sh", "-c", "/etc/init.d/uhttpd start && tail -f /dev/null"]
