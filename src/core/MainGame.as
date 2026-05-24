package my
{
   import base.BaseBullet;
   import base.BaseGameSence;
   import base.BaseHero;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import config.Config;
   import event.CommonEvent;
   import export.FloorBg;
   import export.monster.Monster1;
   import export.monster.Monster10;
   import export.monster.Monster11;
   import export.monster.Monster12;
   import export.monster.Monster13;
   import export.monster.Monster14;
   import export.monster.Monster15;
   import export.monster.Monster16;
   import export.monster.Monster17;
   import export.monster.Monster171;
   import export.monster.Monster18;
   import export.monster.Monster181;
   import export.monster.Monster19;
   import export.monster.Monster2;
   import export.monster.Monster20;
   import export.monster.Monster21;
   import export.monster.Monster22;
   import export.monster.Monster23;
   import export.monster.Monster24;
   import export.monster.Monster25;
   import export.monster.Monster26;
   import export.monster.Monster27;
   import export.monster.Monster28;
   import export.monster.Monster29;
   import export.monster.Monster3;
   import export.monster.Monster30;
   import export.monster.Monster31;
   import export.monster.Monster32;
   import export.monster.Monster33;
   import export.monster.Monster34;
   import export.monster.Monster4;
   import export.monster.Monster5;
   import export.monster.Monster6;
   import export.monster.Monster7;
   import export.monster.Monster70;
   import export.monster.Monster71;
   import export.monster.Monster72;
   import export.monster.Monster73;
   import export.monster.Monster8;
   import export.monster.Monster9;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import manager.SoundManager;
   
   public class MainGame
   {
      
      private static var _this:MainGame;
       
      
      private var gc:Config;
      
      private var root:Sprite;
      
      private var m1:Monster1;
      
      private var m2:Monster2;
      
      private var m3:Monster3;
      
      private var m4:Monster4;
      
      private var m5:Monster5;
      
      private var m6:Monster6;
      
      private var m7:Monster7;
      
      private var m8:Monster8;
      
      private var m9:Monster9;
      
      private var m10:Monster10;
      
      private var m11:Monster11;
      
      private var m12:Monster12;
      
      private var m13:Monster13;
      
      private var m14:Monster14;
      
      private var m15:Monster15;
      
      private var m16:Monster16;
      
      private var m17:Monster17;
      
      private var m171:Monster171;
      
      private var m18:Monster18;
      
      private var m181:Monster181;
      
      private var m19:Monster19;
      
      private var m20:Monster20;
      
      private var m21:Monster21;
      
      private var m22:Monster22;
      
      private var m23:Monster23;
      
      private var m24:Monster24;
      
      private var m25:Monster25;
      
      private var m26:Monster26;
      
      private var m27:Monster27;
      
      private var m28:Monster28;
      
      private var m29:Monster29;
      
      private var m30:Monster30;
      
      private var m31:Monster31;
      
      private var m32:Monster32;
      
      private var m33:Monster33;
      
      private var m34:Monster34;
      
      private var m70:Monster70;
      
      private var m71:Monster71;
      
      private var m72:Monster72;
      
      private var m73:Monster73;
      
      public function MainGame(param1:Sprite)
      {
         super();
         this.gc = Config.getInstance();
         this.root = param1;
         if(!_this)
         {
            _this = this;
         }
      }
      
      public static function getInstance() : MainGame
      {
         return _this;
      }
      
      public function GameStart() : void
      {
         var name:String = null;
         try
         {
            AUtils.getClass("files" + this.gc.curStage);
         }
         catch(e:*)
         {
            name = gc.curStage + "";
            GMain.getInstance().loader.loadByName(name,newGame);
            return;
         }
         this.newGame();
      }
      
      public function fbEnter() : void
      {
         this.destroyGame();
         if(this.gc.curStage == 2 && this.gc.curLevel == 3)
         {
            this.gc.curStage = 6;
            this.gc.curLevel = 1;
         }
         else if(this.gc.curStage == 1 && this.gc.curLevel == 2)
         {
            this.gc.curStage = 5;
            this.gc.curLevel = 1;
         }
         else if(this.gc.curStage == 3 && this.gc.curLevel == 1)
         {
            this.gc.curStage = 7;
            this.gc.curLevel = 1;
         }
         this.gc.eventManger.dispatchEvent(new Event("ReStart"));
      }
      
      public function levelClear() : void
      {
         SoundManager.play("begin");
         if(this.gc.isInHost())
         {
            this.gc.closeScoket();
            GMain.getInstance().switchSence("showStageMap");
         }
         else
         {
            if(this.gc.curStage == this.gc.curBigStage)
            {
               if(this.gc.curBigStage <= 3)
               {
                  if(this.gc.curLevel == this.gc.curBigLevel)
                  {
                     if(this.gc.curLevel == 3)
                     {
                        ++this.gc.curBigStage;
                        this.gc.curBigLevel = 1;
                     }
                     else if(this.gc.curLevel < 3)
                     {
                        ++this.gc.curBigLevel;
                     }
                  }
               }
               else if(this.gc.curBigStage == 4)
               {
                  this.gc.curBigLevel = 1;
               }
            }
            SoundManager.play("Game_Victory");
         }
         this.destroyGame();
         if(this.gc.isHideDebug)
         {
            this.doSaveGame();
         }
      }
      
      private function doSaveGame() : void
      {
         this.gc.memory.setStorage(this.gc.saveId);
      }
      
      public function createMonster(param1:int, param2:Number, param3:Number, param4:int = -1) : BaseMonster
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:BaseMonster;
         (_loc5_ = AUtils.getNewObj("export.monster.Monster" + param1)).x = param2;
         _loc5_.y = param3;
         _loc5_.sid = getTimer();
         this.gc.pWorld.monsterArray.push(_loc5_);
         if(this.gc.hero1 && this.gc.gameSence.contains(this.gc.hero1))
         {
            _loc6_ = this.gc.gameSence.getChildIndex(this.gc.hero1);
         }
         else
         {
            _loc6_ = 99999;
         }
         if(this.gc.hero2 && this.gc.gameSence.contains(this.gc.hero2))
         {
            _loc7_ = this.gc.gameSence.getChildIndex(this.gc.hero2);
         }
         else
         {
            _loc7_ = 99999;
         }
         var _loc8_:int;
         if((_loc8_ = Math.min(_loc6_,_loc7_)) != 99999)
         {
            this.gc.gameSence.addChildAt(_loc5_,_loc8_);
         }
         else
         {
            this.gc.gameSence.addChild(_loc5_);
         }
         return _loc5_;
      }
      
      public function createLikeMonster(param1:int, param2:Number, param3:Number, param4:int = -1) : BaseMonster
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:BaseMonster;
         (_loc5_ = AUtils.getNewObj("export.monster.Monster" + param1)).x = param2;
         _loc5_.y = param3;
         _loc5_.sid = getTimer();
         this.gc.pWorld.likeMonsterArray.push(_loc5_);
         if(this.gc.hero1 && this.gc.gameSence.contains(this.gc.hero1))
         {
            _loc6_ = this.gc.gameSence.getChildIndex(this.gc.hero1);
         }
         else
         {
            _loc6_ = 99999;
         }
         if(this.gc.hero2 && this.gc.gameSence.contains(this.gc.hero2))
         {
            _loc7_ = this.gc.gameSence.getChildIndex(this.gc.hero2);
         }
         else
         {
            _loc7_ = 99999;
         }
         var _loc8_:int;
         if((_loc8_ = Math.min(_loc6_,_loc7_)) != 99999)
         {
            this.gc.gameSence.addChildAt(_loc5_,_loc8_);
         }
         else
         {
            this.gc.gameSence.addChild(_loc5_);
         }
         return _loc5_;
      }
      
      public function stopGame(param1:int = 0) : void
      {
         var b:BaseHero = null;
         var m:int = 0;
         var mba1:BaseBullet = null;
         var bm:BaseMonster = null;
         var n:int = 0;
         var mba2:BaseBullet = null;
         var time:int = param1;
         this.root.removeEventListener(Event.ENTER_FRAME,this.__enterFrame);
         var i:int = 0;
         while(i < this.gc.getPlayerArray().length)
         {
            b = this.gc.getPlayerArray()[i] as BaseHero;
            m = 0;
            while(m < b.magicBulletArray.length)
            {
               mba1 = b.magicBulletArray[m] as BaseBullet;
               AUtils.stopAllChildren(mba1);
               m++;
            }
            if(!b.getCurMagicWeapon())
            {
            }
            i++;
         }
         var j:int = 0;
         while(j < this.gc.pWorld.monsterArray.length)
         {
            bm = this.gc.pWorld.monsterArray[j] as BaseMonster;
            n = 0;
            while(n < bm.magicBulletArray.length)
            {
               mba2 = bm.magicBulletArray[n] as BaseBullet;
               AUtils.stopAllChildren(mba2);
               n++;
            }
            j++;
         }
         this.gc.keyboardControl.stopKeyboardControl();
         if(time != 0)
         {
            setTimeout(function():*
            {
               continueGame();
            },time);
         }
         TweenMax.pauseAll(true,true);
         this.gc.isStopGame = true;
      }
      
      public function continueGame() : void
      {
         var _loc3_:BaseHero = null;
         var _loc4_:int = 0;
         var _loc5_:BaseBullet = null;
         var _loc6_:BaseMonster = null;
         var _loc7_:int = 0;
         var _loc8_:BaseBullet = null;
         if(!this.root.hasEventListener(Event.ENTER_FRAME))
         {
            this.root.addEventListener(Event.ENTER_FRAME,this.__enterFrame);
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.gc.getPlayerArray().length)
         {
            _loc3_ = this.gc.getPlayerArray()[_loc1_] as BaseHero;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.magicBulletArray.length)
            {
               _loc5_ = _loc3_.magicBulletArray[_loc4_] as BaseBullet;
               AUtils.startAllChildren(_loc5_);
               _loc4_++;
            }
            if(!_loc3_.getCurMagicWeapon())
            {
            }
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.gc.pWorld.monsterArray.length)
         {
            _loc6_ = this.gc.pWorld.monsterArray[_loc2_] as BaseMonster;
            AUtils.startAllChildren(_loc6_);
            _loc7_ = 0;
            while(_loc7_ < _loc6_.magicBulletArray.length)
            {
               _loc8_ = _loc6_.magicBulletArray[_loc7_] as BaseBullet;
               AUtils.startAllChildren(_loc8_);
               _loc7_++;
            }
            _loc2_++;
         }
         this.gc.keyboardControl.continueKeyboardControl();
         TweenMax.resumeAll();
         this.gc.isStopGame = false;
      }
      
      public function destroyGame() : void
      {
         var _loc1_:int = 0;
         this.root.removeEventListener(Event.ENTER_FRAME,this.__enterFrame);
         this.gc.destroyGame();
         this.gc.gameSence.destroy();
         this.gc.gameInfo.destroy();
         this.gc.pWorld.destroy();
         this.gc.bg1.destroy();
         this.gc.keyboardControl.destroy();
         this.gc.vControllor.destroy();
         if(this.gc.hero1)
         {
            if(this.gc.hero1.getPlayer())
            {
               this.gc.hero1.getPlayer().reSetAllPetState();
            }
            this.gc.hero1.destroy();
            this.gc.hero1 = null;
         }
         if(this.gc.hero2)
         {
            if(this.gc.hero2.getPlayer())
            {
               this.gc.hero2.getPlayer().reSetAllPetState();
            }
            this.gc.hero2.destroy();
            this.gc.hero2 = null;
         }
         this.gc.pWorld.heroArray = [];
         _this = null;
         this.root = null;
         TweenMax.killAll(false);
      }
      
      public function destroyMode() : void
      {
         this.destroyGame();
         this.gc.initData();
      }
      
      public function newGame() : void
      {
         this.gc.pauseTime = 0;
         this.gc.startTime = getTimer();
         this.createFloorBg();
         this.gc.gameSence = AUtils.getNewObj("export.gameSence.sl" + this.gc.curStage + this.gc.curLevel) as BaseGameSence;
         AUtils.checkLoadOK(this.gc.gameSence,this.nextDoAfterLoad);
      }
      
      private function createFloorBg() : void
      {
         this.gc.bg1 = new FloorBg();
         var _loc1_:BitmapData = AUtils.getNewObj("floorBg" + this.gc.curStage);
         var _loc2_:Bitmap = new Bitmap(_loc1_);
         _loc2_.name = "floorBitmap";
         this.gc.bg1.addChild(_loc2_);
         this.root.addChild(this.gc.bg1);
      }
      
      private function nextDoAfterLoad() : void
      {
         this.root.addChild(this.gc.gameSence);
         this.gc.pWorld.pWorldInit();
         if(!this.root.hasEventListener(Event.ENTER_FRAME))
         {
            this.root.addEventListener(Event.ENTER_FRAME,this.__enterFrame);
         }
         if(this.gc.curStage > 7)
         {
            SoundManager.play("stage4");
         }
         else if(this.gc.curStage == 7)
         {
            SoundManager.play("stage2");
         }
         else
         {
            SoundManager.play("stage" + this.gc.curStage);
         }
      }
      
      private function __enterFrame(param1:Event) : void
      {
         this.gc.pWorld.step();
         this.updateOther();
         this.setFource();
      }
      
      public function updateOther() : void
      {
         var _loc1_:uint = this.gc.otherList.length;
         while(_loc1_-- > 0)
         {
            this.gc.otherList[_loc1_].step();
         }
      }
      
      private function setFource() : void
      {
         if(this.root)
         {
            if(!this.gc.isSingleGame())
            {
               if(this.root.stage.focus == null)
               {
                  this.root.stage.focus = this.root.stage;
               }
            }
            else if(this.root.stage.focus != this.root.stage)
            {
               this.root.stage.focus = this.root.stage;
            }
         }
      }
      
      public function checkGameOver() : void
      {
         var _loc1_:uint = this.gc.getPlayerArray().length;
         if(_loc1_ == 0)
         {
            this.destroyGame();
            this.gc.eventManger.dispatchEvent(new CommonEvent("GameOver"));
         }
      }
   }
}
