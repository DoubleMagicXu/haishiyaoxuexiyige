#include<iostream>
using namespace std;


template <class T>
void merge(T a[],int p,int q,int r)
{
  if(p<=q&&q<r)
  {
    int l1=q-p+1;
    int l2=r-q;
    int r1[l1];
    int r2[l2];
    for(int i=0;i<l1;i++)
    {
      r1[i]=a[p+i];
    }
    for(int i=0;i<l2;i++)
    {
      r2[i]=a[q+1+i];
    }
    int i=0;
    int j=0;
    for(int k=p;k<=r;k++)
    {
      if(i<l1&&j<l2)
      {
        if(r1[i]<r2[j])
        {
          a[k]=r1[i];
          i++;

        }
        else
        {
          a[k]=r2[j];
          j++;
        }
      }
      else if(i<l1)
      {
        a[k]=r1[i];
        i++;
      }
      else
      {
        a[k]=r2[j];
        j++;
      }
    }
  }
}
template <class T>
void mergeSort(T a[],int p,int r)
{
  if(p>=r) return;
  int q=(p+r)/2;
  mergeSort(a,p,q);
  mergeSort(a,q+1,r);
  merge(a,p,q,r);
}

int main()
{
  int a[10];
  for(int i=0;i<10;i++)
  {
    a[i]=i*i-7*i+10;
  }
  mergeSort(a,0,9);
  for(int i=0;i<10;i++)
  {
    cout<<a[i]<<endl;
  }
  return 0;
}
