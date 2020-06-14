install:
	swift package update
	swift build -c release
	install .build/Release/todos /usr/local/bin/todos

xcode:
	swift package generate-xcodeproj
	xed .
