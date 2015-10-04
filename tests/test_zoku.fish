set -x sandbox "/tmp/zoku_sandbox"

source lib/zoku.fish

function test_fail
	echo "Test fail: $argv"
	exit 1
end

function prepare
	rm -rf $sandbox
	mkdir -p $sandbox
end

function test_next_build_dir
	set test "test_next_build_dir"

	pushd $sandbox

	set t "$test:returns 1 when no build exists"
	begin
		prepare
		set build_num (next_build_dir $sandbox)

		if test $build_num -ne 1
		   test_fail $t
		end
	end

	set t "$test:returns 2 when there is one build"
	begin
		prepare; and mkdir $sandbox/1
		set build_num (next_build_dir $sandbox)

		if test $build_num -ne 
		   test_fail $t
		end
	end

	popd
end

test_next_build_dir
