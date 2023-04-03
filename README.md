# xrayr-config
xrayr-config配置一键生成
需要配置参数：ApiHost，ApiKey，NodeID，NodeType，CertDomain，CLOUDFLARE_EMAI，CLOUDFLARE_API_KEY



手动输入配置
```
bash <(curl -sSL https://raw.githubusercontent.com/mycoffeezzz/xrayr-config/main/main.sh)
```

直接配置参数(请自行修改参数)
```
curl -sSL https://raw.githubusercontent.com/mycoffeezzz/xrayr-config/main/main.sh > main.sh
bash main.sh "ApiHost" "ApiKey" NodeID  "NodeType" "CertDomain" "CLOUDFLARE_EMAIL" "CLOUDFLARE_API_KEY" 
```


