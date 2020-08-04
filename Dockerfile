FROM alpine

ADD cat << EOF > /root/config.json
{
  "inbounds": [
    {
      "port": 8888,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "c95ef1d4-f3ac-4586-96e9-234a37dda068",
            "alterId": 8
          }
        ]
      },
      "streamSettings": {
        "network":"ws"
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
EOF

ENV CONFIG=/root/config.json

RUN apk update && apk --no-cache add ca-certificates unzip && \
    wget -c https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    unzip v2ray-linux-64.zip && rm -f v2ray-linux-64.zip && \
    chmod 700 v2ray v2ctl
    
CMD ./v2ray -config $CONFIG
