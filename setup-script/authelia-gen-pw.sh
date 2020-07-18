source .env

user(){
  read -esp "Enter a user name: " USER
  echo
}

password(){
  read -esp "Enter a password for ${USER}: " PASSWORD
  echo
}

user
password


# List of users
echo """users:
  ${USER}:
    displayname: \"${USER}\"
    password: \"<PASSWORD>\"
    email: user@example.com
    groups:
      - admins
      - dev
""" > users_database.yml

if [[ $PASSWORD != "" ]]; then
  PASSWORD=$(docker run authelia/authelia authelia hash-password -m 256 -p 2 -z $PASSWORD | sed 's/Password hash: //g')
  if [[ $(uname) == "Darwin" ]]; then
    sed -i '' "s/<PASSWORD>/$(echo $PASSWORD | sed -e 's/[\/&]/\\&/g')/g" users_database.yml
  else
    sed -i "s/<PASSWORD>/$(echo $PASSWORD | sed -e 's/[\/&]/\\&/g')/g" users_database.yml
  fi
else
  echo "Password cannot be empty"
  password
fi

echo "move user_database.yml to ${VOLUMEPATH}/authelia/etc"
mv users_database.yml ${VOLUMEPATH}/authelia/etc
