#!/usr/bin/env bash

sudo su - ;

#docker rm $(docker ps -a -q)
docker volume create --name=shared-data ;

# 1. Run shared container.
CID=$(docker run -t -d --mount source=shared-data,target=/var/local centos:latest) ;
CID_SHORT=$(echo "${CID}" | cut -c1-12)

# 2. Create ssh config and github private key.
cat >/var/lib/docker/volumes/shared-data/_data/ssh_config <<EOL
Host github.com
   	StrictHostKeyChecking no
   	UserKnownHostsFile=/dev/null
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_key
EOL

cat >/var/lib/docker/volumes/shared-data/_data/github_key <<EOL
-----BEGIN RSA PRIVATE KEY-----
MIIJJwIBAAKCAgEAxwvX4rRTk7MVlljODmxCTvhbXeG92cU1bG0gCo3vF5iDQqyJ
L30sfOXnQqb7/7nplLHfGyqS5o4j1oH6RMQCoR9AizZ74b11mz2xAEMtoTWYcwoF
bkwShr3/A6xlUhM3buHVpN6pYiAUjcmtx8ghV/CsXGUEMHst8QwhUenlZ6A9H+nI
S4lgHd1PhDbWn5QXWQRdYzprWPX4dl/Ho+EWMl2Uo0/KaO/eAn3+JfEIkNix4jF8
Mm3zz9fYdggyZ4Kr2ORZsLLo/3mMOc5jx9r6ltyLwWQfL+poOtvJoPzULq3epp2C
R9L8epUYDSyyscuEvBS4fQwlrsGqtpHIIWSR8H+/Q62jR5WkIL80Pzq23h2InxXl
J781Er41Qiy9TJ7HtCGjMDAPzbg5eR/LcZxmC+oEbm1W/a5jSXYgobCQI5FCSw82
2CHNSmp62auVqeon8sh0s2J3MzwNkfxtNmjOTQUeinSjnlXrEiEby54Cd6vD3STp
3dkkhRFpJgbSa3LQ81ZwKllqSL8xDhfK9LjbA83sd3SfGwdpWBFPPqZzX0vMWHjD
8O8a8JMQnN/2fSsx3FLx6SG3Yg+V16bMSDi42+WU4AZdwIpzCAePCDuhpEIDkyx5
NV19duaxeLfs+YOv5UqP9I20aj3S2g+9sh421PhIVO+NCpyrg6bczf09B6UCASUC
ggIACsJesk7vwsto816/B7LTJtz+BRMfBNo6PTZUwkzcfdDkgCUAfxuF3TzcEXDP
We5fpyw1ksQH8MlpuJFneVa0CLWUyUE3IPV7+o22imR/AcuLszD5X+hvtEGfFPSP
2uxIL4HUMmzmj661AL7LH45G/dWoc7Ju7d0lE/LRXl+riQ+UmfD2EevAAZ1CkYZs
d1Qc8A4S4sTjNT26Z0NykzyZaoGZVO+OZomBn0UUqBrd3lDnBU7IcW26JukSnpio
x1Mr4jXbVajOUv+mtwQ8vrHkCCeY2gVpeDYvJcaw8/H9oaiIk2J1vrF1bmjsixcs
QPY+hrUDDa2hLAp37jFkw4jlSyyyd+StygOe3YbURjF4vw4/HN3NDmEjoUnfaNt2
UNdDOoUWePEwzFVxP1P7V/hSugUl2KqT3Xk9Jee2HDmhIS0Rh07WmMMe/+TxnRPk
ESD8qIYIkYEYHkFILTUMkvk2jxw+Xce+7w5hGa8Ho1ZCTQp87UQ86azXLFHSzCcH
kqveq/+eXfbPTPrGWbXMIVil/LwmL6/Z50zboMVJRvgnCIXm6vfjVl8/qClfRA+1
0gVocye8lX8cCxtyn6rzykjGUsaNss0fvznEwMsf4IQ44id8uWNRyBdxgwde9we3
p5x3zA/eu//I/WbWuNPIKwMel6yawfkAIZfp93bzfQwBwSUCggEBAPQZ1LnJfU+c
+MM5L81s5CdV1RBS3bHUgNbFSXdx09+amMooelhutFWQRTpkxnz+1TfROTQziXfL
EquiX0sBO/hz6hvhjlxUupe+dZhDQoKKQlsbEVxwmJCSCR68ZmV9oSJXuZqTR1mm
+xDWWsqn1MUJrtzTefUiGZYMSh+ARPH//dvyXE9hrqKYcKqisRjGwK0VSSaPy4kv
MTmcdvkGhReoS6zhZiVn1jx7ilyrTdYIYF9U82Kd1PQqercuWEnzZvnr4cDaSPMs
/2tLuY54ZCaskZIjB398ytsq+6mzUL2Na5v8mbpIXLsVeYBl4mvQJ/dcwmAbM8Xd
SEG8tlDsgecCggEBANC/xO1KsQMMJb2j/NoQK26jM/5AwAhNahDK5Nk+oTDRYLla
+GmaVTX6IFO8z61sxVL3DOVz8vOs+YvVODtqAdcKGcDTP6u7EcdGiiNXKoVbgr27
HjHIavPERIhIMQDfVFhFCerEEHI/u+o4IxeQEaSzCNmvgOZ1t5GhGxVGDRU5h4GM
A7QNif1DIcnn2rgVf4gUvBjQGHBbCJXnJr6avIb0EeH0zOeZc1kyp2CngfEdKZR8
KA+Sv5+i0xT/0axweZJrknK4JeqOGe51lR8M6EDTm+ztOCxMtAMpov90C/d6Ooj6
xNdlvZQ5BUFgs/iwtwe8jhDvaVxl2UyHjk4wEJMCggEBAOBPFoE1sWvArT3F2OZI
YvO2qBzWhoe8WreE27neOFDu7UQlMie/rKGnKtu2jOGQOY08zMgvW7owOquOSbqL
gzdVwl7PRIwyLuxOJt7xsr0lGmGOfqf4w4vEdxVTLaler76xeh9W5559xB1PWllb
8/NVAYymp2uiy2dJkDifYfMilj+8HXlgrlA5DZXhm9GUCv/qC94+8mJit5y5SrtS
GW+vaCJSlTchJbsJvWnphcuY/pzKmnZL2HGqfpp9nT0JLjHD/+Gl/diKNtFMgP91
jHaQvR6BDc8YumiIXOEhURzi0ZZCELkEOYlSAPKHIxb2oUQruYi/DPsCsRnQAXrL
fkkCggEASVgimI/dVBkGV2MhfQyZo2nGKOZRTwZxX9iVmG/zcgRgQR/2akr7WCdz
JFcYiQqKhO8Eh/hOcUqc3hp7in8xFDP7Nelbj11nHICRZlzlbSAnBGRWt4ubMw2b
idQs5KF+f+Dnzwad/qDFe86I3sPqhfm3AGBCC8h+xHbgAI478rNZH628HKrPnixX
+tTr+30szvKHRv0Bqu+NZRndLjZd6joUHvUlZiEohx+il5TMylZat6E+ggMgu4w8
U3x6Gf4BM3HnWL09wR0rtKXacrGCCPBnN5GeHWcO0K3DpdyqQjHdNwv/+Kc0xWAk
cOqgGRt+lAP6kFQeGYuRiZdpWb3cTwKCAQEA5pej9tpPuBQDoynm460FaOJFBqtS
7hejXH7Ec0ekmdG+4N7Lsi56IffAyzwJ2zQBUZrgDUInWVKhI/R2OED3fXguJSD5
pw8zUPNKYqkd3H5c2iY5RPVupuM1jAnQiaEZLLOBYkTxni1JHfbUQ0wCTV40DRV8
B00nCYGRJ/hCdEfPJf1hhc+MGoN7LM7cEZMR5pIDqfHilvR0b0+0k+yFP0bSlJ/W
be1d8miW9suf+5oN5vu90LzLO9qyugngvBTC4jiUK08wyrSpOXbiR3ZjFaWbdKb4
ccZTshYQifP4FzLuznRoZ+d3O4H0Xmlb9qG4l2NI6bzO7ToWPQreU/3JgQ==
-----END RSA PRIVATE KEY-----
EOL

# 3. Share ssh config and github private key.
docker exec -i ${CID_SHORT} mkdir ~/.ssh ;

docker exec -i ${CID_SHORT} cp /var/local/ssh_config ~/.ssh/config ;
docker exec -i ${CID_SHORT} chmod 644 ~/.ssh/config ;

docker exec -i ${CID_SHORT} cp /var/local/github_key ~/.ssh/github_key ;
docker exec -i ${CID_SHORT} chmod 600 ~/.ssh/github_key ;

# 4. Update system.
docker exec -i ${CID_SHORT} yum -y update ;
docker exec -i ${CID_SHORT} yum -y install git ;

# 5. Install image configs for docker.
docker exec -i ${CID_SHORT} rm -drf /var/local/repos/infrastructure-docker ;
#docker exec -i ${CID_SHORT} ssh -o "StrictHostKeyChecking no" git@github.com ;
docker exec -i ${CID_SHORT} git clone git@github.com:jackblackjack/infrastructure-docker.git /var/local/repos/infrastructure-docker ;

# 6. Install docker-compose
mkdir -p /opt/bin ;
curl -L "https://github.com/docker/compose/releases/download/1.19.0/docker-compose-$(uname -s)-$(uname -m)" -o /opt/bin/docker-compose ;
chmod +x /opt/bin/docker-compose ;

# 7. Build project images.
#cd /var/lib/docker/volumes/shared-data/_data/repos/infrastructure-docker/db/redis/ && /opt/bin/docker-compose up -d;
