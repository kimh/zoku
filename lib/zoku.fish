### Global variables
set -x data_dir ./data

function buil
	set json         $argv[-1]
	set repo_name    (echo $json | jq -r '.repository.name')
	set clone_url    (echo $json | jq -r '.repository.clone_url')
	set project_dir  $data_dir/$repo_name
	set builds_dir   $project_dir/builds; and mkdir -p $builds_dir
	set build_num    (next_build_dir $builds_dir)
	set build_dir    $builds_dir/$build_num; and mkdir -p $build_dir

	echo "Buidling $repo_name: #$build_num started..."

	pushd $build_dir; run_build $repo_name $clone_url; set result $status; popd

	if test $result -ne 0
		echo "Test failed with exit status: $result"
	else
		echo "Test passed"
	end

	echo "Buidling $repo_name finished!!"
end

function run_build
	set repo_name $argv[1]
	set clone_url $argv[2]
	docker run  \
	       -e "clone_url=$clone_url" \
	       -e "repo_name=$repo_name" \
               builder fish -c ' \
               git clone $clone_url
	       and cd $repo_name
	       and source zoku.fish
	       and main;
	       ' > out.log
end

function next_build_dir
	set builds_dir $argv[1]

	if is_dir_empty $builds_dir
		set newest_build_num 0
	else
		set newest_build_num (ls $builds_dir | sort -n)[-1]
	end

	echo (math $newest_build_num + 1)
end

