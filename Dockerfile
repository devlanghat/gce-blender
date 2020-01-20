FROM ubuntu:18.04
RUN apt-get update && apt-get -y --no-install-recommends install libglu1 libxi6 libxrender1 gcc wget gnupg software-properties-common
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get install -y apt-transport-https ca-certificates
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get -y install google-cloud-sdk
RUN wget -nv https://mirror.clarkson.edu/blender/release/Blender2.81/blender-2.81a-linux-glibc217-x86_64.tar.bz2
RUN mkdir blender
RUN tar xvjf blender-2.81a-linux-glibc217-x86_64.tar.bz2 --strip-components=1 -C blender
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
RUN mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN apt-key adv --no-tty --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
RUN add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install cuda-drivers
COPY scripts/* ./
RUN chmod +x /render.sh
CMD /render.sh
