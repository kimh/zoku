#!/usr/local/bin/fish

function build
  set f (cat /Users/kimh/git/runner/tasks/task.fish | tr '\n' ';')

  docker run -e "f=$f" builder fish -c 'eval $f; main'
end
