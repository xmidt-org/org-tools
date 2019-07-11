#!/bin/bash

# TODO Make the mapping more dynamic...
# TEAMS=`./githubapi-get_json.sh $GITHUB_TOKEN /orgs/xmidt-org/teams | jq -r -j ".[] | .name, \"=\", .id, \"\n\""`
TEAMS='admins=3322421 writers=3307585'

REPOS=`./githubapi-get_json.sh $GITHUB_TOKEN /orgs/xmidt-org/repos|jq -r ".[] | .name "`

WRITER_ID=3307585
ADMIN_ID=3322421

for name in $REPOS
do
    echo "Updating $name"
    curl -X PUT -H "Authorization: token $GITHUB_TOKEN" -s -H "Accept: application/vnd.github.hellcat-preview+json" https://api.github.com/teams/$WRITER_ID/repos/xmidt-org/$name -d '{"permission": "push" }'
    curl -X PUT -H "Authorization: token $GITHUB_TOKEN" -s -H "Accept: application/vnd.github.hellcat-preview+json" https://api.github.com/teams/$ADMIN_ID/repos/xmidt-org/$name -d '{"permission": "admin" }'
done
