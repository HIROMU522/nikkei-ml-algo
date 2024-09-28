# ベースイメージの設定
FROM python:3.8
RUN apt-get update && apt-get install -y sudo wget vim curl gawk make gcc
#
RUN sudo curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
RUN sudo apt-get install -y nodejs
RUN apt install libaio1

ENV ORA_TZFILE='timezlrg_35.dat'
ENV ORA_SDTZ='+09:00'
#

# talibのインストール
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
    tar -zxvf ta-lib-0.4.0-src.tar.gz && \
    rm ta-lib-0.4.0-src.tar.gz && \
    cd ta-lib && \
    ./configure --prefix=/usr && \
    make && \
    make install && \
    cd .. && \
    rm -r ta-lib

# 必要なパッケージのインストール
RUN pip install --upgrade pip && \
    pip install plotly \
    pip install plotly_express \
    pip install japanize-matplotlib \
    pip install jupyterlab \ 
    pip install --upgrade numpy \
    pip install pandas \
    pip install TA-Lib \
    pip install yfinance \
    pip install mplfinance \
    pip install tensorflow \
    pip install keras \
    pip install -U kaleido \
    pip install torch \
    pip install transformers \
    pip install openpyxl \
    pip install seaborn \
    pip install shap \
    pip install scikit-learn 

#作業ディレクトリ
RUN mkdir -p /home/work
WORKDIR /home/work

# JupyterLabを起動
CMD ["jupyter", "lab"]
