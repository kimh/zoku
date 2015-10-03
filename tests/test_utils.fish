set -x sandbox "/tmp/zoku_sandbox"

source utils.fish

function test_fail --on-event test_fail
	echo "test fail"
end

function prepare
	rm -rf $sandbox
	mkdir -p $sandbox
end

function test_is_dir_empty
	prepare
	
	pushd $sandbox

	begin # returns true (0) when directory is empty
		if not is_dir_empty $sandbox
			emit test_fail
		end
	end

	begin # returns false (1) when directory is not empty
		touch $sandbox/foo

		if is_dir_empty $sandbox
			emit test_fail
		end
	end
	
	popd
end

test_is_dir_empty
