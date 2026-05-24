package com.dusk.game
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class debugger extends MovieClip
   {
       
      
      private var zbtemp:Array;
      
      private var _gc;
      
      private var autoKill:Boolean = false;
      
      private var zbtxt:TextField;
      
      private var zbbtn:TextField;
      
      private var objtxt:TextField;
      
      private var objbtn:TextField;
      
      private var roletxt:TextField;
      
      private var rolebtn:TextField;
      
      private var logtxt:TextField;
      
      public function debugger()
      {
         this.zbtemp = new Array();
         super();
      }
      
      private function killmons() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         if(this.autoKill)
         {
            _loc1_ = this._gc.pWorld.monsterArray;
            if(!_loc1_)
            {
               return;
            }
            for(_loc2_ in _loc1_)
            {
               _loc1_[_loc2_].reduceHp(99999999,true);
               trace("杀怪完成");
            }
         }
      }
      
      private function keyFunc(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.F12)
         {
            this._gc.player1.setLhValue(9000000);
            this._gc.player1.setCurLevel(75);
            this._gc.player1.setCurExp(0);
            this._gc.player1.setLuckData(20);
            this._gc.Objectdata.turntableScore = 99999999;
            this._gc.curBigStage = 23;
            this._gc.curBigLevel = 1;
         }
         if(param1.keyCode == Keyboard.F9)
         {
            if(this.autoKill)
            {
               this.autoKill = false;
               this.logtxt.text = "杀怪关";
            }
            else
            {
               this.autoKill = true;
               this.logtxt.text = "杀怪开";
            }
         }
         if(param1.keyCode == Keyboard.Q)
         {
            this.logtxt.text = String(this._gc.curStage) + "," + String(this._gc.curLevel);
         }
         if(param1.keyCode == Keyboard.F1)
         {
            this._gc.hero1.getPet().petInfo.setCurExper(999999);
         }
      }
      
      private function addzb(param1:MouseEvent) : *
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = this.zbtxt.text.split("|");
         if(!this.zbtxt.text)
         {
            this.zbtxt.text = "输入装备";
            return;
         }
         if(this.zbtxt.text == "输入装备")
         {
            return;
         }
         if(this.zbtxt.text.indexOf("mul") != -1)
         {
            _loc2_ = this.zbtxt.text.split("{");
            if(_loc2_[1] == "level")
            {
               this._gc.player1.setCurLevel(this._gc.player1.getCurLevel() + _loc2_[2]);
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_[2])
            {
               this.genzb(_loc2_[1]);
               _loc3_++;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               this.genzb(_loc2_[_loc4_]);
               _loc4_++;
            }
         }
      }
      
      private function genzb(param1:String) : void
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
            _loc1_ = this._gc.allEquip.findByName(param1).type;
            this.logtxt.text = "";
         }
         catch(e:Error)
         {
            zbtxt.text = "装备错误！";
            logtxt.text = param1;
            return;
         }
         switch(_loc1_)
         {
            case "zbfb":
            case "zbwq":
            case "zbfj":
            case "zbsp":
            case "zbtx":
               _loc3_ = this._gc.allEquip.findByName(param1);
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
               this._gc.player1.zblist.push(_loc3_);
               this.logtxt.text = "添加完成";
               this.logtxt.textColor = int(Math.random() * 1000000);
               if(_loc1_ == "zbfb")
               {
                  this.logtxt.text = _loc3_.getWX();
               }
               break;
            case "wpqhs":
            case "zbwp":
               this._gc.putQhsInBackPack(this._gc.player1,this._gc.allEquip.findByName(param1).getFillName());
               this.logtxt.text = "添加完成";
               this.logtxt.textColor = int(Math.random() * 1000000);
               break;
            case "zbsz":
            case "zbcb":
               this._gc.allEquip.reNewAll();
               _loc2_ = this._gc.allEquip.findByName(this._gc.allEquip.findByName(param1).getFillName());
               _loc2_.setFashionTime(this._gc.curdate);
               _loc2_.upStrengthValue(7);
               this._gc.player1.szlist.push(_loc2_);
               this.logtxt.text = "添加完成";
               this.logtxt.textColor = int(Math.random() * 1000000);
         }
      }
      
      private function addzbByObj(param1:MouseEvent) : void
      {
         if(!this.objtxt.text || this.objtxt.text == "位置")
         {
            this.objtxt.text = "位置";
            return;
         }
         var _loc2_:Array = (this.objtxt.text as String).split(",");
         if(!_loc2_ || _loc2_.length != 2)
         {
            this.logtxt.text = "格式错误";
            return;
         }
         var _loc3_:Class = getDefinitionByName("event::CommonEvent");
         var _loc4_:Class = getDefinitionByName("my::MainGame");
         this._gc.curStage = _loc2_[0];
         this._gc.curLevel = _loc2_[1];
         if(_loc4_.getInstance())
         {
            _loc4_.getInstance().destroyGame();
         }
         this._gc.eventManger.dispatchEvent(new _loc3_("ReStart"));
      }
      
      private function changeRole(param1:MouseEvent) : void
      {
         if(!this.roletxt.text || this.roletxt.text == "职业代号")
         {
            return;
         }
         switch(this.roletxt.text)
         {
            case "wk":
               this._gc.player1.roleid = 1;
               break;
            case "ts":
               this._gc.player1.roleid = 2;
               break;
            case "bj":
               this._gc.player1.roleid = 3;
               break;
            case "ss":
               this._gc.player1.roleid = 4;
               break;
            default:
               this.logtxt.text = "悟空wk";
               this.logtxt.textColor = 16711680;
         }
         this.logtxt.text = "转职成功";
         this.logtxt.textColor = 0;
      }
   }
}
