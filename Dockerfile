# Use the official PyTorch image as the base image
FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-runtime

# Set the working directory
WORKDIR /app

# Clone the Tortoise TTS repository
copy . .

# Install the requirements
RUN pip install -r requirements.txt
RUN apt-get update && apt-get install -y libsndfile1

# Install pysoundfile (required for Windows, but it doesn't hurt to include it for all environments)
RUN pip install pysoundfile

# Run the setup script
RUN python setup.py install

# Set the entrypoint to start a bash shell
ENTRYPOINT ["/bin/bash"]
