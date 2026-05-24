package com.dusk.game
{
   import com.dusk.AUtils.*;
   
   public class loger
   {
       
      
      public var debug;
      
      public function loger()
      {
         super();
      }
      
      public static function log(param1:String, param2:Boolean = false) : *
      {
         if(param2)
         {
            trace(param1);
            fileHandler.append(param1 + "\n",fileHandler.getAppFloderFileUrl("log.log"));
         }
         else
         {
            fileHandler.append(param1 + "\n",fileHandler.getAppFloderFileUrl("log.log"));
         }
      }
      
      public static function logTime(param1:String) : *
      {
         fileHandler.append(new Date().fullYear + "." + (int(new Date().month) + 1) + "." + new Date().date + " " + new Date().hours + ":" + new Date().minutes + "\n",fileHandler.getAppFloderFileUrl(param1));
         trace(new Date().fullYear + "." + (int(new Date().month) + 1) + "." + new Date().date + " " + new Date().hours + ":" + new Date().minutes);
      }
      
      public static function logErr(param1:String, param2:Boolean = false) : *
      {
         if(param2)
         {
            fileHandler.append(param1 + "\n",fileHandler.getAppFloderFileUrl("log.log"));
            return;
         }
         trace(param1);
         throw param1;
      }
      
      public static function logToDebug(param1:String) : void
      {
         if(!debug)
         {
            return;
         }
      }
   }
}
