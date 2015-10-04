from ubuntu
run apt-get update
run apt-get install -y python-software-properties git
run apt-get update
run apt-get install -y fish
#entrypoint fish -c '. /tasks/task.fish; main'

