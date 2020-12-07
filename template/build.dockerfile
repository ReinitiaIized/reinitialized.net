FROM ubuntu:20.04

RUN curl https://releases.hashicorp.com/packer/1.6.5/packer_1.6.5_linux_amd64.zip -o packer.zip
RUN curl https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip -o terraform.zip
RUN apt-get update && apt-get install -y unzip
RUN unzip packer.zip && unzip terraform.zip
RUN chmod +x ./packer && chmod +x ./terraform
RUN mv packer 