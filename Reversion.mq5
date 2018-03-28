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

enviarOrden("buy",50,50);

   
  }
//+------------------------------------------------------------------+
