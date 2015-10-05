function main
	echo "Running tests..."
	for test in tests/*
		fish $test
        end
end

