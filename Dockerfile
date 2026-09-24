# GPU対応のPyTorch公式イメージをベースに指定
FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime

# タイムゾーン等の対話的プロンプトを抑止
ENV DEBIAN_FRONTEND=noninteractive

# soundfileに必要なOSライブラリ(libsndfile1)および基本ツールをインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    libsndfile1 \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# pipのアップグレード
RUN pip install --no-cache-dir --upgrade pip

# requirements.txt をコピーしてライブラリをインストール
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt

# 作業ディレクトリ
WORKDIR /workspace