package com.dusk.game
{
   import flash.display.*;
   import flash.utils.*;
   
   public class gameLink
   {
       
      
      public var gc;
      
      public var player1;
      
      public var player2;
      
      public var hero1;
      
      public var hero2;
      
      public var attrib1;
      
      public var attrib2;
      
      public function gameLink()
      {
         super();
         if(!allConst.IS_DEBUG)
         {
            return;
         }
         try
         {
            this.gc = getDefinitionByName("config.Config").getInstance();
            this.player1 = this.gc.player1;
            this.attrib1 = this.player1.Role;
            role1 = this.gc.role1;
            if(this.gc.playNum - 1)
            {
               this.player2 = this.gc.player2;
               this.attrib2 = this.player2.Role;
               role2 = this.gc.role2;
            }
         }
         catch(e:*)
         {
            loger.logErr(e.message,true);
         }
      }
      
      public function getLhValue(param1:int) : int
      {
         if(this.gc)
         {
            return this.gc["palyer" + param1].getLhValue();
         }
      }
      
      public function killMons() : void
      {
         if(!this.gc || !this.gc.pWorld || !this.gc.pWorld.monsterArray)
         {
            trace("init failed");
            return;
         }
         var _loc1_:* = this.gc.pWorld.monsterArray;
         for(mon in _loc1_)
         {
            _loc1_[mon].reduceHp(99999999,true);
            trace("杀怪完成");
         }
      }
      
      public function genzb(param1:String) : void
      {
         var _loc1_:String = null;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(!param1)
         {
            return;
         }
         try
         {
            _loc1_ = this.gc.allEquip.findByName(param1).type;
            logtxt.text = "";
         }
         catch(e:*)
         {
            loger.logErr(param1 + "生成错误！");
            return;
         }
         switch(_loc1_)
         {
            case "zbfb":
            case "zbwq":
            case "zbfj":
            case "zbsp":
            case "zbtx":
               _loc3_ = this.gc.allEquip.findByName(param1);
               if(_loc1_ == "zbwq" || _loc1_ == "zbfj" || _loc1_ == "zbsp")
               {
                  _loc3_.upStrengthValue(7);
               }
               if(_loc1_ == "zbfb")
               {
                  trace(_loc3_.getWX());
                  trace(_loc3_.getWX().length);
                  if(_loc3_.getWX().length < 8)
                  {
                     this.genzb(param1);
                     return;
                  }
                  _loc3_.setELevel(1);
               }
               this.gc.player1.zblist.push(_loc3_);
               loger.logToDebug("添加完成");
               if(_loc1_ == "zbfb")
               {
                  logtxt.text = _loc3_.getWX();
               }
               break;
            case "wpqhs":
            case "zbwp":
               this.gc.putQhsInBackPack(this.player1,this.gc.allEquip.findByName(param1).getFillName());
               loger.logToDebug("添加完成");
               break;
            case "zbsz":
            case "zbcb":
               this.gc.allEquip.reNewAll();
               _loc2_ = this.gc.allEquip.findByName(this.gc.allEquip.findByName(param1).getFillName());
               _loc2_.setFashionTime(this.gc.curdate);
               _loc2_.upStrengthValue(7);
               this.gc.player1.szlist.push(_loc2_);
               loger.logToDebug("添加完成");
         }
      }
      
      public function addExp(param1:String, param2:int) : void
      {
         if(!tartget)
         {
            loger.logErr("tartget undefined");
            return;
         }
         var _loc3_:* = getDefinitionByName("event.CommonEvent");
         switch(tartget)
         {
            case "player1":
               this.attrib1.dispatchEvent(new _loc3_("AddExper",[param2]));
               break;
            case "player2":
               this.attrib2.dispatchEvent(new _loc3_("AddExper",[param2]));
               break;
            case "pet1":
               this.hero1.getPet().petInfo.setCurExper(this.hero1.getPet().petInfo.getCurExper() + param2);
               break;
            case "pet2":
               this.hero2.getPet().petInfo.setCurExper(this.hero2.getPet().petInfo.getCurExper() + param2);
         }
      }
      
      public function switchRole(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         switch(param1)
         {
            case "wk":
               this.gc.player1.roleid = 1;
               break;
            case "ts":
               this.gc.player1.roleid = 2;
               break;
            case "bj":
               this.gc.player1.roleid = 3;
               break;
            case "ss":
               this.gc.player1.roleid = 4;
         }
         loger.logTime("转职成功");
      }
      
      public function trans(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:Array = (param1 as String).split(",");
         if(!_loc2_ || _loc2_.length != 2)
         {
            logtxt.text = "格式错误";
            return;
         }
         var _loc3_:* = getDefinitionByName("event.CommonEvent");
         var _loc4_:* = getDefinitionByName("my.MainGame");
         this.gc.curStage = _loc2_[0];
         this.gc.curLevel = _loc2_[1];
         if(_loc4_ && _loc4_.getInstance())
         {
            _loc4_.getInstance().destroyGame();
         }
         this.gc.eventManger.dispatchEvent(new _loc3_("ReStart"));
      }
   }
}
