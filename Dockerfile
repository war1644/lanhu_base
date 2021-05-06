# author duanxuqiang@jwzg.com
FROM python:3.8.9-alpine3.13

WORKDIR /tianwen

# set timezone to Shanghai
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN apk --no-cache add bash tzdata && \
    pip install -U pip && \
    pip install setuptools==45 && \
    pip install --trusted-host mirrors.aliyun.com --index-url http://mirrors.aliyun.com/pypi/simple/ six && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

COPY ./start.sh /
COPY ./site-packages.tar.gz /usr/local/lib/python3.8/
RUN tar xzvf /usr/local/lib/python3.8/site-packages.tar.gz -C /usr/local/lib/python3.8/ && rm /usr/local/lib/python3.8/site-packages.tar.gz

# RUN apk --no-cache add git 
CMD ["/start.sh"]
# RUN pip install --trusted-host mirrors.aliyun.com --index-url http://mirrors.aliyun.com/pypi/simple/ -r requirements.txt



