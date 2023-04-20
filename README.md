# Dockerfile for [tortoise-tts](https://github.com/neonbjb/tortoise-tts)

This repository contains a basic Dockerfile for [tortoise-tts](https://github.com/neonbjb/tortoise-tts), which simplifies the local installation process.

## Prerequisites

This project is GPU-intensive, so it's highly recommended to use the NVIDIA CUDA Toolkit for WSL2. Follow these steps before proceeding:

1.  Install the NVIDIA CUDA Toolkit for WSL2 from the [official guide](https://docs.nvidia.com/cuda/wsl-user-guide/index.html).
2.  Watch this [video tutorial](https://www.youtube.com/watch?v=CO43b6XWHNI) if you need additional help with the installation process.
3.  Enable integration for additional distros in Docker for Desktop by navigating to `Configuration` > `Resources` > `WSL Integration`>`Enable integration with additional distros`.

To verify if your GPU is working correctly, you can use the following Dockerfile:

```
# syntax = docker/dockerfile:1.3-labs
FROM nvidia/cuda:11.4.2-base-ubuntu20.04
RUN apt -y update
RUN DEBIAN_FRONTEND=noninteractive apt -yq install git nano libtiff-dev cuda-toolkit-11-4
RUN git clone --depth 1 https://github.com/jameswmccarty/CUDA-Fractal-Flames /src
WORKDIR /src
RUN sed 's/4736/1024/' -i fractal_cuda.cu # Make the generated image smaller
RUN make
```

Build and run the Docker container with these commands:


```
$ docker build . -t cudafractal
$ docker run --gpus=all -ti --rm -v ${PWD}:/tmp/ cudafractal ./fractal -n 15 -c test.coeff -m -15 -M 15 -l -15 -L 15
```

If everything is working correctly, it should generate an image of a fractal.
## Installation

After installing the NVIDIA CUDA Toolkit for WSL2, follow these steps to build and run the tortoise-tts Docker container:

1.  Build the Docker image:

    
    `sudo docker build -t tortoise-tts .` 
    
2.  Run the Docker container with the `--gpus all` flag:
    
    `docker run -it --gpus all --name ttscontainer tortoise-tts` 
    

Now you should have a working tortoise-tts environment inside the Docker container.
