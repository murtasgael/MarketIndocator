//Persnal simple moving average class

#ifndef _SMA
#define _SMA

#include "Utils.mqh"

class SMA
{
   private:
      double value[];//les valeur de la SMA value[0] étant la plus récente
      uint length;
      uint N;
      
      //fonction utilitaire
      void calculValues(const double & price[]){
         if (ArraySize(price) < (N+length-1)){
         Print("SMA Erreur in calculValues : entrie array too small");
         }
         ArrayResize(value,N);
         value[0] = price[0];
         for(uint i = 1; i<length; i++){
            value[0] = value[0] + price[i];
            }
         value[0]=value[0]/length;
         for(uint i=1; i < N; i++){
            value[i]=value[i-1]- price[(i-1)]/length + price[(i+length-1)]/length;
         }
      }
      
   public:
   
      SMA(): length(0), N(0)
      {
      }
      
      SMA(const uint & l,const uint & n,const double & price[]): length(l), N(n)
      {
         calculValues(price);
      }
      
      /*SMA(uint l,uint n,string symbol,ENUM_TIMEFRAMES tf): length(l), N(n)
      {
         uint tmax = n+l-1;
         if (tmax > Bars(symbol,tf)){
            Print("Construction feilled: pas assez de bougie");
         }
         double price[];
         ArrayResize(price,tmax);
         for(uint i = 0; i < tmax; i++){
            price[i]=iClose(symbol,tf,i);
         }
         calculValues(price);
         ArrayFree(price);
      }*/
      
      ~SMA(){
      ArrayFree(value);
      }
      
      //acceseurs par copie avec le bon décalage
      double get(const uint & i) const{
         if (i > (N-1)){
            Print("MA access byond limit !");
            Print ("Access :");
            Print (i);
            Print ("Limit :");
            Print (length);
            }
      return value[i];
      }
      
      uint maSize() const{
      return length;
      }
      
      uint tabSize() const{
      return N;
      }
};

#endif 