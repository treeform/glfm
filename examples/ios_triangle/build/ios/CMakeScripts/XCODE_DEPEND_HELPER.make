# DO NOT EDIT
# This makefile makes sure all linkable targets are
# up-to-date with anything they link to
default:
	echo "Do not invoke directly"

# Rules to remove targets that are older than anything to which they
# link.  This forces Xcode to relink the targets from scratch.  It
# does not seem to check these dependencies itself.
PostBuild.glfm.Debug:
/p/try/glfm/build/ios/GLFM.build/lib/Debug/libglfm.a:
	/bin/rm -f /p/try/glfm/build/ios/GLFM.build/lib/Debug/libglfm.a


PostBuild.glfm_example.Debug:
PostBuild.glfm.Debug: /p/try/glfm/build/ios/example/Debug${EFFECTIVE_PLATFORM_NAME}/glfm_example.app/glfm_example
/p/try/glfm/build/ios/example/Debug${EFFECTIVE_PLATFORM_NAME}/glfm_example.app/glfm_example:\
	/p/try/glfm/build/ios/GLFM.build/lib/Debug/libglfm.a
	/bin/rm -f /p/try/glfm/build/ios/example/Debug${EFFECTIVE_PLATFORM_NAME}/glfm_example.app/glfm_example


PostBuild.glfm_test_pattern.Debug:
PostBuild.glfm.Debug: /p/try/glfm/build/ios/example/Debug${EFFECTIVE_PLATFORM_NAME}/glfm_test_pattern.app/glfm_test_pattern
/p/try/glfm/build/ios/example/Debug${EFFECTIVE_PLATFORM_NAME}/glfm_test_pattern.app/glfm_test_pattern:\
	/p/try/glfm/build/ios/GLFM.build/lib/Debug/libglfm.a
	/bin/rm -f /p/try/glfm/build/ios/example/Debug${EFFECTIVE_PLATFORM_NAME}/glfm_test_pattern.app/glfm_test_pattern


PostBuild.glfm.Release:
/p/try/glfm/build/ios/GLFM.build/lib/Release/libglfm.a:
	/bin/rm -f /p/try/glfm/build/ios/GLFM.build/lib/Release/libglfm.a


PostBuild.glfm_example.Release:
PostBuild.glfm.Release: /p/try/glfm/build/ios/example/Release${EFFECTIVE_PLATFORM_NAME}/glfm_example.app/glfm_example
/p/try/glfm/build/ios/example/Release${EFFECTIVE_PLATFORM_NAME}/glfm_example.app/glfm_example:\
	/p/try/glfm/build/ios/GLFM.build/lib/Release/libglfm.a
	/bin/rm -f /p/try/glfm/build/ios/example/Release${EFFECTIVE_PLATFORM_NAME}/glfm_example.app/glfm_example


PostBuild.glfm_test_pattern.Release:
PostBuild.glfm.Release: /p/try/glfm/build/ios/example/Release${EFFECTIVE_PLATFORM_NAME}/glfm_test_pattern.app/glfm_test_pattern
/p/try/glfm/build/ios/example/Release${EFFECTIVE_PLATFORM_NAME}/glfm_test_pattern.app/glfm_test_pattern:\
	/p/try/glfm/build/ios/GLFM.build/lib/Release/libglfm.a
	/bin/rm -f /p/try/glfm/build/ios/example/Release${EFFECTIVE_PLATFORM_NAME}/glfm_test_pattern.app/glfm_test_pattern


PostBuild.glfm.MinSizeRel:
/p/try/glfm/build/ios/GLFM.build/lib/MinSizeRel/libglfm.a:
	/bin/rm -f /p/try/glfm/build/ios/GLFM.build/lib/MinSizeRel/libglfm.a


PostBuild.glfm_example.MinSizeRel:
PostBuild.glfm.MinSizeRel: /p/try/glfm/build/ios/example/MinSizeRel${EFFECTIVE_PLATFORM_NAME}/glfm_example.app/glfm_example
/p/try/glfm/build/ios/example/MinSizeRel${EFFECTIVE_PLATFORM_NAME}/glfm_example.app/glfm_example:\
	/p/try/glfm/build/ios/GLFM.build/lib/MinSizeRel/libglfm.a
	/bin/rm -f /p/try/glfm/build/ios/example/MinSizeRel${EFFECTIVE_PLATFORM_NAME}/glfm_example.app/glfm_example


PostBuild.glfm_test_pattern.MinSizeRel:
PostBuild.glfm.MinSizeRel: /p/try/glfm/build/ios/example/MinSizeRel${EFFECTIVE_PLATFORM_NAME}/glfm_test_pattern.app/glfm_test_pattern
/p/try/glfm/build/ios/example/MinSizeRel${EFFECTIVE_PLATFORM_NAME}/glfm_test_pattern.app/glfm_test_pattern:\
	/p/try/glfm/build/ios/GLFM.build/lib/MinSizeRel/libglfm.a
	/bin/rm -f /p/try/glfm/build/ios/example/MinSizeRel${EFFECTIVE_PLATFORM_NAME}/glfm_test_pattern.app/glfm_test_pattern


PostBuild.glfm.RelWithDebInfo:
/p/try/glfm/build/ios/GLFM.build/lib/RelWithDebInfo/libglfm.a:
	/bin/rm -f /p/try/glfm/build/ios/GLFM.build/lib/RelWithDebInfo/libglfm.a


PostBuild.glfm_example.RelWithDebInfo:
PostBuild.glfm.RelWithDebInfo: /p/try/glfm/build/ios/example/RelWithDebInfo${EFFECTIVE_PLATFORM_NAME}/glfm_example.app/glfm_example
/p/try/glfm/build/ios/example/RelWithDebInfo${EFFECTIVE_PLATFORM_NAME}/glfm_example.app/glfm_example:\
	/p/try/glfm/build/ios/GLFM.build/lib/RelWithDebInfo/libglfm.a
	/bin/rm -f /p/try/glfm/build/ios/example/RelWithDebInfo${EFFECTIVE_PLATFORM_NAME}/glfm_example.app/glfm_example


PostBuild.glfm_test_pattern.RelWithDebInfo:
PostBuild.glfm.RelWithDebInfo: /p/try/glfm/build/ios/example/RelWithDebInfo${EFFECTIVE_PLATFORM_NAME}/glfm_test_pattern.app/glfm_test_pattern
/p/try/glfm/build/ios/example/RelWithDebInfo${EFFECTIVE_PLATFORM_NAME}/glfm_test_pattern.app/glfm_test_pattern:\
	/p/try/glfm/build/ios/GLFM.build/lib/RelWithDebInfo/libglfm.a
	/bin/rm -f /p/try/glfm/build/ios/example/RelWithDebInfo${EFFECTIVE_PLATFORM_NAME}/glfm_test_pattern.app/glfm_test_pattern




# For each target create a dummy ruleso the target does not have to exist
/p/try/glfm/build/ios/GLFM.build/lib/Debug/libglfm.a:
/p/try/glfm/build/ios/GLFM.build/lib/MinSizeRel/libglfm.a:
/p/try/glfm/build/ios/GLFM.build/lib/RelWithDebInfo/libglfm.a:
/p/try/glfm/build/ios/GLFM.build/lib/Release/libglfm.a:
