program fft2dfortran
!implicit none

real(8),parameter :: PI=3.1415926
real(8) a(0:9,0:2)
complex(8) b(0:5,0:2)
integer i,j
integer(8) forward
real(8) :: dx=pi/real(10,8);

call dfftw_plan_dft_r2c_2d(forward,10,3,a,b,FFTW_ESTIMATE)
do i=0,2
  do j=0,9
    a(j,i)=sin(real(j,8)*dx)*sin(real(j,8)*dx)
  end do
end do

call dfftw_execute_dft_r2c(forward,a(0,0),b(0,0))

do i=0,2
  do j=0,5
    print*, b(j,i)
  end do
end do

call dfftw_destroy_plan(forward)


end program
