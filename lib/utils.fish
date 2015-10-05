
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

function msg
	set_color normal; echo $argv
end

function error_msg
	set_color red; echo $argv
end

function info_msg
	set_color green; echo $argv
end
