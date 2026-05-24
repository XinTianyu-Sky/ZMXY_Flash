package
{
   import com.dusk.AUtils.*;
   import com.dusk.game.*;
   import com.hurlant.crypto.*;
   import com.hurlant.util.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filesystem.*;
   import flash.media.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class MainLoad extends MovieClip
   {
      
      public static var Instance:MainLoad;
       
      
      private var _main1:Class;
      
      private var _main2:Class;
      
      private var key:String;
      
      private const $key:String = "YJAjoEQjOwA==";
      
      private var garbageArr:Array;
      
      private var _memory:TextField;
      
      private var _memoryTimer:Timer;
      
      private var hasAlert:Boolean = false;
      
      private var _debug:debugger;
      
      private var _gl:gameLink;
      
      public var settingObj:Object;
      
      private var FPStxt:TextField;
      
      private var FPS:FPScounter;
      
      private var sen_mask:Shape;
      
      private var loader:Loader;
      
      private var uloader:URLLoader;
      
      private var lContext:LoaderContext;
      
      public function MainLoad()
      {
         this._main1 = MainLoad__main1;
         this._main2 = MainLoad__main2;
         this.key = new String();
         this.garbageArr = [];
         this._memoryTimer = new Timer(5000,0);
         this.loader = new Loader();
         this.uloader = new URLLoader();
         this.lContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         super();
         if(stage)
         {
            this.init();
         }
         else if(!this.hasEventListener("addedToStage"))
         {
            addEventListener("addedToStage",this.init);
         }
      }
      
      public static function get I() : MainLoad
      {
         return Instance;
      }
      
      private function init(param1:Boolean = true) : void
      {
         if(hasEventListener("addedToStage"))
         {
            removeEventListener("addedToStage",this.init);
         }
         this.lContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         stageHandler._mainStage = stage;
         DisplayObject.prototype["@dusk_s"] = stage;
         DisplayObject.prototype.setPropertyIsEnumerable("@dusk_s",false);
         Instance = this;
         this.key += allConst.key1;
         this.key += this.$key;
         if(allConst.NEED_MASK)
         {
            this.initMask();
         }
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyFunc);
         this.getSettings();
         this.getNewVerInfo(allConst.GET_NEW_URL);
         this.preMainLoad();
      }
      
      private function initMask() : void
      {
         this.sen_mask = new Shape();
         this.sen_mask.graphics.beginFill(0);
         this.sen_mask.graphics.drawRect(0,0,940,590);
         this.sen_mask.graphics.endFill();
         this.sen_mask.x = 0;
         this.sen_mask.y = 0;
      }
      
      private function decrypt(param1:ByteArray) : ByteArray
      {
         var _loc2_:int = true - 1 as Number;
         var _loc3_:* = new ByteArray();
         if(!param1)
         {
            throw "data inavailable";
         }
         while(_loc2_ < param1.length)
         {
            param1.position = _loc2_;
            if(!(param1.readUTFBytes(3) != "ZWS" && param1.readUTFBytes(3) != "CWS"))
            {
               if(!allConst.IS_DEBUG)
               {
                  if(_loc2_ == 0)
                  {
                     stage.nativeWindow.close();
                     return;
                  }
               }
               _loc3_.writeBytes(param1,_loc2_);
            }
            _loc2_++;
         }
         return _loc3_ as ByteArray;
      }
      
      private function keyFunc(param1:KeyboardEvent) : void
      {
         var _loc2_:File = null;
         var _loc3_:NativeProcessStartupInfo = null;
         var _loc4_:NativeProcess = null;
         if(param1.keyCode == Keyboard.F3)
         {
            System.pauseForGCIfCollectionImminent(0.5);
         }
         if(param1.keyCode == Keyboard.F11)
         {
            switch(stage.displayState)
            {
               case "fullScreenInteractive":
                  stage.displayState = "normal";
                  break;
               case "normal":
                  stage.displayState = "fullScreenInteractive";
            }
            if(this.settingObj && this.settingObj["displayState"] != null)
            {
               this.settingObj["displayState"] = stage.displayState;
            }
            this.saveSettings();
         }
         if(param1.keyCode == Keyboard.F5)
         {
            _loc2_ = File.applicationDirectory.resolvePath("造梦西游之再续天庭.exe");
            _loc3_ = new NativeProcessStartupInfo();
            _loc3_.executable = _loc2_;
            (_loc4_ = new NativeProcess()).start(_loc3_);
            stage.nativeWindow.close();
         }
      }
      
      private function preMainLoad() : void
      {
         var _loc1_:ByteArray = new this._main1();
         var _loc2_:ByteArray = new this._main2();
         _loc1_.position = int(false);
         var _loc3_:ByteArray = Crypto.getHash(Base64.decode("bWQ1")).hash(_loc1_);
         _loc3_.position = int();
         _loc1_.position = int(false);
         if(!allConst.IS_DEBUG)
         {
            if(this.key != Base64.encodeByteArray(_loc3_))
            {
               throw "data modefided invalidly!";
            }
            this.loadGarbageSWF(_loc2_,50);
         }
         this.startMainLoad(this.decrypt(_loc1_));
      }
      
      private function startMainLoad(param1:ByteArray) : void
      {
         if(!param1)
         {
            throw "data inavailable";
         }
         this.lContext.allowCodeImport = true;
         this.loader[getQualifiedClassName(this.loader).split("::")[1].toString().toLowerCase().slice(0,4) + new String("Bytdusk").slice(0,3) + new String("es")](param1,this.lContext);
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
      }
      
      private function onComplete(param1:Event) : void
      {
         var _loc3_:debugger = null;
         this.loader.removeEventListener(Event.COMPLETE,this.onComplete);
         var _loc2_:MovieClip = this.loader.content as MovieClip;
         this.loader.unload();
         this.loader = null;
         stage.addChild(_loc2_);
         if(allConst.NEED_MASK)
         {
            addChild(this.sen_mask);
            stageHandler._mask = this.sen_mask;
            _loc2_.mask = this.sen_mask;
         }
         stage.setChildIndex(_loc2_,stage.numChildren - 1);
         _loc2_.play();
         stageHandler._mainStage = stage;
         stageHandler._mc = _loc2_;
         if(allConst.IS_DEBUG && allConst.NEED_DEBUGGER)
         {
            stage.color = 16777215;
            stage.align = StageAlign.LEFT;
            _loc3_ = new debugger();
            _loc3_.x = 940;
            _loc3_.y = 0;
            stage.addChild(_loc3_);
         }
         this.initUI(allConst.IS_DEBUG);
         this.showFPS(_loc2_);
         this.logInfo();
         this.applySettings();
      }
      
      private function initUI(param1:Boolean) : *
      {
         this.showMemory();
         this.showOSinfo();
         this.initMouseUI(allConst.USE_MOUSE_UI);
      }
      
      private function showMemory() : void
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0);
         _loc1_.graphics.drawRect(0,0,112,32);
         _loc1_.graphics.endFill();
         _loc1_.alpha = 0;
         _loc1_.addEventListener(MouseEvent.ROLL_OUT,function(param1:MouseEvent):void
         {
            param1.target.alpha = 0;
         });
         _loc1_.addEventListener(MouseEvent.ROLL_OVER,function(param1:MouseEvent):void
         {
            param1.target.alpha = 0.7;
         });
         stage.addChild(_loc1_);
         this._memory = new TextField();
         this._memory.autoSize = "left";
         this._memory.y = 15;
         this._memory.textColor = 16777215;
         this._memory.mouseEnabled = false;
         this._memory.text = "MEMORY : 0 mb";
         stage.addChild(this._memory);
         this._memoryTimer.addEventListener("timer",this.updateMemory);
         this._memoryTimer.start();
      }
      
      private function updateMemory(param1:TimerEvent) : void
      {
         var _loc2_:Number = Number(System.privateMemory / 1048576).toFixed(2);
         if(_loc2_ >= 1300 && !this.hasAlert)
         {
            ApplicationDomain.currentDomain.getDefinition("config::Config").getInstance().alert("内存占用过大，建议保存后重启游戏！",2);
            this.hasAlert = true;
         }
         if(_loc2_ >= 1450)
         {
            ApplicationDomain.currentDomain.getDefinition("config::Config").getInstance().alert("内存占用过大，请立即保存后重启游戏！",3);
         }
         this._memory.text = "内存 : " + _loc2_ + " mb";
      }
      
      private function showOSinfo() : void
      {
         var _loc1_:TextField = new TextField();
         _loc1_.autoSize = "left";
         _loc1_.y = 570;
         _loc1_.textColor = 255;
         _loc1_.text = "";
         if(allConst.IS_DEBUG)
         {
            _loc1_.appendText("OS:" + Capabilities.os + ", isDebugger:" + Capabilities.isDebugger + ", AIR/FlashPlayer version:" + Capabilities.version);
         }
         _loc1_.mouseEnabled = false;
         stage.addChild(_loc1_);
      }
      
      private function showFPS(param1:DisplayObject) : void
      {
         this.FPStxt = new TextField();
         this.FPStxt.textColor = 16750848;
         this.FPStxt.y = 0;
         this.FPStxt.autoSize = "left";
         this.FPStxt.text = "FPS";
         this.FPStxt.mouseEnabled = false;
         stage.addChild(this.FPStxt);
         this.FPS = new FPScounter(param1,this.FPStxt);
      }
      
      private function logInfo() : void
      {
         loger.log("::Launcher initOK");
         loger.log(Capabilities.os);
         loger.logTime("log.log");
         loger.log("");
      }
      
      private function loadGarbageSWF(param1:ByteArray, param2:int) : void
      {
         var _loc4_:ByteArray = null;
         var _loc3_:int = 0;
         while(_loc3_ < param2)
         {
            param1.position = 0;
            (_loc4_ = new ByteArray()).writeBytes(param1,0,int(param1["length"]));
            this.garbageArr.push(_loc4_);
            _loc4_ = null;
            _loc3_++;
         }
      }
      
      private function initMouseUI(param1:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:colourful_circle = new colourful_circle();
         stage.addChild(_loc2_);
         _mc.addEventListener(MouseEvent.MOUSE_MOVE,_loc2_.MouseMoveEvent);
      }
      
      private function getNewVerInfo(param1:String) : void
      {
         this.uloader.dataFormat = URLLoaderDataFormat.TEXT;
         this.uloader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            var tmp1:String = uloader.data;
            var _loc2_:int = tmp1.indexOf("note_title") + String("note_title").length + 3;
            var _loc3_:int = tmp1.indexOf("note_summary") - 3;
            try
            {
               Number(tmp1.slice(_loc2_,_loc3_));
            }
            catch(e:*)
            {
               uloader.removeEventListener(Event.COMPLETE,arguments.callee);
               uloader.removeEventListener(IOErrorEvent.IO_ERROR,arguments.callee);
               uloader.close();
               uloader = null;
               return;
            }
            trace("标题:" + tmp1.slice(_loc2_,_loc3_));
            allConst.NEW_VER_INFO["gameVersion"] = tmp1.slice(_loc2_,_loc3_);
            _loc2_ = tmp1.indexOf("note_summary") + String("note_summary").length + 3;
            _loc3_ = tmp1.indexOf("note_ctime") - 3;
            trace("内容:" + tmp1.slice(_loc2_,_loc3_));
            allConst.NEW_VER_INFO["newInfo"] = tmp1.slice(_loc2_,_loc3_).split("\\\\n").join("\n");
            uloader.removeEventListener(Event.COMPLETE,arguments.callee);
            uloader.removeEventListener(IOErrorEvent.IO_ERROR,arguments.callee);
            uloader.close();
            uloader = null;
            allConst.NEW_VER_INFO["ErrInfo"] = 0;
            if(allConst.IS_DEBUG)
            {
               return;
            }
            checkVer();
         });
         this.uloader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:IOErrorEvent):void
         {
            uloader.removeEventListener(Event.COMPLETE,arguments.callee);
            uloader.removeEventListener(IOErrorEvent.IO_ERROR,arguments.callee);
            uloader.close();
            uloader = null;
            trace(param1.text);
            allConst.NEW_VER_INFO["ErrInfo"] = param1.text;
         });
         try
         {
            this.uloader.load(new URLRequest(param1));
         }
         catch(e:*)
         {
         }
      }
      
      private function checkVer() : void
      {
      }
      
      private function getSettings() : void
      {
         var _loc1_:String = null;
         try
         {
            _loc1_ = fileHandler.read(fileHandler.getAppFloderFileUrl("gameData/gameConfig.ini"));
            this.settingObj = JSON.parse(_loc1_);
         }
         catch(e:Error)
         {
            trace(e.message);
            settingObj = new Object();
            settingObj.defaultSndState = true;
            settingObj.displayState = "normal";
         }
      }
      
      public function saveSettings() : void
      {
         if(!this.settingObj)
         {
            this.settingObj = new Object();
            this.settingObj.defaultSndState = true;
            this.settingObj.displayState = "normal";
            fileHandler.write(JSON.stringify(this.settingObj) as String,fileHandler.getAppFloderFileUrl("gameData/gameConfig.ini"));
         }
         else
         {
            fileHandler.write(JSON.stringify(this.settingObj) as String,fileHandler.getAppFloderFileUrl("gameData/gameConfig.ini"));
         }
      }
      
      private function applySettings() : void
      {
         if(!this.settingObj)
         {
            return;
         }
         if(this.settingObj["defaultSndState"] != null)
         {
            if(!this.settingObj.defaultSndState)
            {
               SoundMixer.soundTransform = new SoundTransform(0);
            }
         }
         if(this.settingObj["displayState"] != null)
         {
            stage.displayState = this.settingObj["displayState"];
         }
      }
   }
}
