source lib/utils.fish

### Global variables
set -x data_dir ./data

function build
	set repo_path    $argv[1]
	set image        $argv[2]

	if str_contains "http" $repo_path
		set parsed_url   (echo $repo_path | sed 's|https://\(.*\)/\(.*\)/\(.*\).git|\1 \2 \3|' | to_list)
		set repo_name    $parsed_url[-1]
		set project_dir  $data_dir/$repo_name
		set builds_dir   $project_dir/builds; and mkdir -p $builds_dir
		set build_num    (next_build_dir $builds_dir)
		set build_dir    $builds_dir/$build_num; and mkdir -p $build_dir
		msg "Buidling $repo_name: #$build_num started..."

		pushd $build_dir; run_build $repo_name $repo_path $image; set result $status; popd
	else
		set repo_path (absolute_path $repo_path)
		set repo_name (echo $repo_path | tr "/" " " | to_list)[-1]
		set project_dir  $data_dir/$repo_name
		set builds_dir   $project_dir/builds; and mkdir -p $builds_dir
		set build_num    (next_build_dir $builds_dir)
		set build_dir    $builds_dir/$build_num; and mkdir -p $build_dir
		msg "Buidling $repo_name: #$build_num started..."

		pushd $build_dir; run_build_from_local $repo_name $repo_path $image; set result $status; popd
	end

	if test $result -ne 0
		error_msg "Test failed with exit status: $result"
	else
		info_msg "Test passed"
	end

	msg "Buidling $repo_name finished!!"
end

function run_build_from_local
	set repo_name    $argv[1]
	set repo_path    $argv[2]
	set image        $argv[3]

	docker run  \
	-v $repo_path:/$repo_name \
	-e "repo_name=$repo_name" \
        $image fish -c ' \
 	and cd $repo_name
	and source zoku.fish
	and main;
	'
end

function run_build
	set repo_name $argv[1]
	set clone_url $argv[2]
	set image     $argv[3]

	docker run  \
	-e "clone_url=$clone_url" \
	-e "repo_name=$repo_name" \
        $image fish -c ' \
        git clone $clone_url
	and cd $repo_name
	and source zoku.fish
	and main;
	'
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
