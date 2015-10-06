
### Utils
function is_dir_empty
	set dentry (ls -A $argv)

	if test -z "$dentry"
		return 0
	else
		return 1
	end
end

# https://github.com/fish-shell/fish-shell/issues/2459
function to_list
  xargs printf "%s\n"
end

function str_contains
	echo $argv[2] | grep $argv[1] > /dev/null

	set result $status

	if test $result -eq 0
		return 0
	else
		return 1
	end
end

function absolute_path
	pushd $argv[1]
	set path (pwd)
	popd
	echo $path
end

function msg
	set_color normal; echo $argv
end

function debug

	set_color magenta; echo $argv
	
end

function error_msg
	set_color red; echo $argv
end

function info_msg
	set_color green; echo $argv
end
