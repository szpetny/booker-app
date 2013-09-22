#!/bin/bash

echo "Starting deploy"

pushd ${OPENSHIFT_REPO_DIR} > /dev/null

echo "Change directory to ${OPENSHIFT_REPO_DIR}public"

cd ${OPENSHIFT_REPO_DIR}

cd public

echo "Creating soft link to ${OPENSHIFT_DATA_DIR}uploads named uploads"

ln -s ${OPENSHIFT_DATA_DIR}uploads uploads

echo "Running bundle exec rake db:migrate RAILS_ENV=production"

bundle exec rake db:migrate RAILS_ENV="production"

echo "Running bundle exec rake db:seed RAILS_ENV=production"

bundle exec rake db:seed RAILS_ENV="production"

popd > /dev/null