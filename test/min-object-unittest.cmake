cmake_minimum_required(VERSION 3.0)

project(test_${PROJECT_NAME})

if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${PROJECT_NAME}.cpp")

	enable_testing()

	include_directories( 
		"${C74_INCLUDES}"
		"${C74_MIN_API_DIR}/test/catch/include"
		# "${C74_MIN_API_DIR}/test/mock"
	)

	# set(CMAKE_CXX_FLAGS "-fprofile-arcs -ftest-coverage")
	# set(CMAKE_C_FLAGS "-fprofile-arcs -ftest-coverage")
	# set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-arcs -ftest-coverage")

	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../../../tests")
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")

	if (APPLE)
		set(CMAKE_OSX_ARCHITECTURES x86_64;i386)
	endif ()

	add_executable(${PROJECT_NAME} ${PROJECT_NAME}.cpp)

	set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 14)
	set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD_REQUIRED ON)

	target_link_libraries(${PROJECT_NAME} "mock_kernel")

	if (APPLE)
		target_link_libraries(${PROJECT_NAME} "-weak_framework JitterAPI")
		set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-Wl,-F'${C74_MAX_API_DIR}/lib/mac'")
	endif ()
	if (WIN32)
		# target_link_libraries(${PROJECT_NAME} ${MaxAPI_LIB})
		# target_link_libraries(${PROJECT_NAME} ${MaxAudio_LIB})
		# target_link_libraries(${PROJECT_NAME} ${Jitter_LIB})
	endif ()

	add_test(NAME ${PROJECT_NAME}
	         COMMAND ${PROJECT_NAME})
	 
endif ()
	 