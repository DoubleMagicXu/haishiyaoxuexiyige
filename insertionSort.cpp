#include<iostream>
using namespace std;
template <class T>
void insertionSort(T a[],int count)
{
  if(count<=1) return;
  for(int i=1;i<count;i++)
  {
    T key=a[i];
    int j=i-1;
    while(j>=0&&key<a[j])
    {
      a[j+1]=a[j];
      j--;
    }
    a[j+1]=key;
  }


}
int main()
{
  int a[10];
  for(int i=0;i<10;i++)
  {
    a[i]=i*i-10*i+1;
  }
  for(int i=0;i<10;i++)
  {
    cout<<a[i]<<endl;
  }
  cout<<"**************************************"<<endl;
  insertionSort(a,10);
  for(int i=0;i<10;i++)
  {
    cout<<a[i]<<endl;
  }
  return 0;
}
