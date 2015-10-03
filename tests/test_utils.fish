set -x sandbox "/tmp/zoku_sandbox"

source utils.fish

function test_fail --on-event test_fail
	echo "Test fail: $argv"
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
			emit test_fail $t
		end
	end

	set t "$test:returns false (1) when directory is not empty"
	begin
		touch $sandbox/foo

		if is_dir_empty $sandbox
			emit test_fail $t
		end
	end
	
	popd
end

test_is_dir_empty
