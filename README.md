# Homepage
These are scripts to install and update homepage. They are similar to [ttek's homepage lxc scripts](https://community-scripts.github.io/ProxmoxVE/scripts?id=homepage), tailored for my personal use.

## Prerequisites
Below packages are installed:
- node.js
- npm
- pnpm
- curl

`sudo apt install curl node.js npm`
`sudo npm install -g pnpm`

## To install homepage from source
1. Clone the repository in a directory of your choosing.  Usually the user home directory.
2. Make the scrip executable, `sudo chmod +x install.sh`.
3. Run the script, `sudo ./install.sh`

## To update homepage from source after installation
1. Clone the repository in a directory of your choosing, if you have not already.  Usually the user home directory.
2. Make the scrip executable, `sudo chmod +x update.sh`.
3. Run the script, `sudo ./update.sh`

## Configuration Directory Location

`/opt/homepage/config/`
