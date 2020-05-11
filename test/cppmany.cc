#include <iostream>
#include <fftw3.h>
#include <math.h>
#include <complex>

int main()
{
  double a[3][10];
  std::complex<double>  b[3][6];
  int howmany,idist,odist,istride,ostride,rank;
  int inembed[2]={3,10};
  int onembed[2]={3,6};
  fftw_plan plan,planone;

  const double :: PI=3.1415926;
  double  dx=pi/double(10);

  howmany=10;
  istride=1;
  idist=10;
  ostride=1;
  odist=6;
  rank=1;

  plan=fftw_plan_many_dft_r2c(rank,10,howmany,
                               &a,0,istride,idist,
                               reinterpret_cast<fftw_complex*>(b),0,ostride,odist,
                               FFTW_ESTIMATE);

  for(int i=0;i<3;i++){
    for(int j=0;j<10;j++){
      a[i][j]=sin(double(j)*dx)*cos(double(j)*dx);
    }
  }
  fftw_execute_dft_r2c(plan);
  fftw_destroy_plan(plan);

  for(int i=0;i<3;i++){
    for(int j=0;j<5;j++){
      std::cout<<b[i][j]<<'\n';
    }
    std::cout<<'\n';
  }



}
