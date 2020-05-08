program fft2dfortran
!implicit none
!include "fftw3.f"

real(8),parameter :: pi=3.1415926
real(8) a(0:9,0:2),c(0:9,0:2)
real(8) aa(0:29)
complex(8) b(0:5,0:2)
complex(8) bb(0:15)
integer i,j
integer(8) forward,backward,forward2
real(8) :: dx=pi/real(10,8);

real(8) :: a1(0:9)
complex(8)::b1(0:5)


!call dfftw_plan_dft_r2c_1d(forward,10,aa,bb,FFTW_ESTIMATE)
!do j=1,10
!  aa(j)=sin(real(j,8)*dx)*sin(real(j,8)*dx)
!end do

!call dfftw_execute_dft_r2c(forward,aa,bb)

!!!! for 2d transform
call dfftw_plan_dft_r2c_2d(forward,10,3,a,b,FFTW_ESTIMATE)
call dfftw_plan_dft_c2r_2d(backward,10,3,b,a,FFTW_ESTIMATE)

do i=0,2
  do j=0,9
    a(j,i)=sin(real(j,8)*dx)*cos(real(j,8)*dx)
    c(j,i)=a(j,i)
  end do
end do

call dfftw_execute_dft_r2c(forward,a(0,0),b(0,0))

print*, "print out b(:,:)"
do i=0,2
  do j=0,5
    print*, b(j,i)
    if(j==5) then
      print*
    endif
  end do
end do


call dfftw_execute_dft_c2r(backward,b(0,0),a(0,0))

print*
print*, "print out a(:,:)/real(30,8)"
do i=0,2
  do j=0,9
    print*, a(j,i)/real(30,8),c(j,i)
    if(j==9) then
      print*
    endif
  end do
enddo

!!!! for the tranform on the first dimension of 2d array a
call dfftw_plan_dft_r2c_1d(forward2,10,a1,b1,FFTW_ESTIMATE)
do i=0,9
  a1(i)=a(i,1)
enddo 

call dfftw_execute_dft_r2c(forward2,a1,b1)

print*, "print out b1"
do i=0,5
print*, b1(i)
end do

!!!! for the transform based on assembling all elements in to 1d 
!!!! array
call dfftw_plan_dft_r2c_1d(forward2,30,aa,bb,FFTW_ESTIMATE)
do i=0,2
  do j=0,9
   aa(10*i+j)=c(j,i)
  end do
end do

call dfftw_execute_dft_r2c(forward2,aa,bb)

print*
print*, "print out bb"
do i=0,15
  print*, bb(i)
end do


call dfftw_destroy_plan(forward)
call dfftw_destroy_plan(backward)
call dfftw_destroy_plan(forward2)


end program
