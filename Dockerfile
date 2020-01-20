FROM ubuntu:18.04
RUN apt-get -y --no-install-recommends install gnupg software-properties-common
RUN apt-key adv --no-tty --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
RUN add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
RUN apt-get update && apt-get -y install libglu1 libxi6 libxrender1 gcc wget
RUN wget https://mirror.clarkson.edu/blender/release/Blender2.81/blender-2.81a-linux-glibc217-x86_64.tar.bz2
RUN mkdir blender
RUN tar xvjf blender-2.81a-linux-glibc217-x86_64.tar.bz2 --strip-components=1 -C blender
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
RUN mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install cuda
COPY scripts/* ./
CMD ["render.sh"]
