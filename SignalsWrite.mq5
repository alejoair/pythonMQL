//+------------------------------------------------------------------+
//|                                                 SignalsWrite.mq5 |
//|                                                     Alejocuartas |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Alejocuartas"
#property link      "https://www.mql5.com"
#property version   "1.00"
double oBuf[];
double mBuffer[];
int mHandle;
int FH;
double flecha = 0;
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
  
static datetime LastBar = 0;
datetime ThisBar = (datetime)SeriesInfoInteger(_Symbol,PERIOD_CURRENT,SERIES_LASTBAR_DATE);

if(LastBar != ThisBar) //Si se genero una nueva vela
  {
   LastBar = ThisBar;
   Print("Nueva barra");
   double ASK;
   SymbolInfoDouble(Symbol(),SYMBOL_ASK,ASK);
   flecha++;
   ObjectCreate(0,"Flecha" + DoubleToString(flecha,8),25,0,TimeCurrent(),ASK);
   
   FH=FileOpen("Test.csv",FILE_IS_CSV|FILE_WRITE|FILE_READ,",");
   FileSeek(FH,0,SEEK_END);
   FileWrite(FH,ASK);
   
  }  

   
  }
//+------------------------------------------------------------------+
