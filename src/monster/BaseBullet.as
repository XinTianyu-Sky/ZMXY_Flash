package base
{
   import config.Config;
   import export.hero.Role1;
   import export.monster.Monster34;
   import export.monster.MonsterRole4Hit5;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import my.HitTest;
   
   public class BaseBullet extends Sprite
   {
      
      public static var DESIDE_BY_FRAMES_LEFT:uint = 0;
       
      
      protected var imgMc:MovieClip;
      
      public var sourceRole:BaseObject;
      
      public var isCanBeAttack:Boolean = false;
      
      public var isDisabled:Boolean = false;
      
      public var isReadyToDestroy:Boolean = false;
      
      public var initTimer:uint;
      
      protected var isAdd:Boolean = false;
      
      private var lastStopGameState:Boolean = false;
      
      protected var direct:int = -1;
      
      public var speed:Point;
      
      public var curAction:String;
      
      protected var gc:Config;
      
      protected var attackId:int;
      
      protected var maxAttackCount:int;
      
      protected var imcName:String;
      
      private var attackInterval:int;
      
      private var attackIntervalCount:int = 0;
      
      private var funcWhenHitWall:Function = null;
      
      private var funcWhenHit:Function = null;
      
      private var destroyInCount:int = -1;
      
      protected var isHurtCanCutDownEffect:Boolean = false;
      
      protected var isDestroyWhenLastFrame:Boolean = true;
      
      protected var isDestroyWhenMaxHitCountLessThenZero:Boolean = true;
      
      public function BaseBullet(param1:String)
      {
         super();
         this.imcName = param1;
         this.imgMc = AUtils.getNewObj(param1);
         this.addChild(this.imgMc);
         this.gc = Config.getInstance();
         this.speed = new Point();
      }
      
      public function step2() : void
      {
         if(!this.gc.isStopGame)
         {
            this.step();
         }
         if(this.lastStopGameState != this.gc.isStopGame)
         {
            if(!this.lastStopGameState)
            {
               AUtils.stopAllChildren(this);
            }
            else
            {
               AUtils.startAllChildren(this);
            }
         }
         this.lastStopGameState = this.gc.isStopGame;
         if(this.imgMc && this.isDestroyWhenLastFrame)
         {
            if(this.imgMc.currentFrame == this.imgMc.totalFrames)
            {
               this.imgMc.stop();
               this.destroy();
            }
         }
         if(this.sourceRole)
         {
            if(this.isHurtCanCutDownEffect)
            {
               if(this.sourceRole.curAction == "hurt")
               {
                  this.destroy();
               }
            }
         }
      }
      
      protected function step() : void
      {
         if(this.isDisabled)
         {
            return;
         }
         this.checkAttack();
         this.checkHitWall();
         if(this.imcName == "Role4Bullet12")
         {
            if(this.hitTestObject(this.sourceRole.colipse))
            {
               this.destroy();
            }
         }
         if(this.destroyInCount > 0)
         {
            --this.destroyInCount;
            if(this.destroyInCount == 0)
            {
               this.destroy();
            }
         }
      }
      
      public function setDestroyWhenLastFrame(param1:Boolean) : void
      {
         this.isDestroyWhenLastFrame = param1;
      }
      
      public function setHurtCanCutDownEffect(param1:Boolean) : void
      {
         this.isHurtCanCutDownEffect = param1;
      }
      
      public function setDestroyWhenMaxHitCountLessThenZero(param1:Boolean) : void
      {
         this.isDestroyWhenMaxHitCountLessThenZero = param1;
      }
      
      public function setCanBeAttack() : void
      {
         this.isCanBeAttack = true;
      }
      
      public function setFuncWhenHitWall(param1:Function) : void
      {
         this.funcWhenHitWall = param1;
      }
      
      public function setFuncWhenHit(param1:Function) : void
      {
         this.funcWhenHit = param1;
      }
      
      private function checkHitWall() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Wall = null;
         if(this.funcWhenHitWall != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.gc.pWorld.getWallArray().length)
            {
               _loc2_ = this.gc.pWorld.getWallArray()[_loc1_] as Wall;
               if(_loc2_.width >= 800)
               {
                  if(HitTest.complexHitTestObject(this,_loc2_))
                  {
                     this.funcWhenHitWall(this);
                     this.destroy();
                     break;
                  }
               }
               _loc1_++;
            }
         }
      }
      
      public function checkAttack() : void
      {
         var _loc1_:Array = null;
         var _loc3_:BaseObject = null;
         if(!this.sourceRole)
         {
            return;
         }
         if(this.sourceRole is BaseHero || this.sourceRole is BasePet)
         {
            _loc1_ = this.gc.pWorld.monsterArray.concat(this.gc.pWorld.likeMonsterArray);
         }
         else
         {
            _loc1_ = this.gc.getPlayerArray().concat(this.gc.pWorld.likeMonsterArray);
         }
         if(this.gc.isInRoom())
         {
            if(this.sourceRole is BaseHero)
            {
               if(BaseHero(this.sourceRole).getPlayer())
               {
                  _loc1_ = this.gc.pWorld.getOtherHeroArray();
               }
               else
               {
                  _loc1_ = [];
               }
               _loc1_ = _loc1_.concat(this.gc.pWorld.likeMonsterArray);
            }
            else if(this.sourceRole is BasePet)
            {
               if(BasePet(this.sourceRole).getSourceRole() && BasePet(this.sourceRole).getSourceRole().getPlayer())
               {
                  _loc1_ = this.gc.pWorld.getOtherHeroArray();
               }
               else
               {
                  _loc1_ = [];
               }
               _loc1_ = _loc1_.concat(this.gc.pWorld.likeMonsterArray);
            }
         }
         if(this.attackIntervalCount == this.attackInterval)
         {
            this.newAttackId();
            this.attackIntervalCount = 0;
         }
         if(this.attackIntervalCount >= 0)
         {
            ++this.attackIntervalCount;
         }
         var _loc2_:int = 0;
         for(; _loc2_ < _loc1_.length; _loc2_++)
         {
            _loc3_ = _loc1_[_loc2_];
            if(_loc3_)
            {
               if(_loc3_ is MonsterRole4Hit5)
               {
                  if(MonsterRole4Hit5(_loc3_).getSourceRole() != this.sourceRole)
                  {
                     continue;
                  }
               }
               if(_loc3_.beAttackIdArray.indexOf(this.getAttackId()) == -1)
               {
                  if(_loc3_.beMagicAttack(this,this.sourceRole))
                  {
                     if(this.getImcName() == "Role1Bullet13")
                     {
                        if(this.sourceRole is Role1)
                        {
                           if(Role1(this.sourceRole).sid == this.gc.sid || this.gc.isSingleGame())
                           {
                              if(Math.random() <= 0.18)
                              {
                                 Role1(this.sourceRole).createShallow();
                              }
                           }
                        }
                        else if(this.sourceRole is Monster34)
                        {
                           if(Math.random() <= 0.18)
                           {
                              Monster34(this.sourceRole).createShallow();
                           }
                        }
                     }
                     if(this.funcWhenHit != null)
                     {
                        this.funcWhenHit();
                     }
                     _loc3_.beAttackIdArray.push(this.getAttackId());
                     --this.maxAttackCount;
                  }
               }
               if(this.maxAttackCount > 0)
               {
                  if(_loc3_ is BaseHero)
                  {
                     if(BaseHero(_loc3_).getPet())
                     {
                        if(BaseHero(_loc3_).getPet().beAttackIdArray.indexOf(this.getAttackId()) == -1)
                        {
                           if(BaseHero(_loc3_).getPet().beMagicAttack(this,this.sourceRole))
                           {
                              if(this.funcWhenHit != null)
                              {
                                 this.funcWhenHit();
                              }
                              BaseHero(_loc3_).getPet().beAttackIdArray.push(this.getAttackId());
                              --this.maxAttackCount;
                           }
                        }
                     }
                  }
               }
            }
         }
         if(this.isDestroyWhenMaxHitCountLessThenZero)
         {
            if(this.maxAttackCount <= 0)
            {
               this.destroy();
            }
         }
      }
      
      public function setScale(param1:Number, param2:Number) : void
      {
         var _loc3_:Matrix = this.transform.matrix;
         _loc3_.a = _loc3_.a > 0 ? Number(Math.abs(_loc3_.a) * param1) : Number(-Math.abs(_loc3_.a) * param1);
         _loc3_.d *= param2;
         this.transform.matrix = _loc3_;
      }
      
      public function setDisable() : void
      {
         this.isDisabled = true;
      }
      
      public function destroy() : void
      {
         AUtils.stopAllChildren(this);
         this.isReadyToDestroy = true;
         this.imgMc = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(this.sourceRole)
         {
            this.sourceRole = null;
         }
      }
      
      public function setRole(param1:BaseObject) : void
      {
         this.sourceRole = param1;
         this.attackId = param1.getNumAttackId();
      }
      
      public function setDirect(param1:int) : void
      {
         this.direct = param1 == 0 ? -1 : 1;
         AUtils.flipHorizontal(this,-this.direct);
      }
      
      public function getDirect() : int
      {
         return this.direct;
      }
      
      public function setAction(param1:String) : void
      {
         this.curAction = param1;
         var _loc2_:Object = this.sourceRole.attackBackInfoDict[this.curAction];
         if(_loc2_)
         {
            this.maxAttackCount = _loc2_.hitMaxCount;
            this.attackInterval = _loc2_.attackInterval;
         }
      }
      
      public function stopPlay() : void
      {
         if(this.imgMc)
         {
            this.imgMc.stop();
         }
      }
      
      public function continuePlay() : void
      {
         if(this.imgMc)
         {
            this.imgMc.play();
         }
      }
      
      public function getStickMCArray() : Array
      {
         var _loc4_:MovieClip = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = this.imgMc.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(_loc4_ = this.imgMc.getChildByName("stick" + _loc3_) as MovieClip)
            {
               _loc1_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function setDestroyInCount(param1:uint) : void
      {
         this.destroyInCount = param1;
      }
      
      public function setMaxAttackCount(param1:uint) : void
      {
         this.maxAttackCount = param1;
      }
      
      public function reduceMaxAttackCount() : void
      {
         --this.maxAttackCount;
      }
      
      public function getFrameLeft() : uint
      {
         if(this.imgMc)
         {
            return this.imgMc.totalFrames - this.imgMc.currentFrame;
         }
         return 0;
      }
      
      public function getImcName() : String
      {
         return this.imcName;
      }
      
      public function getImgMc() : MovieClip
      {
         return this.imgMc;
      }
      
      public function newAttackId() : void
      {
         ++this.attackId;
      }
      
      public function getAttackId() : String
      {
         return this.name + this.attackId;
      }
   }
}
