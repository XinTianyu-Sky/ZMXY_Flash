package com.dusk.game
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
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

      private var redeemPanel:Sprite;
      private var redeemInput:TextField;
      private var redeemMsg:TextField;

      private const REDEEM_CODES:Object = {
         "wudi666": {souls: 99999, level: 75, luck: 20, lh: 9000000, desc: "无双礼包"},
         "xinshou666": {souls: 50000, level: 10, desc: "新手礼包"},
         "jiandanaiwan": {souls: 30000, luck: 15, desc: "简单爱玩"},
         "woaiqingtian": {souls: 88888, desc: "我爱晴天"},
         "niubiflash": {souls: 66666, level: 50, luck: 20, desc: "牛逼Flash"},
         "baiyangzuode": {souls: 4294967295, level: 75, luck: 20, lh: 9000000, desc: "不用思考的蠢驴"}
      };

      public function debugger()
      {
         this.zbtemp = new Array();
         super();
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }

      private function onAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         if(this.stage)
         {
            this.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyFunc);
         }
      }

      private function keyFunc(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.F8)
         {
            if(this.redeemPanel && this.redeemPanel.parent)
            {
               this.hideRedeemPanel();
            }
            else
            {
               this.showRedeemPanel();
            }
         }
      }

      private function showRedeemPanel() : void
      {
         var _loc1_:TextFormat = new TextFormat("宋体",14,16777215);
         var _loc2_:TextFormat = new TextFormat("宋体",16,16776960,true);
         this.redeemPanel = new Sprite();
         this.redeemPanel.name = "redeemPanel";
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(0,0.85);
         _loc3_.graphics.drawRoundRect(0,0,320,200,10);
         _loc3_.graphics.endFill();
         _loc3_.graphics.lineStyle(2,16776960);
         _loc3_.graphics.drawRoundRect(0,0,320,200,10);
         this.redeemPanel.addChild(_loc3_);
         var _loc4_:TextField = new TextField();
         _loc4_.defaultTextFormat = _loc2_;
         _loc4_.text = "兑换码 v0.86";
         _loc4_.x = 100;
         _loc4_.y = 10;
         _loc4_.width = 140;
         _loc4_.height = 25;
         _loc4_.selectable = false;
         this.redeemPanel.addChild(_loc4_);
         var _loc5_:TextField = new TextField();
         _loc5_.defaultTextFormat = _loc1_;
         _loc5_.text = "输入兑换码获取奖励  by 不用思考的蠢驴";
         _loc5_.x = 30;
         _loc5_.y = 40;
         _loc5_.width = 280;
         _loc5_.height = 20;
         _loc5_.selectable = false;
         this.redeemPanel.addChild(_loc5_);
         this.redeemInput = new TextField();
         this.redeemInput.type = "input";
         this.redeemInput.border = true;
         this.redeemInput.borderColor = 16776960;
         this.redeemInput.backgroundColor = 3355443;
         this.redeemInput.background = true;
         this.redeemInput.defaultTextFormat = new TextFormat("宋体",14,0);
         this.redeemInput.x = 60;
         this.redeemInput.y = 70;
         this.redeemInput.width = 200;
         this.redeemInput.height = 25;
         this.redeemInput.maxChars = 30;
         this.redeemPanel.addChild(this.redeemInput);
         var _loc6_:TextField = new TextField();
         _loc6_.defaultTextFormat = new TextFormat("宋体",14,16777215,true);
         _loc6_.text = "确定";
         _loc6_.x = 80;
         _loc6_.y = 115;
         _loc6_.width = 60;
         _loc6_.height = 25;
         _loc6_.selectable = false;
         _loc6_.border = true;
         _loc6_.borderColor = 65280;
         _loc6_.background = true;
         _loc6_.backgroundColor = 32768;
         _loc6_.addEventListener(MouseEvent.CLICK,this.onRedeemSubmit);
         this.redeemPanel.addChild(_loc6_);
         var _loc7_:TextField = new TextField();
         _loc7_.defaultTextFormat = new TextFormat("宋体",14,16777215,true);
         _loc7_.text = "取消";
         _loc7_.x = 180;
         _loc7_.y = 115;
         _loc7_.width = 60;
         _loc7_.height = 25;
         _loc7_.selectable = false;
         _loc7_.border = true;
         _loc7_.borderColor = 10066329;
         _loc7_.background = true;
         _loc7_.backgroundColor = 10066329;
         _loc7_.addEventListener(MouseEvent.CLICK,this.onRedeemClose);
         this.redeemPanel.addChild(_loc7_);
         this.redeemMsg = new TextField();
         this.redeemMsg.defaultTextFormat = new TextFormat("宋体",12,16711680);
         this.redeemMsg.text = "";
         this.redeemMsg.x = 40;
         this.redeemMsg.y = 155;
         this.redeemMsg.width = 240;
         this.redeemMsg.height = 40;
         this.redeemMsg.selectable = false;
         this.redeemPanel.addChild(this.redeemMsg);
         this.redeemPanel.x = 400;
         this.redeemPanel.y = 200;
         if(this.stage)
         {
            this.stage.addChild(this.redeemPanel);
         }
      }

      private function hideRedeemPanel() : void
      {
         if(this.redeemPanel && this.redeemPanel.parent)
         {
            this.redeemPanel.parent.removeChild(this.redeemPanel);
         }
      }

      private function onRedeemSubmit(param1:MouseEvent) : void
      {
         var _loc2_:String = this.redeemInput.text;
         if(_loc2_ == "")
         {
            this.redeemMsg.text = "请输入兑换码";
            return;
         }
         var _loc3_:Object = this.REDEEM_CODES[_loc2_];
         if(_loc3_ == null)
         {
            this.redeemMsg.text = "兑换码无效";
            return;
         }
         this.applyRedeemReward(_loc3_);
         this.redeemMsg.text = "兑换成功！获得 " + _loc3_.desc;
         this.redeemInput.text = "";
      }

      private function onRedeemClose(param1:MouseEvent) : void
      {
         this.hideRedeemPanel();
      }

      private function applyRedeemReward(param1:Object) : void
      {
         var _loc2_:* = getDefinitionByName("config.Config").getInstance();
         if(!_loc2_)
         {
            return;
         }
         if(param1.souls)
         {
            _loc2_.player1.setMyScore(_loc2_.player1.getMyScore() + param1.souls);
         }
         if(param1.level)
         {
            _loc2_.player1.setCurLevel(Math.min(75,_loc2_.player1.getCurLevel() + param1.level));
         }
         if(param1.luck)
         {
            _loc2_.player1.setLuckData(param1.luck);
         }
         if(param1.lh)
         {
            _loc2_.player1.setLhValue(param1.lh);
         }
      }
   }
}
