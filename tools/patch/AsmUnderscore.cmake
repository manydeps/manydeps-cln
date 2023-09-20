# Check if symbols are prefixed by an underscore in assembly language.
set(ASM_UNDERSCORE)

message(STATUS "CHECKING UNDERSCORE BEGIN")

set(_conftest_c ${CMAKE_BINARY_DIR}/conftest.c)
set(_conftest_s ${CMAKE_BINARY_DIR}/conftest.s)
set(_cc_ret)

set(_cc_ret_test)

message(STATUS "CHECKING UNDERSCORE '${_conftest_c}' '${_conftest_s}' and CC: '${CC}' C COMPILER ARGS: '${CMAKE_C_COMPILER_ARG1}'")

message(STATUS "COMMAND: ls")
execute_process(
	COMMAND "ls"
	RESULT_VARIABLE _cc_ret_test
)
message(STATUS "CHECKING OUTPUT OF ls: ${_cc_ret_test}")

file(WRITE ${_conftest_c} "int foo() { return 0; }")

message(STATUS "COMMAND (FIRST): ls")
execute_process(
	COMMAND "ls"
	RESULT_VARIABLE _cc_ret_test
)
message(STATUS "CHECKING OUTPUT OF ls: ${_cc_ret_test}")

message(STATUS "COMMAND: ls ${_conftest_c}")
execute_process(
	COMMAND ls "${_conftest_c}"
	RESULT_VARIABLE _cc_ret_test
)
message(STATUS "CHECKING OUTPUT OF ls: ${_cc_ret_test}")

message(STATUS "COMMAND: pwd")
execute_process(
	COMMAND "pwd"
	RESULT_VARIABLE _cc_ret_test
)
message(STATUS "CHECKING OUTPUT OF pwd: ${_cc_ret_test}")

message(STATUS "COMMAND: cat ${_conftest_c}")
execute_process(
	COMMAND cat "${_conftest_c}"
	RESULT_VARIABLE _cc_ret_test
)
message(STATUS "CHECKING OUTPUT OF cat: ${_cc_ret_test}")


# CC='ccache gcc' => "${CMAKE_C_COMPILER_ARG1}" == " gcc"
# (notice the leading whitespace). Grrr!
string(STRIP "${CMAKE_C_COMPILER_ARG1}" _c_compiler_arg1)

message(STATUS "COMMAND: '${CMAKE_C_COMPILER} ${_c_compiler_arg1} -S ${_conftest_c} -o ${_conftest_s}'")
execute_process(
	COMMAND ${CMAKE_C_COMPILER} ${_c_compiler_arg1} -S ${_conftest_c} -o ${_conftest_s}
	RESULT_VARIABLE _cc_ret
)
message(STATUS "CHECKING OUTPUT OF cc: ${_cc_ret}")

message(STATUS "COMMAND: ls conftest.s")
execute_process(
	COMMAND ls ${_conftest_s}
	RESULT_VARIABLE _cc_ret_test
)
message(STATUS "CHECKING OUTPUT OF ls: ${_cc_ret_test}")

if ("${_cc_ret}" EQUAL "0")
	file(STRINGS ${_conftest_s} _asm_underscore REGEX "_foo")
	if (_asm_underscore)
		set(ASM_UNDERSCORE true)
	endif()
endif()

file(REMOVE ${_conftest_s} ${_conftest_c})

message(STATUS "COMMAND (FINAL): ls")
execute_process(
	COMMAND "ls"
	RESULT_VARIABLE _cc_ret_test
)
message(STATUS "CHECKING OUTPUT OF ls: ${_cc_ret_test}")


message(STATUS "CHECKING UNDERSCORE END")