package base
{
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.aura.auraBlue;
   import export.aura.auraGreen;
   import export.aura.auraRed;
   import export.aura.auraWhile;
   import export.cure.BigHP;
   import export.cure.SmallHP;
   import export.cure.SmallMP;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.utils.getQualifiedClassName;
   import manager.SoundManager;
   import my.ANumber;
   import my.ColorMatrix;
   import my.FallEquipObj;
   import my.HitTest;
   import user.User;
   
   public class BaseMonster extends BaseObject
   {
       
      
      protected var alertRange:int = 1000;
      
      protected var attackRange:int = 100;
      
      protected var normalAttackRate:Number = 0.5;
      
      private var count:int;
      
      protected var waitRateWhenNoTarget:Number = 0.1;
      
      protected var curAttackTarget:BaseObject;
      
      protected var lastAttackTarget:BaseObject;
      
      private var hpSlip:Sprite;
      
      protected var protectedParamsObject:Object;
      
      private var hp1:int;
      
      private var hp2:int;
      
      private var sHp1:int;
      
      private var sHp2:int;
      
      private var level1:int;
      
      private var level2:int;
      
      protected var skillCD1:Array;
      
      protected var skillCD2:Array;
      
      protected var skillCD3:Array;
      
      protected var skillCD4:Array;
      
      public var isBoss:Boolean = false;
      
      public var fallList:Array;
      
      public var monsterName:String = "";
      
      public function BaseMonster()
      {
         this.protectedParamsObject = {
            "exp":0,
            "gxp":0,
            "def":0,
            "probability":0.15,
            "mDef":0,
            "stoneFallRate":0
         };
         this.skillCD1 = [-1,30];
         this.skillCD2 = [-1,30];
         this.skillCD3 = [-1,30];
         this.skillCD4 = [-1,30];
         this.fallList = [];
         super();
         this.setLevel(0);
         this.newHpSlip();
         this.curAddEffect = new BaseAddEffect(BaseObject(this));
      }
      
      override protected function __added(param1:Event) : void
      {
         super.__added(param1);
         if(this.isBoss)
         {
            gc.gameInfo.addBossBlood(this.monsterName,100 - Math.round(100 * (this.getHp() / this.getSHp())));
         }
      }
      
      override protected function initBBDC() : void
      {
      }
      
      override public function step() : void
      {
         super.step();
         this.addcount();
         if(!this.isDead())
         {
            this.IntelligenceTime();
         }
         this.countCD();
         if(this.curAttackTarget)
         {
            if(this.curAttackTarget.isDead() || this.curAttackTarget.isReadyToDestroy)
            {
               this.curAttackTarget = null;
            }
         }
         if(this.isFly)
         {
            if(this.isBeAttacking())
            {
               this.speed.y *= 0.8;
            }
            if(Math.abs(this.speed.y) > 4)
            {
               this.speed.y *= 0.7;
            }
         }
      }
      
      protected function IntelligenceTime() : void
      {
         this.myIntelligence();
      }
      
      protected function countCD() : void
      {
         if(this.skillCD1[0] > 0)
         {
            if(this.skillCD1[0]-- <= 0)
            {
               this.skillCD1[0] = 0;
            }
         }
         if(this.skillCD2[0] > 0)
         {
            if(this.skillCD2[0]-- <= 0)
            {
               this.skillCD2[0] = 0;
            }
         }
         if(this.skillCD3[0] > 0)
         {
            if(this.skillCD3[0]-- <= 0)
            {
               this.skillCD3[0] = 0;
            }
         }
         if(this.skillCD4[0] > 0)
         {
            if(this.skillCD4[0]-- <= 0)
            {
               this.skillCD4[0] = 0;
            }
         }
      }
      
      protected function beforeSkill1Start() : Boolean
      {
         return false;
      }
      
      protected function beforeSkill2Start() : Boolean
      {
         return false;
      }
      
      protected function beforeSkill3Start() : Boolean
      {
         return false;
      }
      
      protected function beforeSkill4Start() : Boolean
      {
         return false;
      }
      
      protected function normalWalk() : void
      {
         if(this.standInObj)
         {
            if(this.x >= this.standInObj.x + this.standInObj.width / 2)
            {
               this.turnLeft();
            }
            else if(this.x <= this.standInObj.x - this.standInObj.width / 2)
            {
               this.turnRight();
            }
            else if(this.count % gc.frameClips == 0)
            {
               if(Math.random() < this.waitRateWhenNoTarget)
               {
                  this.setAction("wait");
                  this.setStatic();
                  if(this.isFly)
                  {
                     this.speed.y = 0;
                  }
               }
               else
               {
                  this.randomWalk();
               }
            }
         }
      }
      
      private function randomWalk() : void
      {
         var _loc1_:Point = gc.gameSence.localToGlobal(new Point(this.x,0));
         if(_loc1_.x > 940)
         {
            this.turnLeft();
         }
         else if(_loc1_.x < 0)
         {
            this.turnRight();
         }
         else if(Math.random() < 0.5)
         {
            this.turnLeft();
         }
         else
         {
            this.turnRight();
         }
      }
      
      protected function followHero() : Boolean
      {
         return false;
      }
      
      protected function myIntelligence() : void
      {
         if(!(this.curAddEffect && (this.curAddEffect.curDebuff(BaseAddEffect.STUN) || this.curAddEffect.curDebuff(BaseAddEffect.PETHORSE_ICE))))
         {
            if(this.curAttackTarget == null)
            {
               this.normalWalk();
               this.selectTarget();
            }
            else if(BaseObject(this.curAttackTarget).isDead())
            {
               this.curAttackTarget = null;
            }
            else
            {
               this.hasAttackTarget();
            }
         }
      }
      
      override protected function move() : void
      {
         if(this.curAddEffect)
         {
            if(this.curAddEffect.curDebuff(BaseAddEffect.PETHORSE_ICE))
            {
               return;
            }
         }
         super.move();
      }
      
      protected function hasAttackTarget() : void
      {
         if(this.isBeAttacking() || this.isAttacking())
         {
            return;
         }
         if(this.beforeSkill1Start() && this.skillCD1[0] == 0)
         {
            this.releSkill1();
            this.skillCD1[0] = this.skillCD1[1];
         }
         else if(this.beforeSkill2Start() && this.skillCD2[0] == 0)
         {
            this.releSkill2();
            this.skillCD2[0] = this.skillCD2[1];
         }
         else if(this.beforeSkill3Start() && this.skillCD3[0] == 0)
         {
            this.releSkill3();
            this.skillCD3[0] = this.skillCD3[1];
         }
         else if(this.beforeSkill4Start() && this.skillCD4[0] == 0)
         {
            this.releSkill4();
            this.skillCD4[0] = this.skillCD4[1];
         }
         else if(this.count % gc.frameClips == 0)
         {
            if(Math.abs(this.x - this.curAttackTarget.x) <= this.attackRange)
            {
               if(Math.random() <= this.normalAttackRate)
               {
                  this.attackTarget();
               }
               else
               {
                  this.setAction("wait");
                  this.setStatic();
                  if(this.isFly)
                  {
                     this.flyFollowTarget();
                  }
               }
            }
            else if(!this.isFly)
            {
               this.followTarget();
            }
            else
            {
               this.flyFollowTarget();
            }
         }
      }
      
      protected function attackTarget() : void
      {
         this.newAttackId();
         this.setAction("hit1");
         this.lastHit = "hit1";
         this.faceToTarget();
      }
      
      protected function releSkill1() : void
      {
      }
      
      protected function releSkill2() : void
      {
      }
      
      protected function releSkill3() : void
      {
      }
      
      protected function releSkill4() : void
      {
      }
      
      protected function followTarget() : void
      {
         if(this.curAttackTarget)
         {
            if(this.x > this.curAttackTarget.x)
            {
               this.moveLeft();
            }
            else if(this.x < this.curAttackTarget.x)
            {
               this.moveRight();
            }
         }
      }
      
      protected function flyFollowTarget() : void
      {
         if(this.curAttackTarget)
         {
            if(this.x > this.curAttackTarget.x)
            {
               this.moveLeft();
            }
            else if(this.x < this.curAttackTarget.x)
            {
               this.moveRight();
            }
            if(this.y < this.curAttackTarget.y - 150)
            {
               this.speed.y = 3;
            }
            else
            {
               this.speed.y = -3;
            }
         }
      }
      
      protected function selectTarget() : void
      {
         var _loc2_:BaseHero = null;
         var _loc1_:Array = gc.getPlayerArray();
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_] as BaseHero;
            if(AUtils.GetDisBetweenTwoObj(_loc2_,this) <= this.alertRange)
            {
               this.curAttackTarget = _loc2_;
               break;
            }
            _loc3_++;
         }
      }
      
      override protected function addBeAttackEffect(param1:BaseObject) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:MovieClip = null;
         var _loc5_:ColorMatrix = null;
         if(this.colipse)
         {
            _loc2_ = Math.random();
            if(_loc2_ > 0.5)
            {
               _loc3_ = "MonsterBeHurt1";
            }
            else
            {
               _loc3_ = "MonsterBeHurt2";
            }
            _loc4_ = AUtils.getNewObj(_loc3_);
            _loc5_ = new ColorMatrix();
            _loc4_.filters = [new ColorMatrixFilter(_loc5_)];
            _loc4_.x = this.colipse.x;
            _loc4_.y = this.colipse.y;
            this.addChild(_loc4_);
         }
      }
      
      public function destroy() : void
      {
         var temp:BaseMonster = null;
         var bb:BaseBullet = null;
         if(this.bbdc)
         {
            this.bbdc.destroy();
         }
         this.curAddEffect.destroy();
         this.curAddEffect = null;
         temp = this;
         TweenMax.to(temp,1,{
            "alpha":0,
            "onComplete":function():*
            {
               removeFromStage(temp);
            }
         });
         this.isReadyToDestroy = true;
         var i:int = 0;
         while(i < this.magicBulletArray.length)
         {
            bb = this.magicBulletArray[i] as BaseBullet;
            bb.destroy();
            i++;
         }
         this.magicBulletArray = [];
         this.curAttackTarget = null;
         this.lastAttackTarget = null;
         gc.protectedPerproty.removeProperty(this);
      }
      
      private function removeFromStage(param1:BaseMonster) : void
      {
         if(parent)
         {
            parent.removeChild(param1);
         }
      }
      
      override protected function checkOver() : void
      {
         if(this.y >= 3000)
         {
            this.setHp(-1);
            this.destroy();
         }
      }
      
      override public function beMagicAttack(param1:BaseBullet, param2:BaseObject, param3:Boolean = false) : Boolean
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc9_:Point = null;
         var _loc10_:Array = null;
         var _loc11_:uint = 0;
         var _loc12_:Object = null;
         var _loc13_:Number = NaN;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         if(gc.protectedPerproty.getProperty(this,"isYourFather"))
         {
            return false;
         }
         if(param3 || this.colipse && AUtils.testIntersects(this.colipse,param1,gc.gameSence) && HitTest.complexHitTestObject(this.colipse,param1))
         {
            ++User.batterNum;
            this.curAttackTarget = param2;
            if(_loc4_ = param2.attackBackInfoDict[param1.curAction])
            {
               _loc9_ = this.getBeattackBackSpeed(param1,_loc4_);
               if(param1.getImcName() != "Role1Bullet12")
               {
                  this.setAttackBack(_loc9_);
               }
               if(_loc4_.addEffect)
               {
                  _loc10_ = AUtils.clone(_loc4_.addEffect) as Array;
                  _loc11_ = 0;
                  while(_loc11_ < _loc10_.length)
                  {
                     if((_loc12_ = _loc10_[_loc11_]).time == BaseBullet.DESIDE_BY_FRAMES_LEFT)
                     {
                        _loc12_.time = param1.getFrameLeft();
                     }
                     _loc11_++;
                  }
                  this.addCurAddEffect(_loc10_);
               }
            }
            _loc7_ = false;
            _loc5_ = param2.getRealPower(param1.curAction);
            _loc6_ = param2.getRealPower(param1.curAction,false);
            if(param1.getImcName() == "Role1Bullet12")
            {
               trace("--火眼晶晶--");
               if((_loc13_ = AUtils.GetDisBetweenTwoObj(this,param2)) > 1000)
               {
                  _loc13_ = 1000;
               }
               _loc5_ *= (1000 - _loc13_) / 1000;
               _loc6_ *= (1000 - _loc13_) / 1000;
            }
            if(_loc5_ / _loc6_ >= 1.9)
            {
               _loc7_ = true;
            }
            _loc8_ = this.getRealHurt(_loc5_,_loc4_);
            this.addMonHurtMc(_loc8_,_loc7_);
            if(param2 is BaseHero)
            {
               if(_loc4_ && _loc4_.attackKind == "physics")
               {
                  _loc14_ = BaseHero(param2).roleProperies.getEatBlood();
                  if((_loc15_ = int(_loc14_ / 100 * _loc8_)) > 0)
                  {
                     BaseHero(param2).cureHp(_loc15_);
                  }
               }
            }
            if(param1.getImcName() == "Role1Bullet12")
            {
               this.reduceHp(_loc8_,false);
            }
            else
            {
               this.reduceHp(_loc8_,true);
            }
            this.showHpSlip();
            gc.eventManger.dispatchEvent(new CommonEvent("MonsterIsBeat",[_loc5_,this.curAttackTarget]));
            this.addBeAttackEffect(param2);
            SoundManager.play("BeattackByRole1");
            return true;
         }
         return false;
      }
      
      protected function getRealHurt(param1:int, param2:Object) : int
      {
         var _loc3_:int = 0;
         if(param2)
         {
            if(param2.attackKind == "physics")
            {
               if(param1 > this.protectedParamsObject.def)
               {
                  _loc3_ = param1 - this.protectedParamsObject.def;
               }
               else
               {
                  _loc3_ = 1;
               }
            }
            else if(param2.attackKind == "magic")
            {
               if(this.protectedParamsObject.mDef)
               {
                  _loc3_ = param1 * (1 - this.protectedParamsObject.mDef);
               }
               else
               {
                  _loc3_ = param1;
               }
            }
         }
         else
         {
            _loc3_ = 1;
         }
         return _loc3_;
      }
      
      override public function reduceHp(param1:int, param2:Boolean = false) : void
      {
         this.setHp(this.getHp() - param1);
         this.drawMonsterHp();
         if(this.isDead())
         {
            if(this.curAction != "dead")
            {
               this.setAction("dead");
               if(this.curAttackTarget is BaseHero)
               {
                  if(BaseHero(this.curAttackTarget).getPet())
                  {
                     BaseHero(this.curAttackTarget).roleProperies.setExper(BaseHero(this.curAttackTarget).roleProperies.getExper() + this.protectedParamsObject.exp / 2);
                     BaseHero(this.curAttackTarget).getPet().petInfo.setCurExper(BaseHero(this.curAttackTarget).getPet().petInfo.getCurExper() + this.protectedParamsObject.exp / 2);
                  }
                  else
                  {
                     BaseHero(this.curAttackTarget).roleProperies.setExper(BaseHero(this.curAttackTarget).roleProperies.getExper() + this.protectedParamsObject.exp);
                  }
               }
               else if(this.curAttackTarget is BasePet)
               {
                  BasePet(this.curAttackTarget).petInfo.setCurExper(BasePet(this.curAttackTarget).petInfo.getCurExper() + this.protectedParamsObject.exp);
               }
            }
         }
         else if(param2)
         {
            if(this.curAction == "hurt")
            {
               this.bbdc.setFramePointX(0);
            }
            else
            {
               this.setAction("hurt");
            }
         }
         if(this.isBoss)
         {
            gc.gameInfo.addBossBlood(this.monsterName,100 - Math.round(100 * (this.getHp() / this.getSHp())));
         }
      }
      
      public function setFullHp() : void
      {
         this.setHp(this.getSHp());
      }
      
      override public function isDead() : Boolean
      {
         return this.getHp() <= 0;
      }
      
      public function dropAura() : void
      {
         var _loc1_:BaseHero = null;
         var _loc2_:BaseAura = null;
         var _loc5_:Number = NaN;
         this.addMedicine();
         this.fallEquip();
         if(this.curAttackTarget is BasePet)
         {
            _loc1_ = BasePet(this.curAttackTarget).getSourceRole();
         }
         else if(this.curAttackTarget is BaseHero)
         {
            _loc1_ = BaseHero(this.curAttackTarget);
         }
         if(!_loc1_)
         {
            return;
         }
         var _loc3_:int = 2 + Math.floor(Math.random() * 3);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new auraRed(this,_loc1_);
            _loc2_.x = this.x + (Math.random() - 0.5) * 10;
            _loc2_.y = this.y + (Math.random() - 0.5) * 10;
            _loc2_.setPower(this.protectedParamsObject.gxp);
            gc.gameSence.addChild(_loc2_);
            gc.pWorld.getAuraArray().push(_loc2_);
            _loc4_++;
         }
         _loc5_ = Math.random();
         _loc3_ = 0;
         if(_loc5_ < 0.04)
         {
            _loc3_ = 3;
         }
         else if(_loc5_ < 0.08)
         {
            _loc3_ = 2;
         }
         else if(_loc5_ < 0.12)
         {
            _loc3_ = 1;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new auraGreen(this,_loc1_);
            _loc2_.x = this.x + (Math.random() - 0.5) * 20;
            _loc2_.y = this.y + (Math.random() - 0.5) * 20;
            gc.gameSence.addChild(_loc2_);
            gc.pWorld.getAuraArray().push(_loc2_);
            _loc4_++;
         }
         _loc5_ = Math.random();
         _loc3_ = 0;
         if(_loc5_ < 0.04)
         {
            _loc3_ = 3;
         }
         else if(_loc5_ < 0.08)
         {
            _loc3_ = 2;
         }
         else if(_loc5_ < 0.12)
         {
            _loc3_ = 1;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new auraBlue(this,_loc1_);
            _loc2_.x = this.x + (Math.random() - 0.5) * 30;
            _loc2_.y = this.y + (Math.random() - 0.5) * 30;
            gc.gameSence.addChild(_loc2_);
            gc.pWorld.getAuraArray().push(_loc2_);
            _loc4_++;
         }
         _loc5_ = Math.random();
         _loc3_ = 0;
         if(_loc5_ < 0.04)
         {
            _loc3_ = 3;
         }
         else if(_loc5_ < 0.08)
         {
            _loc3_ = 2;
         }
         else if(_loc5_ < 0.12)
         {
            _loc3_ = 1;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new auraWhile(this,_loc1_);
            _loc2_.x = this.x + (Math.random() - 0.5) * 40;
            _loc2_.y = this.y + (Math.random() - 0.5) * 40;
            gc.gameSence.addChild(_loc2_);
            gc.pWorld.getAuraArray().push(_loc2_);
            _loc4_++;
         }
      }
      
      protected function addcount() : void
      {
         if(this.count++ > gc.frameClips * 10)
         {
            this.count = 0;
         }
      }
      
      protected function drawMonsterHp() : void
      {
         this.hpSlip.graphics.clear();
         this.hpSlip.alpha = 1;
         var _loc1_:Number = this.getHp() / this.getSHp();
         _loc1_ = _loc1_ < 0 ? Number(0) : Number(_loc1_);
         if(this.getHp() >= 0)
         {
            this.hpSlip.graphics.lineStyle(1.2,0);
            this.hpSlip.graphics.drawRect(0,5,50,5);
            this.hpSlip.graphics.beginFill(16711680);
            if(this.getBBDC().getDirect() == 0)
            {
               this.hpSlip.graphics.drawRect(0,5,50 * _loc1_,5);
            }
            else if(this.getBBDC().getDirect() == 1)
            {
               this.hpSlip.graphics.drawRect(50 - 50 * _loc1_,5,50 * _loc1_,5);
            }
            this.hpSlip.graphics.endFill();
         }
      }
      
      protected function removedHpSlip() : void
      {
         this.hpSlip.visible = false;
      }
      
      protected function showHpSlip() : void
      {
         this.hpSlip.visible = true;
         TweenMax.to(this.hpSlip,2,{
            "alpha":0,
            "onComplete":this.removedHpSlip
         });
      }
      
      protected function newHpSlip() : void
      {
         this.hpSlip = new Sprite();
         this.hpSlip.x = -23;
         this.hpSlip.y = -this.colipse.height / 2 - 10;
         this.hpSlip.visible = false;
         addChild(this.hpSlip);
      }
      
      public function addMonHurtMc(param1:int, param2:Boolean, param3:Boolean = false) : *
      {
         var _loc4_:ANumber = new ANumber();
         this.gc.gameSence.addChild(_loc4_);
         if(param3)
         {
            _loc4_.aNumImage("hurtnum",param1,this.x - 20,this.y - this.height / 2,20);
         }
         else if(param2)
         {
            _loc4_.aNumImage("bnum",param1,this.x - 20,this.y - this.height / 2,16);
         }
         else
         {
            _loc4_.aNumImage("hurtnum",param1,this.x - 20,this.y - this.height / 2,20);
         }
      }
      
      public function judgeAlive(param1:BaseHero) : *
      {
         param1.roleProperies.setExper(this.protectedParamsObject.exp);
      }
      
      public function fallEquip() : void
      {
         var _loc7_:uint = 0;
         var _loc8_:FallEquipObj = null;
         var _loc9_:Point = null;
         var _loc10_:int = 0;
         var _loc1_:String = getQualifiedClassName(this);
         var _loc2_:Array = _loc1_.split("::");
         gc.allTask.killMonster(_loc2_[1]);
         var _loc3_:Number = this.protectedParamsObject.probability;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         if(gc.hero1)
         {
            _loc5_ = gc.hero1.getPlayer().getCurFashionEquipFallThingProbability();
         }
         if(gc.hero2)
         {
            _loc6_ = gc.hero2.getPlayer().getCurFashionEquipFallThingProbability();
         }
         _loc4_ = Math.max(_loc5_,_loc6_);
         _loc3_ *= 1 + _loc4_;
         if(Math.random() <= _loc3_)
         {
            try
            {
               _loc7_ = Math.round(Math.random() * (this.fallList.length - 1));
               if(this.fallList[_loc7_] || this.fallList[_loc7_] != undefined)
               {
                  _loc8_ = new FallEquipObj(this.fallList[_loc7_]);
                  _loc9_ = gc.gameSence.localToGlobal(new Point(this.x,0));
                  _loc10_ = 0;
                  if(_loc9_.x > 930)
                  {
                     _loc10_ = -150;
                  }
                  else if(_loc9_.x < 10)
                  {
                     _loc10_ = 150;
                  }
                  _loc8_.x = this.x + _loc10_;
                  _loc8_.y = this.y - 100;
                  this.gc.gameSence.addChild(_loc8_);
                  this.gc.otherList.push(_loc8_);
               }
            }
            catch(e:*)
            {
            }
         }
      }
      
      public function fallStone() : void
      {
         var _loc5_:FallEquipObj = null;
         var _loc6_:Point = null;
         var _loc7_:int = 0;
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         if(gc.hero1)
         {
            _loc2_ = gc.hero1.getPlayer().getCurFashionEquipFallThingProbability();
         }
         if(gc.hero2)
         {
            _loc3_ = gc.hero2.getPlayer().getCurFashionEquipFallThingProbability();
         }
         _loc1_ = Math.max(_loc2_,_loc3_);
         var _loc4_:Number = (_loc4_ = this.protectedParamsObject.stoneFallRate) * (1 + _loc1_);
         if(Math.random() <= _loc4_)
         {
            _loc5_ = new FallEquipObj({
               "name":"wpqhs1",
               "bigtype":"dj"
            });
            _loc6_ = gc.gameSence.localToGlobal(new Point(this.x,0));
            _loc7_ = 0;
            if(_loc6_.x > 930)
            {
               _loc7_ = -150;
            }
            else if(_loc6_.x < 10)
            {
               _loc7_ = 150;
            }
            _loc5_.x = this.x + _loc7_;
            _loc5_.y = this.y - 100;
            this.gc.gameSence.addChild(_loc5_);
            this.gc.otherList.push(_loc5_);
         }
      }
      
      public function addMedicine() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Number = NaN;
         if(Math.random() >= 0.5)
         {
            _loc2_ = Math.random();
            if(_loc2_ <= 0.1)
            {
               if(_loc2_ <= 0.05)
               {
                  if(Math.random() >= 0.5)
                  {
                     _loc1_ = new SmallHP();
                     _loc1_.x = this.x;
                     _loc1_.y = this.y - _loc1_.height;
                  }
                  else
                  {
                     _loc1_ = new BigHP();
                     _loc1_.x = this.x;
                     _loc1_.y = this.y - _loc1_.height;
                  }
               }
               else
               {
                  _loc1_ = new SmallHP();
                  _loc1_.x = this.x;
                  _loc1_.y = this.y - _loc1_.height;
               }
            }
         }
         else if(Math.random() <= 0.1)
         {
            _loc1_ = new SmallMP();
            _loc1_.x = this.x;
            _loc1_.y = this.y - _loc1_.height;
         }
         if(_loc1_ != null)
         {
            this.gc.gameSence.addChild(_loc1_);
            this.gc.otherList.push(_loc1_);
         }
      }
      
      public function faceToTarget() : void
      {
         if(this.curAttackTarget)
         {
            if(this.x < this.curAttackTarget.x)
            {
               this.turnRight();
            }
            else
            {
               this.turnLeft();
            }
         }
      }
      
      public function cureHp(param1:int) : void
      {
         this.setHp(this.getHp() + param1);
         this.addCureMc(param1);
      }
      
      public function getCurAttackTarget() : BaseObject
      {
         return this.curAttackTarget;
      }
      
      public function setLevel(param1:int) : void
      {
         this.level1 = AUtils.getRandomValue();
         this.level2 = param1 - this.level1;
      }
      
      public function getLevel() : int
      {
         return this.level1 + this.level2;
      }
      
      public function setHp(param1:int) : void
      {
         this.hp1 = AUtils.getRandomValue();
         this.hp2 = param1 - this.hp1;
      }
      
      public function getHp() : int
      {
         return this.hp1 + this.hp2;
      }
      
      public function setSHp(param1:int) : void
      {
         this.sHp1 = AUtils.getRandomValue();
         this.sHp2 = param1 - this.sHp1;
      }
      
      public function getSHp() : int
      {
         return this.sHp1 + this.sHp2;
      }
      
      public function getFootBottom() : Number
      {
         return this.y + this.colipse.y + this.colipse.height / 2;
      }
      
      override public function getRealPower(param1:String, param2:Boolean = true) : int
      {
         var _loc3_:Object = this.attackBackInfoDict[param1];
         if(_loc3_)
         {
            return _loc3_.power;
         }
         return 0;
      }
      
      override public function isWalkOrRun() : Boolean
      {
         return this.curAction == "walk" || this.curAction == "run";
      }
      
      override public function isNormalHit() : Boolean
      {
         return true;
      }
   }
}
