---
title: ELK 集成
date: 2025-05-13 14:29:07
tags:
- ELK
- Elasticsearch
- Logstash
- Kibana
- Docker
categories:
- ELK
---

# 安装 E.L.K. 服务
## 安装 Elasticsearch
[Manual-Install-Elasticsearch.md](Manual-Install-Elasticsearch.md)  

## 安装 Logstash
[Manual-Install-Logstash.md](Manual-Install-Logstash.md)  

## 安装 Kibana
[Manual-Install-Kibana.md](Manual-Install-Kibana.md)  
安装完成后，先不要配置，待组网完成后配置 Elasticsearch

# 集成 ELK
## 组网
```shell
docker network create net-elk
docker network connect net-elk elasticsearch
docker network connect net-elk logstash
docker network connect net-elk kibana
```

## Kibana 集成 Elasticsearch
选择 Manually Configure Kibana 选项，然后输入以下配置即可：
http://elasticsearch:9200

---
todo 后续深度集成ELK 并提供Example
