package storage
{
   import config.Config;
   import event.CommonEvent;
   import export.HeroBuff;
   import export.saveInterface.SaveInter;
   import flash.net.SharedObject;
   
   public class MemoryClass
   {
       
      
      private var gc:Config;
      
      public var so:SharedObject;
      
      private var mystorage:Object;
      
      private var otherstorage:Object;
      
      private var saveIndex:uint;
      
      private var date:Date;
      
      public function MemoryClass()
      {
         this.date = new Date();
         super();
         this.gc = Config.getInstance();
         if(this.gc.eventManger.hasEventListener("SaveGame"))
         {
            this.gc.eventManger.removeEventListener("SaveGame",this.saveGame);
            this.gc.eventManger.addEventListener("SaveGame",this.saveGame,false,0,true);
         }
         else
         {
            this.gc.eventManger.addEventListener("SaveGame",this.saveGame,false,0,true);
         }
         if(this.gc.eventManger.hasEventListener("ReadGame"))
         {
            this.gc.eventManger.removeEventListener("ReadGame",this.readGame);
            this.gc.eventManger.addEventListener("ReadGame",this.readGame,false,0,true);
         }
         else
         {
            this.gc.eventManger.addEventListener("ReadGame",this.readGame,false,0,true);
         }
      }
      
      public function getStorage() : void
      {
         var _loc2_:Object = null;
         var _loc1_:* = this.mystorage;
         if(_loc1_)
         {
            if(_loc1_.luserid)
            {
               if(this.gc.getLocalUserId() != _loc1_.luserid)
               {
                  this.gc.ts.setTxt("存档用户名不符合");
                  this.gc.stage.addChild(this.gc.ts);
                  return;
               }
            }
            this.gc.playNum = _loc1_.playerNum;
            this.gc.hasget = _loc1_.hasget;
            this.gc.hasgetsorry = _loc1_.hasgetsorry;
            if(_loc1_.player1_obj != undefined)
            {
               this.gc.player1.setSaveObj(_loc1_.player1_obj);
            }
            if(_loc1_.player2_obj != undefined)
            {
               this.gc.player2.setSaveObj(_loc1_.player2_obj);
            }
            this.gc.curBigLevel = _loc1_.curBigLevel;
            this.gc.curBigStage = _loc1_.curBigStage;
            if(_loc1_.nymark)
            {
               this.gc.nymark = _loc1_.nymark;
            }
            if(_loc1_.hdInfo)
            {
               this.gc.hdInfo = String(_loc1_.hdInfo).split(",");
            }
            else
            {
               this.gc.hdInfo = [];
            }
            if(_loc1_.qhsInfo)
            {
               this.gc.qhsInfo = String(_loc1_.qhsInfo).split(",");
            }
            else
            {
               this.gc.qhsInfo = [];
            }
            this.gc.heroBuffArray.length = 0;
            if(_loc1_.hpUpBuffCount > 0)
            {
               _loc2_ = {
                  "name":HeroBuff.HPUPBUFF,
                  "count":_loc1_.hpUpBuffCount
               };
               this.gc.heroBuffArray.push(_loc2_);
            }
         }
      }
      
      public function setStorage(param1:int = -1) : void
      {
         this.mystorage = {};
         this.mystorage.luserid = this.gc.getLocalUserId();
         this.mystorage.playerNum = this.gc.playNum;
         this.mystorage.hasget = this.gc.hasget;
         this.mystorage.hasgetsorry = this.gc.hasgetsorry;
         if(this.gc.player1.roleid > 0)
         {
            this.mystorage.player1_obj = this.gc.player1.getSaveObj();
         }
         if(this.gc.player2.roleid > 0)
         {
            this.mystorage.player2_obj = this.gc.player2.getSaveObj();
         }
         this.mystorage.curBigStage = this.gc.curBigStage;
         this.mystorage.curBigLevel = this.gc.curBigLevel;
         this.mystorage.nymark = this.gc.nymark;
         this.mystorage.hdInfo = this.gc.hdInfo.join(",");
         this.mystorage.qhsInfo = this.gc.qhsInfo.join(",");
         var _loc2_:String = "";
         if(this.gc.player1.roleid > 0)
         {
            _loc2_ += this.gc.player1.getRoleName() + " ";
         }
         if(this.gc.player2.roleid > 0)
         {
            _loc2_ += this.gc.player2.getRoleName();
         }
         if(_loc2_ == "")
         {
            this.gc.ts.setTxt("存档异常,如果继续存档,可能导致标题为空,损坏存档!请刷新网页~");
            this.gc.stage.addChild(this.gc.ts);
            return;
         }
         if(param1 == -1)
         {
            if(!this.gc.saveInter)
            {
               this.gc.saveInter = AUtils.getNewObj("export.saveInterface.SaveInter") as SaveInter;
            }
            this.gc.saveInter.state = "save";
            this.gc.stage.addChild(this.gc.saveInter);
         }
         else
         {
            GMain.serviceHold.saveData(_loc2_,this.mystorage,false,param1);
         }
      }
      
      public function storageValue(param1:int, param2:*) : void
      {
         this.gc.opening = true;
         if(param1 == 7)
         {
            this.otherstorage = param2;
            this.gc.openPig = this.otherstorage.openPig;
         }
         else
         {
            this.mystorage = param2;
         }
      }
      
      public function setOtherStorage() : void
      {
         this.otherstorage = {};
         GMain.serviceHold.saveData("other",this.otherstorage,false,7);
      }
      
      private function saveGame(param1:CommonEvent) : void
      {
         var _loc2_:int = param1.data[0];
         this.gc.saveId = _loc2_;
         var _loc3_:String = "";
         if(this.gc.player1.roleid > 0)
         {
            _loc3_ += this.gc.player1.getRoleName() + " ";
         }
         if(this.gc.player2.roleid > 0)
         {
            _loc3_ += this.gc.player2.getRoleName();
         }
         if(_loc3_ == "")
         {
            this.gc.ts.setTxt("存档异常,如果继续存档,可能导致标题为空,损坏存档!请刷新网页~");
            this.gc.stage.addChild(this.gc.ts);
            return;
         }
         GMain.serviceHold.saveData(_loc3_,this.mystorage,false,this.gc.saveId);
      }
      
      private function readGame(param1:CommonEvent) : void
      {
         var _loc2_:int = param1.data[0];
         this.gc.saveId = _loc2_;
         GMain.serviceHold.getData(false,this.gc.saveId);
      }
   }
}
