#!/bin/sh

HARMONY_ROOT=/opt/harmony/v2_02_00b/
COMPILER_ROOT=/opt/xc32/v2.50/
MPLABX_ROOT=/opt/mplabx/

PROJECT_PATH=./

if [ -z "$3" ]
  then
    PROJECT_PATH=./
else
  PROJECT_PATH=$HARMONY_ROOT/apps/$3
  mkdir -p $PROJECT_PATH
  mv -r $1 $PROJECT_PATH/$1
  mv -r src $PROJECT_PATH/src
  mv -r test $PROJECT_PATH/test
  mv project.yml $PROJECT_PATH/project.yml
  mv rakefile.rb $PROJECT_PATH/rakefile.rb
fi

ls $HARMONY_ROOT/apps

if [ "$4" = "true" ]
  then
    echo "Docker Container testing"
    #cp Gemfile $PROJECT_PATH/Gemfile
    #cp Gemfile.lock $PROJECT_PATH/Gemfile.lock
    #cd $PROJECT_PATH
    #bundle install
    cd $PROJECT_PATH
    export HARMONY_ROOT
    export COMPILER_ROOT
    export MPLABX_ROOT
    
    if [ -z "$3" ]
      then
        
    elif [  ]

    fi
    
    rake options:SB3 test:all || echo ">>> SB3 Unit test failed!!!" && exit 3
    rake options:SB75 test:all || echo ">>> SB75 Unit test failed!!!" && exit 3
    rake options:SB4 test:all || echo ">>> SB4 Unit test failed!!!" && exit 3
fi

echo "Docker Container Building $1:$2"

set -x -e

/opt/mplabx/mplab_platform/bin/prjMakefilesGenerator.sh $PROJECT_PATH/$1@$2 || exit 1
make -C $PROJECT_PATH/$1 CONF=$2 build || exit 2

cp -r $PROJECT_PATH/$1/ /github/workspace/output
