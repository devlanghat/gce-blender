FROM ubuntu:20.04
RUN apt-get update && apt-get -y --no-install-recommends install libglu1 libxi6 libxrender1 gcc wget gnupg software-properties-common curl xz-utils apt-transport-https ca-certificates nvidia-cuda-toolkit && rm -rf /var/lib/apt/lists/*
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get -y install google-cloud-sdk && rm -rf /var/lib/apt/lists/*
RUN mkdir blender
RUN wget -nv https://mirror.clarkson.edu/blender/release/Blender2.91/blender-2.91.0-linux64.tar.xz && tar xvf blender-2.91.0-linux64.tar.xz --strip-components=1 -C blender && rm blender-2.91.0-linux64.tar.xz
COPY scripts/* ./
RUN chmod +x /render.sh
CMD /render.sh
