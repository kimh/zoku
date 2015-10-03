
### Utils
function is_dir_empty
	set dentry (ls -A $argv)

	if test -z "$dentry"
		return 0
	else
		return 1
	end
end
