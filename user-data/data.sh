#!/bin/bash
apt install -y gnupg curl
apt install -y nodejs npm
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
apt install -y mongodb-org
systemctl start mongod
systemctl daemon-reload
git clone https://github.com/jackbalageru/MERN-CRUD.git
cd MERN-CRUD/client
npm i
npm start &
cd ../server/
npm i
npm install -g nodemon
nodemon server &