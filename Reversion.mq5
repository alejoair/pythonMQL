//+------------------------------------------------------------------+
//|                                                    Reversion.mq5 |
//|                                                     Alejocuartas |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Alejocuartas"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "orderSend.mq5" // Libreria para abrir ordenes
#include <Trade\Trade.mqh>
CTrade         m_trade;

//--- input parameters
#define EXPERT_MAGIC 123456

input int stoploss=100;
input int takeprofit=100;
input int periodoL= 25;
input int periodS = 10;

int cruceL=0;
int cruceLL=0;

int handleMaS;
int handleMaL;
int handleMaLL;
int bars;

double MaS[];
double MaL[];
double MaLL[];

MqlTradeResult resultado;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   handleMaS = iMA(Symbol(),0,10,0,MODE_EMA,PRICE_OPEN);
   handleMaL = iMA(Symbol(),0,25,0,MODE_EMA,PRICE_OPEN);
   handleMaLL= iMA(Symbol(),0,50,0,MODE_EMA,PRICE_OPEN);

   while(!IsStopped())
     {
      if(BarsCalculated(handleMaLL)>0) break;
      Sleep(1000);

     }

   bars=BarsCalculated(handleMaLL);

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {

   CopyBuffer(handleMaS,0,0,20,MaS);
   CopyBuffer(handleMaL,0,0,20,MaL);
   CopyBuffer(handleMaLL,0,0,20,MaLL);
   Sleep(1000);

   ArraySetAsSeries(MaS,true);
   ArraySetAsSeries(MaL,true);
   ArraySetAsSeries(MaLL,true);

   while(!IsStopped())
     {
      if(BarsCalculated(handleMaLL)>0) break;
      Sleep(1000);

     }

//ArrayPrint(MaLL,5,"--",0,WHOLE_ARRAY,ARRAYPRINT_INDEX);

//-------DETECTA CRUCES-----------------------------  

   if(BarsCalculated(handleMaLL)>bars)
     {
      cruceL=0;
      cruceLL=0;

      //DETECTA CRUCES APERTURA------------------------------------
      //--------------------------------------------------

      for(int i=0; i<8; i++)
        {

         if(MaS[i]>MaL[i] && MaS[i+1]<MaL[i+1])
           {
            cruceL=1;

           }

         if(MaS[i]>MaLL[i] && MaS[i+1]<MaLL[i+1])
           {
            cruceLL=1;

           }

         if(MaS[i]<MaL[i] && MaS[i+1]>MaL[i+1])
           {
            cruceL=-1;

           }

         if(MaS[i]<MaLL[i] && MaS[i+1]>MaLL[i+1])
           {
            cruceLL=-1;

           }

        }
   }
      //DETECTA CRUCE DE CIERRE--------------------------
      //-------------------------------------------------
      
      PositionSelect(_Symbol);
      int tipo = PositionGetInteger(POSITION_TYPE);

      for(int i=0; i<2; i++)
        {

         if(MaS[i]>MaL[i] && MaS[i+1]<MaL[i+1])
           {
            cruceL=1;

           }

         if(MaS[i]>MaLL[i] && MaS[i+1]<MaLL[i+1])
           {
            cruceLL=1;

           }

         if(MaS[i]<MaL[i] && MaS[i+1]>MaL[i+1])
           {
            cruceL=-1;

           }

         if(MaS[i]<MaLL[i] && MaS[i+1]>MaLL[i+1])
           {
            cruceLL=-1;

           }

        
     }
    if(tipo == 0 && (cruceL==1 || cruceLL==1)){
    m_trade.PositionClose(resultado.deal);
    }
    if(tipo == 1 && (cruceL==-1 || cruceLL==-1)){
    m_trade.PositionClose(resultado.deal);
    }
     

         //--------------------------------------------------

         if(cruceL==1 && cruceLL==1 && PositionsTotal()==0)
        {
         Print("COMPRA ENVIADA");
         resultado=enviarOrden("sell",stoploss,takeprofit);
         }

         if(cruceL==-1 && cruceLL==-1 && PositionsTotal()==0)
        {
         Print("VENTA ENVIADA");
         resultado = enviarOrden("buy",stoploss,takeprofit);
         }

         //------------------ Termina la funcion-----------------------
         }
//+------------------------------------------------------------------+
