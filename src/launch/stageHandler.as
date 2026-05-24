package com.dusk.AUtils
{
   import flash.display.*;
   
   public class stageHandler
   {
      
      public static var _mainStage:Stage;
      
      public static var _mc:MovieClip;
      
      public static var _mask:Shape;
       
      
      public function stageHandler()
      {
         super();
      }
      
      public static function set stageQuality(param1:String) : void
      {
         if(_mainStage)
         {
            _mainStage.quality = param1;
         }
      }
      
      public static function get stageQuality() : String
      {
         if(_mainStage)
         {
            return _mainStage.quality;
         }
      }
      
      public static function set stageFrameRate(param1:Number) : void
      {
         if(_mainStage)
         {
            _mainStage.frameRate = param1;
         }
      }
      
      public static function get stageFrameRate() : Number
      {
         if(_mainStage)
         {
            return _mainStage.frameRate;
         }
      }
      
      public static function get gameMC() : MovieClip
      {
         if(_mc)
         {
            return _mc as MovieClip;
         }
      }
      
      public static function closeWindow() : void
      {
         if(_mainStage)
         {
            _mainStage.nativeWindow.close();
         }
      }
   }
}
