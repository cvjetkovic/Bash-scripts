###########################################
# Vladimir Cvjetkovic
# APP DEPLOY SCRIPT

HOST="user@ap_addr"
APP_NAME="app"
BACKEND_DIR="app-backend"
FRONTEND_DIR="app-frontend"
BACKEND_NAME="app-1.0.war"
FRONTEND_DIST_DIR="${FRONTEND_DIR}/dist/"
DIST_NAME="dist"
WF_DIR="/opt/wildfly/standalone/deployments/"
NGINX_DIR="/var/www/html"


# Build backend
mvn -f $BACKEND_DIR clean install

# Build frontend
npm run prod-build --prefix $FRONTEND_DIR

# Compress frontend
zip -r -j $DIST_NAME.zip $FRONTEND_DIST_DIR

# Compress backend & frontend
zip -r -j $APP_NAME.zip $DIST_NAME.zip $BACKEND_DIR/target/$BACKEND_NAME

# Send app to host via SCP
scp $APP_NAME.zip $HOST:/tmp

# Remove tmp files
rm $DIST_NAME.zip
rm $APP_NAME.zip

# Deploy app
ssh $HOST "
unzip /tmp/$APP_NAME.zip -d /tmp;
sudo -S rm $WF_DIR$BACKEND_NAME; sudo -S cp /tmp/$BACKEND_NAME $WF_DIR; 
sudo -S rm -rfv $NGINX_DIR/*;
sudo -S unzip -j /tmp/$DIST_NAME.zip -d $NGINX_DIR;
rm /tmp/$APP_NAME.zip;
rm /tmp/$BACKEND_NAME;
rm /tmp/$DIST_NAME.zip"

echo "--------------------------------------"
echo "------------DEPLOY SUCCESS------------"
echo "--------------------------------------"
