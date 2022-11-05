cmake_minimum_required(VERSION 3.0.2)
project(orb_slam)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  tf
  sensor_msgs
  image_transport
  cv_bridge
  rospy
)

set(WS_OPEN_SOURCE_DIR_VAR "${CMAKE_SOURCE_DIR}/../open_source")
get_filename_component(WS_OPEN_SOURCE_DIR ${WS_OPEN_SOURCE_DIR_VAR} ABSOLUTE)
message(STATUS "workspace open source dir: ${WS_OPEN_SOURCE_DIR}")
list(APPEND CMAKE_PREFIX_PATH ${WS_OPEN_SOURCE_DIR})

find_package(OpenCV REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(g2o REQUIRED)

catkin_package(
)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
  ${OpenCV_INCLUDE_DIRS}
  ${CMAKE_CURRENT_SOURCE_DIR}/Thirdparty/DBoW2
)

add_executable(orb_slam
  src/main.cc
  src/Tracking.cc
  src/LocalMapping.cc
  src/LoopClosing.cc
  src/ORBextractor.cc
  src/ORBmatcher.cc
  src/FramePublisher.cc
  src/Converter.cc
  src/MapPoint.cc
  src/KeyFrame.cc
  src/Map.cc
  src/MapPublisher.cc
  src/Optimizer.cc
  src/PnPsolver.cc
  src/Frame.cc
  src/KeyFrameDatabase.cc
  src/Sim3Solver.cc
  src/Initializer.cc
)

target_link_libraries(orb_slam
  Eigen3::Eigen
  ${OpenCV_LIBS}
  ${catkin_LIBRARIES}
  ${CMAKE_CURRENT_SOURCE_DIR}/Thirdparty/DBoW2/lib/libDBoW2.so
  g2o::freeglut_minimal
  g2o::stuff
  g2o::opengl_helper
  g2o::core
  g2o::g2o_cli_library
  g2o::g2o_hierarchical_library
  g2o::g2o_simulator_library
  g2o::types_data
  g2o::types_slam2d
  g2o::types_slam3d
  g2o::types_sba
  g2o::types_sim3
  g2o::types_icp
  g2o::types_sclam2d
  g2o::types_slam2d_addons
  g2o::types_slam3d_addons
  g2o::solver_pcg
  g2o::solver_dense
  g2o::solver_structure_only
  g2o::solver_csparse
  g2o::csparse_extension
  g2o::solver_slam2d_linear
  g2o::solver_cholmod
  g2o::solver_eigen
)

