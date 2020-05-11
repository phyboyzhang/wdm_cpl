program main
  integer, parameter :: nx=10,ny=3
  double precision u2d(nx,ny),u2d2(nx,ny)
  double complex qhat2d(nx/2+1,ny),qhat2d2(nx/2+1,ny)
  integer N(1)
  integer howmany, idist, odist, istride, ostride
  integer inembed(2), onembed(2)
  integer rank
  real(8),parameter :: pi=3.1415926
  real(8) :: dx=pi/real(10,8);
  integer plan,planone,plantwo

  real(8) :: a(nx),a1(0:nx-1),a2(0:nx-1)
  complex(8) b(nx/2+1),b1(0:nx/2)

  integer :: i,j
	! some function to read the data into u2d

  ! perform x-fft
  N(1) = NX
  howmany = NY
  inembed(1) = NX
  inembed(2) = NY
  istride = 1
  idist = NX
  ostride = 1
  odist = (NX/2+1)
  onembed(1) = (NX/2+1)
  onembed(2) = NY
  rank = 1
  
  CALL dfftw_plan_many_dft_r2c(PLAN,rank,N(1),howmany, &
&                              u2d,0, &
&                              istride,idist, &
&                              qhat2d,0, &
&                              ostride,odist,FFTW_ESTIMATE) 

do i=1,3
  do j=1,10
    u2d(j,i)=sin(real(j-1,8)*dx)*cos(real(j-1,8)*dx)
  end do
end do

  CALL dfftw_execute_dft_r2c(PLAN,u2d(1,1),qhat2d(1,1)) ! x-fft
  CALL dfftw_destroy_plan(PLAN)

do i=1,3
  do j=1,6
    print*,qhat2d(j,i)
  end do
  print*
end do


call dfftw_plan_dft_r2c_1d(planone,nx,a,b,FFTW_ESTIMATE)
do i=1,nx
  a(i)=u2d(i,1)
end do

call dfftw_execute_dft_r2c(planone,a,b)
 CALL dfftw_destroy_plan(planone)
print*, "print out b()"
 do i=1,nx/2+1
   print*, b(i)
 end do

call dfftw_plan_dft_r2c_1d(planone,nx,a1,b1,FFTW_ESTIMATE)
 do i=1,nx
   a1(i-1)=u2d(i,1)
 end do

call dfftw_execute_dft_r2c(planone,a1,b1)
 CALL dfftw_destroy_plan(planone)
 print*, "print out b1()"
  do i=0,nx/2
    print*, b1(i)
  end do

call dfftw_plan_dft_c2r_1d(plantwo,nx,b1,a2,FFTW_ESTIMATE)
call dfftw_execute_dft_c2r(plantwo,b1,a2)
CALL dfftw_destroy_plan(plantwo)

 print*, "print a2()/10,         a1()"
  do i=0,nx-1
    print*, a2(i)/real(nx,8), "        ", a1(i) 
  end do


 end program
