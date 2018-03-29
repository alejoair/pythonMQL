//+------------------------------------------------------------------+
//|                                                    Reversion.mq5 |
//|                                                     Alejocuartas |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Alejocuartas"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "orderSend.mq5" // Libreria para abrir ordenes
//--- input parameters
#define EXPERT_MAGIC 123456

input int stoploss = 100;
input int takeprofit = 100;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

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
  
int handleMaS = iMA(Symbol(),0,10,0,MODE_SMA,PRICE_OPEN); 
int handleMaL = iMA(Symbol(),0,25,0,MODE_SMA,PRICE_OPEN); 
double MaS[];
double MaL[];

CopyBuffer(handleMaS,0,0,5,MaS);
CopyBuffer(handleMaL,0,0,5,MaL);
Print(MaS[0]);  // Hacer el calculo para entrar a la operacion
//-------------------------------------------------------------------+
if(MaS[1]>MaL[1] && MaS[0]<MaL[0] && PositionsTotal() == 0){
enviarOrden("buy",stoploss,takeprofit);

Print(PositionsTotal());
}




   
  }
//+------------------------------------------------------------------+
