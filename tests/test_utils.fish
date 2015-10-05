set -x sandbox "/tmp/zoku_sandbox"

source lib/utils.fish

function test_fail
	echo "Test fail: $argv"
	exit 1
end

function prepare
	rm -rf $sandbox
	mkdir -p $sandbox
end

function test_is_dir_empty
	set test "test_is_dir_empty"
	prepare
	
	pushd $sandbox
	
	set t "$test:returns true (0) when directory is empty"
	begin
		if not is_dir_empty $sandbox
			test_fail $t
		end
	end

	set t "$test:returns false (1) when directory is not empty"
	begin
		touch $sandbox/foo

		if is_dir_empty $sandbox
			test_fail $t
		end
	end
	
	popd
end

function test_to_list
	set test "test_to_list"
	
	set t "$test:retunrs a list"
	begin
		set list (echo "1 2 3" | to_list)

		if test (count $list) -ne 3
			test_fail $t
		end
	end
end

test_is_dir_empty
test_to_list
