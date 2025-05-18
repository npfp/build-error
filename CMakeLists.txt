cmake_minimum_required(VERSION 3.28.3)

project(example LANGUAGES CXX VERSION 0.0.1)

# Find Python 3 interpreter and development components
find_package(Python3 COMPONENTS Interpreter Development REQUIRED)

message(STATUS "Found Python3 Interpreter: ${Python3_EXECUTABLE}")
# Note: These might be empty if CMake uses imported targets primarily
message(STATUS "Found Python3 Libraries: ${Python3_LIBRARIES}")
message(STATUS "Found Python3 Include Dirs: ${Python3_INCLUDE_DIRS}")

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-std=c23")
# set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-stdlib=libc++ -std=c23")

message(STATUS "CMAKE_STANDARD_LIBRARIES: ${CMAKE_C_STANDARD_LIBRARIES}")
message(STATUS "CMAKE_CXX_COMPILER_VERSION: ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "CMAKE_CXX_COMPILER: ${CMAKE_CXX_COMPILER}")

message(STATUS "CMAKE_C_LINK_FLAGS=${CMAKE_C_LINK_FLAGS}")
message(STATUS "CMAKE_C_FLAGS=${CMAKE_C_FLAGS}")
message(STATUS "CMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}")
message(STATUS "CMAKE_LIBRARY_PATH=$ENV{CMAKE_LIBRARY_PATH}")

link_directories($ENV{CMAKE_LIBRARY_PATH} )

# Check that vector are available for compilation
include(CheckIncludeFileCXX)
check_include_file_cxx("vector" CXX_VECTOR_SUPPORT)
message(STATUS "CXX_VECTOR_SUPPORT: ${CXX_VECTOR_SUPPORT}")

if (NOT CXX_VECTOR_SUPPORT)
  message(FATAL_ERROR "Couldn't find #include <vector>")
else()
  # message(FATAL_ERROR "Found #include <vector>")
endif ()

include(CheckCXXSourceCompiles)
check_cxx_source_compiles("
    #include <vector>
    int main() {
      std::vector<int> v = {8, 4, 5, 9};
      return 0;
    }
  " HAVE_VECTOR)

if (NOT HAVE_VECTOR)
  message(FATAL_ERROR "Couldn't find #include <vector>")
endif ()



# set(FETCHCONTENT_UPDATES_DISCONNECTED ON)
# include(FetchContent)

# set(PYBIND11_PYTHON_VERSION 3.11.10)
# set(PYBIND11_FINDPYTHON ON)

# FetchContent_Declare(
#         pybind11
#         GIT_REPOSITORY https://github.com/pybind/pybind11
#         GIT_TAG        v2.13.6
# )
# FetchContent_MakeAvailable(pybind11)

find_package(pybind11 CONFIG REQUIRED)

pybind11_add_module(
        ${PROJECT_NAME}
        src/example/example.cpp
)
target_compile_features(
        ${PROJECT_NAME}
        PRIVATE
        cxx_std_23
)
target_link_libraries(${PROJECT_NAME}
        PRIVATE
        pybind11::pybind11
        Python3::Python
)

target_include_directories(${PROJECT_NAME} PRIVATE
        "${PROJECT_BINARY_DIR}"
)

set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 23)
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 23)

install(TARGETS ${PROJECT_NAME} LIBRARY DESTINATION .)
