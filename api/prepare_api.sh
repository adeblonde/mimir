#!/bin/bash

source ../../user_setenv.sh

export SCENARIO_NAME="test_mimir"
export SCENARIO_DIR=$WORK_DIR/$SCENARIO_NAME

if [ ! -f $SCENARIO_DIR ]
then
	mkdir -p $SCENARIO_DIR
fi

cd $SCENARIO_DIR

export SWAGGER_FILE=$SCENARIO_DIR/"swagger.yml"
export OPENAPI_FILE=$SCENARIO_DIR/"openapi.yml"
# export OPENAPI_FILE="http://petstore.openapi.io/v2/openapi.json"
# export API_FOLDER="./api_folder"
export API_SERVER_FOLDER=$SCENARIO_DIR/api
export API_CLIENT_FOLDER=$SCENARIO_DIR/client
export API_CLIENT_LANGUAGE="python"
export API_SERVER_LANGUAGE="python-flask"

if [ ! -f $API_CLIENT_FOLDER ]
then
	mkdir -p $API_CLIENT_FOLDER
fi
if [ ! -f $API_SERVER_FOLDER ]
then
	mkdir -p $API_SERVER_FOLDER
fi

### install maven & java
# sudo apt-get install openjdk-8-jdk maven javacc openjdk-8-jdk-headless python3-pip
# sudo pip3 install setuptools

# ### generate swagger codegen from source
# git clone https://github.com/swagger-api/openapi-codegen
# cd swagger-codegen
# mvn clean package
# cd ..
# export CODEGEN_BIN=swagger-codegen/modules/swagger-codegen-cli/target/swagger-codegen-cli.jar

### download swagger codegen
# wget http://central.maven.org/maven2/io/swagger/swagger-codegen-cli/2.3.1/swagger-codegen-cli-2.3.1.jar -O swagger-codegen-cli.jar
export SWAGGER_BIN=swagger-codegen-cli.jar

### download openapi codegen
# wget http://central.maven.org/maven2/org/openapitools/openapi-generator-cli/3.1.0/openapi-generator-cli-3.1.0.jar -O openapi-generator-cli.jar
export OPENAPI_BIN=$CODE_DIR/mimir/api/openapi-generator-cli.jar

### set openapi file
# $CODE_DIR/mimir/api/set_openapi.sh $CODE_DIR/mimir/api/openapi.yml $OPENAPI_FILE

### set swagger file
$CODE_DIR/mimir/api/set_openapi.sh $CODE_DIR/mimir/api/swagger.yml $SWAGGER_FILE

### run codegen on swagger.json
echo $SWAGGER_BIN
java -jar $SWAGGER_BIN generate \
   -i $SWAGGER_FILE \
   -l $API_SERVER_LANGUAGE \
   -o $API_SERVER_FOLDER

# ### run codegen on openapi.json
# echo $OPENAPI_BIN
# java -jar $OPENAPI_BIN generate \
# 	-i $OPENAPI_FILE \
# 	-l $API_SERVER_LANGUAGE \
# 	-o $API_SERVER_FOLDER \
# 	--model-name-prefix mimir

### convert spaces to tabs
for python_file in $(find $API_SERVER_FOLDER -name '*.py')
do
	echo $python_file
	sed -i 's#    #	#g' $python_file
done