#!/bin/bash
# ask user confirmation

printf "This script will \n\
   - Download the workshop files and binaries for the CodeQL \n\
   - Add the binaries to the PATH for this terminal (Assuming you are using bash) \n\
Do you want to continue?"
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

# create a dir for saving the workshop files
mkdir cyscout_workshop

# download the workshop files
cd cyscout_workshop
git clone https://github.com/github/codeql
cd codeql
git checkout 123c375d844b9c2fd9ffcb4315a3f50c6b56f5ae
cd ..
git clone https://github.com/coinfabrik/cyscout

# download the binaries
mkdir binaries
cd binaries

wget https://github.com/github/codeql-cli-binaries/releases/download/v2.19.1/codeql-linux64.zip

# add the binaries to PATH
unzip codeql-linux64.zip
cd codeql
export PATH=$PATH:$(pwd)
# echo "export PATH=$PATH:$(pwd)" >> ~/.bashrc

# go back and setup the libs inside codeql
cd ../..

# copy the lib to codeql
cp -r cyscout/solidity/codeql/solidity/ codeql/


# install de codeql pack 
cd codeql/solidity/ql/lib
codeql pack install
