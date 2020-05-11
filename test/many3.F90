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
  write(*,*) 'u', u2d(1,1)
  CALL dfftw_plan_many_dft_r2c(PLAN,rank,N(1),howmany, &
&                              u2d,inembed, &
&                              istride,idist, &
&                              qhat2d,onembed, &
&                              ostride,odist,FFTW_ESTIMATE) 

do i=1,3
  do j=1,10
    u2d=sin(real(j,8)*dx)*cos(real(j,8)*dx)
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

  ! perform y-fft
!  N(1) = NY
!  howmany = (NX/2+1)
!  inembed(1) = (NX/2+1)
!  inembed(2) = NY
!  istride = (NX/2+1)
!  idist = 1
!  ostride = (NX/2+1)
!  odist = 1
!  onembed(1) = (NX/2+1)
!  onembed(2) = NY
!  rank = 1
!  CALL dfftw_plan_many_dft(PLAN,rank,N(1),howmany, &
!&                              qhat2d,inembed, &
!&                              istride,idist, &
!&                              qhat2d2,onembed, &
!&                              ostride,odist,FFTW_FORWARD, &
!&                              FFTW_MEASURE) 
!  CALL dfftw_execute_dft(PLAN,qhat2d,qhat2d2) ! y-fft
!  CALL dfftw_destroy_plan(PLAN)
!
!  ! normally here, perform some filtering operation
!  ! but at the moment, I do nothing
!
!  ! perform inv-y-fft
!  N(1) = NY
!  howmany = (NX/2+1)
!  inembed(1) = (NX/2+1)
!  inembed(2) = NY
!  istride = (NX/2+1)
!  idist = 1
!  ostride = (NX/2+1)
!  odist = 1
!  onembed(1) = (NX/2+1)
!  onembed(2) = NY
!  rank = 1
!  CALL dfftw_plan_many_dft(PLAN,rank,N(1),howmany,&
! &                             qhat2d2,inembed, &
! &                              istride,idist, &
! &                              qhat2d,onembed, &
! &                              ostride,odist,FFTW_BACKWARD, &
! &                              FFTW_MEASURE) 
!  CALL dfftw_execute_dft(PLAN,qhat2d2,qhat2d) ! inv-y-fft
!  CALL dfftw_destroy_plan(PLAN)
!
!  ! perform inv-x-fft
!  N(1) = NX ! I'm not too sure about this value here
!  howmany = NY
!  inembed(1) = (NX/2+1)
!  inembed(2) = NY
!  istride = 1
!  idist = (NX/2+1)
!  ostride = 1
!  odist = NX
!  onembed(1) = NX
!  onembed(2) = NY
!  rank = 1
!  CALL dfftw_plan_many_dft_c2r(PLAN,rank,N(1),howmany,&
!&                              qhat2d,inembed, &
!&                              istride,idist, &
!&                              u2d2,onembed, &
!&                              ostride,odist,FFTW_ESTIMATE) ! 
!  CALL dfftw_execute_dft_c2r(PLAN,qhat2d,u2d2) ! x-fft
!  CALL dfftw_destroy_plan(PLAN)
!  write(*,*) 'u2d2', u2d2(1,1)
!
!  do i=1,nx
!   do j=1,ny
!    u2d2(i,j) = u2d2(i,j) / (nx*ny)
!   enddo
!  enddo
!  write(*,*) 'u2d2', u2d2(1,1) ! here the values u2d2(1,1) is different from u2d(1,1)

  ! some action to write u2d2 to file
  end program
