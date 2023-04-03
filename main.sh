#!/bin/bash

apiHost=$1
apiKey=$2
nodeID=$3
nodeType=$4
certDomain=$5
cfEmail=$6
cfApi=$7

if [ -z "$apiHost" ]; then
    echo -n "请输入ApiHost(如https://test.com)："
	read apiHost

	echo -n "请输入ApiKey："
	read apiKey
	
	echo -n "请输入NodeID："
	read nodeID
	
	echo -n "请输入NodeType(V2ray, Shadowsocks, Trojan)："
	read nodeType
	
	echo -n "请输入CertDomain："
	read certDomain
	
	echo -n "请输入CLOUDFLARE_EMAIL："
	read cfEmail
	
	echo -n "请输入CLOUDFLARE_API_KEY："
	read cfApi
	
fi

config="
Log:
  Level: warning # Log level: none, error, warning, info, debug 
  AccessPath: # /etc/XrayR/access.Log
  ErrorPath: # /etc/XrayR/error.log
DnsConfigPath: # /etc/XrayR/dns.json # Path to dns config, check https://xtls.github.io/config/dns.html for help
RouteConfigPath: #/etc/XrayR/route.json # Path to route config, check https://xtls.github.io/config/routing.html for help
InboundConfigPath: #/etc/XrayR/custom_inbound.json # Path to custom inbound config, check https://xtls.github.io/config/inbound.html for help
OutboundConfigPath: #/etc/XrayR/custom_outbound.json # Path to custom outbound config, check https://xtls.github.io/config/outbound.html for help
ConnectionConfig:
  Handshake: 4 # Handshake time limit, Second
  ConnIdle: 30 # Connection idle time limit, Second
  UplinkOnly: 2 # Time limit when the connection downstream is closed, Second
  DownlinkOnly: 4 # Time limit when the connection is closed after the uplink is closed, Second
  BufferSize: 64 # The internal cache size of each connection, kB
Nodes:
  -
    PanelType: \"NewV2board\" # Panel type: SSpanel, V2board, NewV2board, PMpanel, Proxypanel, V2RaySocks
    ApiConfig:
      ApiHost: \"$apiHost\"
      ApiKey: \"$apiKey\"
      NodeID: $nodeID
      NodeType: $nodeType # Node type: V2ray, Shadowsocks, Trojan
      Timeout: 30 # Timeout for the api request
      EnableVless: false # Enable Vless for V2ray Type
      EnableXTLS: false # Enable XTLS for V2ray and Trojan
      SpeedLimit: 0 # Mbps, Local settings will replace remote settings
      DeviceLimit: 0 # Local settings will replace remote settings
    ControllerConfig:
      ListenIP: 0.0.0.0 # IP address you want to listen
      UpdatePeriodic: 100 # Time to update the nodeinfo, how many sec.
      
      CertConfig:
        CertMode: dns # Option about how to get certificate: none, file, http, dns. Choose "none" will forcedly disable the tls config.
        CertDomain: \"$certDomain\" # Domain to cert
        Provider: cloudflare # DNS cert provider, Get the full support list here: https://go-acme.github.io/lego/dns/
        Email: test@me.com
        DNSEnv: # DNS ENV option used by DNS provider
          CLOUDFLARE_EMAIL: $cfEmail
          CLOUDFLARE_API_KEY: $cfApi
"


echo "$config" > config.yml
echo "配置文件config.yml在当前目录生成"



folder="/etc/XrayR"

if [ $(id -u) -ne 0 ]; then
    echo "当前用户不是root，请自行将config.yml移动至$folder目录下"
    exit 1
else
	
	# 检查文件夹是否存在
	if [ -d "$folder" ]; then
		cp ./config.yml /etc/XrayR
		echo "配置文件已经移动至$folder"
	else
		echo "XrayR还未安装，移动失败！"
	fi
	
fi
