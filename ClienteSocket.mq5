//+------------------------------------------------------------------+
//|                                                ClienteSocket.mq5 |
//|                                                Alejandro Cuartas |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Alejandro Cuartas"
#property link      ""
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

int handler;
int OnInit()
  {
//---
   handler = SocketCreate();
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   SocketClose(handler); 
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {

double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK); 

char mensaje[];
StringToCharArray(DoubleToString(ask,9),mensaje);
char recibido[];

int n = SocketConnect(handler,"localhost",7800,100);
if(n == 0){
while(n==0){
   Print("intentando conectar...");
   n = SocketConnect(handler,"localhost",7800,100);
   Sleep(300);
}
Print("Conectado...");
}


SocketSend(handler,mensaje,9); 
SocketRead(handler,recibido,32,100);

//Print(CharArrayToString(recibido));

  }
//+------------------------------------------------------------------+
