function main
	#fish tests/test_utils.fish
	#fish tests/test_zoku.fish
	for test in tests/*
        fish $test
        end
end

