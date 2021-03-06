#/usr/bin/env

#
## Variables
#

GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
NEUTRAL="\033[0m"
NGINX_CONFIG_DIR='/etc/nginx/'


#
## Displaying functions
#

function already {
  echo -e "${YELLOW}[-]$1 is already installed${NEUTRAL}"
}

function installing {
  echo -e "${GREEN}[~]Installing $1...${NEUTRAL}"
}

function success {
  echo -e "${GREEN}[+]$1 successfully installed${NEUTRAL}"
}

function success {
  echo -e "${GREEN}[+]$1 successfully installed${NEUTRAL}"
}

function exitBanner {
    echo "#"
    echo "#  Node.js, Strapi, PM2, nginx and certbot are now installed"
    echo "#"
}

#
## Logic
#

function install_nvm {
  if [ -a $HOME/.nvm ]; then
    already nvm
  else
    installing nvm
    wget -qO- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
    export NVM_DIR=$HOME/.nvm;
    source $HOME/.nvm/nvm.sh;
    success nvm
  fi
}

function install_node {
  node -v &>/dev/null
  if [ $? == "0" ]; then
    already node
  else
    installing node
    nvm install stable
    nvm use stable
    nvm alias default stable
    success node
  fi
}

function install_strapi {
  strapi &>/dev/null
  if [ $? == "0" ]; then
    already Strapi
  else
    installing Strapi
    npm install -g strapi@alpha
    . ~/.nvm/nvm.sh
    source $HOME/.nvm/nvm.sh;
    strapi -v
    success Strapi
  fi
}

function install_pm2 {
  pm2 &>/dev/null
  if [ $? == "1" ]; then
    already PM2
  else
    installing PM2
    npm install -g pm2@latest
    . ~/.nvm/nvm.sh
    pm2 update
    success PM2
  fi
}

function install_nginx {
  nginx &>/dev/null
  if [ $? == "1" ]; then
    already nginx
  else
    installing nginx
    apt-get update
    apt-get install -y nginx

    # Replace nginx config file
    cat > /etc/nginx/sites-available/default <<EOF
##
# You should look at the following URL's in order to grasp a solid understanding
# of Nginx configuration files in order to fully unleash the power of Nginx.
# http://wiki.nginx.org/Pitfalls
# http://wiki.nginx.org/QuickStart
# http://wiki.nginx.org/Configuration
#
# Generally, you will want to move this file somewhere, and start with a clean
# file but keep this around for reference. Or just disable in sites-enabled.
#
# Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
##

# Default server configuration
#
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        # SSL configuration
        #
        # listen 443 ssl default_server;
        # listen [::]:443 ssl default_server;
        #
        # Note: You should disable gzip for SSL traffic.
        # See: https://bugs.debian.org/773332
        #
        # Read up on ssl_ciphers to ensure a secure configuration.
        # See: https://bugs.debian.org/765782
        #
        # Self signed certs generated by the ssl-cert package
        # Don't use them in a production server!
        #
        # include snippets/snakeoil.conf;

        root /var/www/html;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                proxy_pass http://localhost:1337;
                proxy_http_version 1.1;
                proxy_set_header Upgrade \$http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host \$host;
                proxy_cache_bypass \$http_upgrade;
        }

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #       include snippets/fastcgi-php.conf;
        #
        #       # With php7.0-cgi alone:
        #       fastcgi_pass 127.0.0.1:9000;
        #       # With php7.0-fpm:
        #       fastcgi_pass unix:/run/php/php7.0-fpm.sock;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #       deny all;
        #}
}
EOF
    service nginx restart
    success nginx
  fi
}

function install_certbot {
  certbot &>/dev/null
  if [ $? == "1" ]; then
    already Certbot
  else
    installing Certbot
    apt-get update
    add-apt-repository ppa:certbot/certbot
    apt-get update
    apt-get install python-certbot-nginx 
  fi
}



#
## Main
#

install_nvm
install_node
install_strapi
install_pm2
install_nginx
install_certbot

exitBanner

echo
echo -e "${GREEN}[+]Done.${NEUTRAL}"

exec $SHELL -l
