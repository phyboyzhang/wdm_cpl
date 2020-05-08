add_executable(2dfft 2dfft.F90)

target_link_libraries(2dfft ${FFTW3_LIBRARIES})

add_executable(2d_1 2d_1.F90)

target_link_libraries(2d_1 ${FFTW3_LIBRARIES})
