add_executable(2dfft 2dfft.F90)

target_link_libraries(2dfft ${FFTW3_LIBRARIES})

add_executable(2d_1 2d_1.F90)

target_link_libraries(2d_1 ${FFTW3_LIBRARIES})

add_executable(manyfft manyfft.F90)

target_link_libraries(manyfft ${FFTW3_LIBRARIES})

add_executable(many4 many4.F90)

target_link_libraries(many4 ${FFTW3_LIBRARIES})

#add_executable(cppmany cppmany.cc)
#
#target_link_libraries(cppmany ${FFTW3_LIBRARIES})
