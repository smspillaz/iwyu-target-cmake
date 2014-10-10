# /tests/IWYUPassCXXFlagsForCXXHeaders.cmake
# Sets up a target and runs include-what-you-use on it.
#
# See LICENCE.md for Copyright information

include (CMakeUnit)
include (IncludeWhatYouUse)

_validate_include_what_you_use (CONTINUE)

set (HEADER_FILE ${CMAKE_CURRENT_BINARY_DIR}/Header.h)
set (HEADER_FILE_CONTENTS
     "#ifndef HEADER_H\n"
     "#define HEADER_H\n"
     "class A\n"
     "{\n"
     "public:\n"
     "    int i\;\n"
     "}\;\n"
     "#endif")

set (SOURCE_FILE ${CMAKE_CURRENT_BINARY_DIR}/Source.cpp)
set (SOURCE_FILE_CONTENTS
     "#include <Header.h>\n"
     "int main (void)\n"
     "{\n"
     "    A a\;\n"
     "    a.i = 3\;\n"
     "    return a.i\;\n"
     "}\n")

file (WRITE ${SOURCE_FILE} ${SOURCE_FILE_CONTENTS})
file (WRITE ${HEADER_FILE} ${HEADER_FILE_CONTENTS})

set (EXECUTABLE executable)
include_directories (${CMAKE_CURRENT_BINARY_DIR})
add_executable (${EXECUTABLE}
                ${SOURCE_FILE}
                ${HEADER_FILE})

set (CMAKE_CXX_FLAGS "-DUSING_CXX_FLAGS")

iwyu_target_sources (${EXECUTABLE}
                     INTERNAL_INCLUDE_DIRS
                     ${CMAKE_CURRENT_BINARY_DIR})