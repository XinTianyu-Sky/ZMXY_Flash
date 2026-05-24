package loader
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.setTimeout;
   
   public class Aloader
   {
       
      
      public var urls:Array;
      
      public var _i:uint;
      
      public var view;
      
      public var gc:Config;
      
      private var deMc;
      
      private var firstLoader:Loader;
      
      private var loadIndex:int = 0;
      
      private var after:Function;
      
      public function Aloader()
      {
         this.urls = ["BaJie.swf","ShaShen.swf","WuKong.swf","OtherMat.swf","Music.swf","Common.swf","backpack.swf","RoleSprite.swf","SD.swf","EIcon.swf","pet.swf","MagicWeapon.swf"];
         super();
         this.gc = Config.getInstance();
      }
      
      public function init() : *
      {
         var firstLoader:Loader = null;
         firstLoader = new Loader();
         firstLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:*):*
         {
            firstLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,arguments.callee);
            _i = 0;
            deMc = firstLoader.content;
            next();
            firstLoader.unload();
            firstLoader = null;
         });
         firstLoader.load(new URLRequest("Decrypt.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
      }
      
      private function completeHandler(param1:Event) : *
      {
         var evt:Event = param1;
         setTimeout(function():*
         {
            if(loadIndex < urls.length)
            {
               firstLoader.load(new URLRequest(urls[loadIndex]),new LoaderContext(false,ApplicationDomain.currentDomain));
               ++loadIndex;
            }
            else
            {
               firstLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
               firstLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,loadProcess);
               firstLoader.unload();
               firstLoader = null;
               GMain.getInstance().processComplete();
               gc.eventManger.dispatchEvent(new CommonEvent("LoadOver"));
            }
         },100);
      }
      
      private function loadProcess(param1:ProgressEvent) : void
      {
         var _loc2_:int = int(param1.bytesLoaded / param1.bytesTotal * 100);
         GMain.getInstance().showProgress(_loc2_,this.loadIndex);
      }
      
      public function loadByName(param1:String, param2:Function) : void
      {
         this.deMc.loadByName(param1,param2);
      }
      
      private function completeHandler2(param1:Event) : *
      {
         this.firstLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.completeHandler2);
         this.firstLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.loadProcess);
         this.firstLoader.unload();
         this.firstLoader = null;
         GMain.getInstance().processComplete();
         this.after();
      }
      
      private function loadProcess2(param1:ProgressEvent) : void
      {
         var _loc2_:int = int(param1.bytesLoaded / param1.bytesTotal * 100);
         GMain.getInstance().showLoadByStageAndLevelProgress(_loc2_);
      }
      
      public function next() : *
      {
         if(this._i >= this.urls.length)
         {
            GMain.getInstance().processComplete();
            this.gc.eventManger.dispatchEvent(new CommonEvent("LoadOver"));
            return;
         }
         this.deMc.doDecrypt(this.urls[this._i++],this.next,this._i + 1);
      }
   }
}
