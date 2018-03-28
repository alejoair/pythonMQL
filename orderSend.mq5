//+------------------------------------------------------------------+
//|                                                  orderSend.h.mq5 |
//|                                                     Alejocuartas |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Alejocuartas"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| My function                                                      |
//+------------------------------------------------------------------+
// int MyCalculator(int value,int value2) export
//   {
//    return(value+value2);
//   }
//+------------------------------------------------------------------+
MqlTradeResult enviarOrden(string tipo, int sl, int tp) export 
{


int EXPERT_MAGIC = 123456;
double point = SymbolInfoDouble(Symbol(),SYMBOL_POINT);
double ask = SymbolInfoDouble(Symbol(),SYMBOL_ASK);
double bid = SymbolInfoDouble(Symbol(),SYMBOL_BID);
int spread = SymbolInfoInteger(Symbol(),SYMBOL_SPREAD);


MqlTradeRequest request={0};
MqlTradeResult  result={0};


if(tipo=="buy"){
   Print("compra");
   request.type = ORDER_TYPE_BUY;
   request.tp = ask + (tp*point); 
   request.sl = bid - (sl*point);
   request.price    = SymbolInfoDouble(Symbol(),SYMBOL_ASK);  
}else{
   Print("Bid : ",bid);
   Print("Spread : ",spread);
   Print("Stoplevels: ",SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL));
   request.type = ORDER_TYPE_SELL;
   request.tp = bid - (tp*point); 
   request.sl = ask + (sl*point); 
   request.price    =SymbolInfoDouble(Symbol(),SYMBOL_BID);
}



request.action   =TRADE_ACTION_DEAL;                     // type of trade operation
request.symbol   =Symbol();                              // symbol
request.volume   =0.01;                                   // volume of 0.1 lot
                       // order type
 // price for opening
request.deviation=5;                                     // allowed deviation from the price
request.magic    =EXPERT_MAGIC; 
request.type_filling = SYMBOL_FILLING_FOK;


OrderSend(request,result);
return(result);

}

