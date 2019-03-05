FROM python:3.5-slim-stretch

LABEL author.name="Shin Yang" \
      author.email="ityoung@foxmail.com" \
      version="0.1" \
      description="Python 3.5-slim-stretch with MKL installed."

ENV LD_LIBRARY_PATH=/opt/intel/lib/intel64:/opt/intel/mkl/lib/intel64:${LD_LIBRARY_PATH}

RUN  sed -i 's/deb.debian.org/ftp.cn.debian.org/g' /etc/apt/sources.list \
  && sed -i 's/security.debian.org/ftp.cn.debian.org/g' /etc/apt/sources.list \
  && apt-get update -y \
  && apt-get install -y wget gnupg apt-transport-https \
  && wget --quiet -O - https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB | apt-key add - \
  && sh -c 'echo deb https://apt.repos.intel.com/mkl all main > /etc/apt/sources.list.d/intel-mkl.list' \
  && apt-get update -y \
  && apt-get install -y intel-mkl-64bit-2019.1-053 \
  && apt-get clean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*
