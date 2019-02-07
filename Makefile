default: clean ios tvos
	cd build/Release-appletv && zip -ry ../../CrashReporter-tvOS.zip CrashReporter.framework
	cd build/Release-iphone && zip -ry ../../CrashReporter-iOS.zip CrashReporter.framework

preprocessor_definitions := PLCRASHREPORTER_PREFIX=TPA \$$(inherited)

clean:
	rm -rf ./build
	rm -f CrashReporter-*.zip

ios:
	xcodebuild PL_ALLOW_LOCAL_MODS=1 BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="-fembed-bitcode" -configuration Release -target "CrashReporter-iOS" GCC_PREPROCESSOR_DEFINITIONS="$(preprocessor_definitions)"

tvos:
	xcodebuild PL_ALLOW_LOCAL_MODS=1 BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="-fembed-bitcode" -target "CrashReporter-tvOS-Simulator" -sdk appletvsimulator GCC_PREPROCESSOR_DEFINITIONS="$(preprocessor_definitions)"
	xcodebuild PL_ALLOW_LOCAL_MODS=1 BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="-fembed-bitcode" -configuration Release -target "CrashReporter-tvOS" GCC_PREPROCESSOR_DEFINITIONS="$(preprocessor_definitions)"
