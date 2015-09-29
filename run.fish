function run
  echo $argv[1]
  docker run -v $argv[1]:/tasks runner fish -c '. /tasks/task.fish; main'
end

#fish -c '. /tasks/task.fish; main'

#docker run -v /Users/kimh/git/runner/tasks/:/tasks runner



