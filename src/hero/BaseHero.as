package base
{
   import com.greensock.TweenMax;
   import com.hexagonstar.util.debug.Debug;
   import event.CommonEvent;
   import export.RoleInfo;
   import export.WsEffect;
   import export.hero.Role1;
   import export.hero.Role2;
   import export.hero.Role3;
   import export.hero.Role4;
   import export.magicWeapon.MagicBottle;
   import export.magicWeapon.MagicLeaf;
   import export.magicWeapon.MagicRing;
   import export.magicWeapon.MagicSword;
   import export.magicWeapon.MagicUmbrella;
   import export.monster.Monster16;
   import export.monster.Monster34;
   import export.monster.Monster6;
   import export.pet.PetHorse1;
   import export.pet.PetHorse2;
   import export.pet.PetHorse3;
   import export.pet.PetKabu1;
   import export.pet.PetKabu2;
   import export.pet.PetKabu3;
   import export.pet.PetMonkey1;
   import export.pet.PetMonkey2;
   import export.pet.PetMonkey3;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import manager.SoundManager;
   import my.ANumber;
   import my.ColorMatrix;
   import my.ExceedPower;
   import my.HitTest;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   import user.MutiUser;
   import user.User;
   
   public class BaseHero extends BaseObject
   {
       
      
      private var roleId:uint;
      
      public var csmc:MovieClip;
      
      protected var protectedEquipObject:Object;
      
      public var dxmc:MovieClip;
      
      public var hlmc:MovieClip;
      
      public var isRole:MovieClip;
      
      public var levelexp:Array;
      
      public var levelupmc:MovieClip;
      
      public var roleName:String = "";
      
      public var roleProperies:BaseRoleProperies;
      
      public var userType:String = "";
      
      protected var cannextaction:Boolean = true;
      
      protected var curUpTime:int;
      
      protected var curtime:int = 0;
      
      public var doubleCount:uint;
      
      protected var exceedPowerSprite:ExceedPower;
      
      protected var hitNum:uint = 1;
      
      protected var keyId:int;
      
      protected var keyList:Array;
      
      protected var keyarray:Array;
      
      protected var lastDirbtn:uint;
      
      protected var lastKey:Object;
      
      protected var lastUpTime:int;
      
      protected var lasttime:int = 0;
      
      protected var player:User;
      
      protected var timers:int = 0;
      
      protected var myPet:BasePet;
      
      public function BaseHero()
      {
         this.protectedEquipObject = {
            "curClothId1":0,
            "curClothId2":0,
            "curWeaponId1":0,
            "curWeaponId2":0
         };
         this.levelexp = [135,145,155,165,175,185,625,675,725,775,825,875,1950,2050,2150,2250,2350,2450,5000];
         this.keyList = [];
         this.lastKey = new Object();
         super();
         this.roleProperies = new BaseRoleProperies(this);
      }
      
      public function start() : void
      {
         Debug.trace("---start---");
         if(this.getPlayer())
         {
            this.changeEquip(this.getPlayer().getEquipNum());
         }
         this.initPet();
         if(!gc.isInRoom())
         {
            this.initMagicWeapon();
         }
         if(this.player)
         {
            this.initPopertits();
         }
         this.curAddEffect = new BaseAddEffect(BaseObject(this));
         this.registerProtectedProperty();
         this.keyarray = gc.keyboardControl.getZeroKeyArray();
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
         this.setAction("wait");
      }
      
      public function __keyBoardDown(param1:KeyboardEvent) : void
      {
         if(this.isDead())
         {
            return;
         }
         if(!gc.keyboardControl.isInThisPlayerKeyboard(this.player,param1.keyCode))
         {
            return;
         }
         if(this.lastKey.keyCode == undefined)
         {
            this.lastKey.keyCode = param1.keyCode;
         }
         if(this.lastKey.keyId == undefined)
         {
            this.lastKey.keyId = this.keyId;
         }
         if(param1.keyCode != this.lastKey.keyCode)
         {
            ++this.keyId;
         }
         switch(param1.keyCode)
         {
            case gc.keyboardControl.getLeftByPlayer(this.player):
               moveLeft();
               this.addDoubleCount(param1.keyCode);
               this.lastDirbtn = param1.keyCode;
               break;
            case gc.keyboardControl.getRightByPlayer(this.player):
               moveRight();
               this.addDoubleCount(param1.keyCode);
               this.lastDirbtn = param1.keyCode;
         }
         this.checkDoubleCount(param1.keyCode);
         this.lastKey.keyCode = param1.keyCode;
         this.lastKey.keyId = this.keyId;
         var _loc2_:uint = this.keyList.length;
         while(_loc2_-- > 0)
         {
            if(this.keyList[_loc2_] == param1.keyCode)
            {
               this.keyarray[_loc2_] = 1;
            }
         }
         if(!this.isBeAttacking() && !this.isAttacking() && !this.isStatic())
         {
            if(this.isRunning())
            {
               if(!this.isJump())
               {
                  this.setAction("run");
               }
               if(getTimer() - lastRunSendInterval > 100)
               {
                  gc.sendWalkInfo(this);
               }
               lastRunSendInterval = getTimer();
            }
            else
            {
               if(!this.isJump())
               {
                  this.setAction("walk");
               }
               if(getTimer() - lastWalkSendInterval > 500)
               {
                  gc.sendWalkInfo(this);
               }
               lastWalkSendInterval = getTimer();
            }
         }
      }
      
      public function initPopertits() : void
      {
         this.roleProperies.setInitValue();
         this.roleProperies.setinitLevel(this.player.getCurLevel());
         this.roleProperies.setinitExper(this.player.getCurExp());
         if(gc.isHideDebug)
         {
         }
         this.upGrade();
      }
      
      public function resetKey() : void
      {
         this.keyarray = gc.keyboardControl.getZeroKeyArray();
         this.lastDirbtn = 0;
         this.lastKey = {};
      }
      
      public function cureHp(param1:int) : void
      {
         var _loc2_:MutiUser = null;
         if(!this.isDead())
         {
            if(gc.sid == this.sid && gc.isInRoom())
            {
               _loc2_ = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId()) as MutiUser;
               if(_loc2_)
               {
                  _loc2_.hp += param1;
                  gc.sendSelfMutiUserInfo(this.getRoleId());
               }
            }
            this.roleProperies.setHHP(this.roleProperies.getHHP() + param1);
            this.addCureMc(param1);
         }
      }
      
      protected function initPet() : void
      {
         var _loc1_:PetInfo = null;
         var _loc2_:MutiUser = null;
         if(this.getPlayer())
         {
            _loc1_ = this.getPlayer().findCurrentPet();
         }
         else
         {
            _loc2_ = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
            if(_loc2_)
            {
               if(_loc2_.petName != "")
               {
                  _loc1_ = new PetInfo();
                  _loc1_.setPetNameAndLevel(_loc2_.petName,_loc2_.petLevel);
                  _loc1_.setHp(_loc2_.petHp);
                  _loc1_.setSHp(_loc2_.petHp);
                  _loc1_.setMp(_loc2_.petMp);
                  _loc1_.setSMp(_loc2_.petMp);
               }
            }
         }
         if(_loc1_)
         {
            _loc1_.setDoWhenLevelUp(this.doWhenLevelUp);
            _loc1_.setDoWhenChangeState(this.doWhenChangeState);
            this.myPet = this.addPetByPi(_loc1_);
            this.myPet.x = this.x;
            this.myPet.y = this.y - 100;
            gc.gameSence.addChild(this.myPet);
         }
      }
      
      public function doWhenLevelUp() : *
      {
         var _loc1_:MovieClip = null;
         if(this.getPet())
         {
            _loc1_ = AUtils.getNewObj("PetLevelUpMc") as MovieClip;
            this.getPet().addChild(_loc1_);
         }
      }
      
      public function doWhenChangeState() : *
      {
         if(this.getPet())
         {
            this.changePet();
         }
      }
      
      public function addPetByPi(param1:PetInfo) : BasePet
      {
         var _loc2_:BasePet = null;
         var _loc3_:String = param1.getPetName();
         if(_loc3_ == "monkey1")
         {
            _loc2_ = new PetMonkey1(this,param1);
         }
         else if(_loc3_ == "monkey2")
         {
            _loc2_ = new PetMonkey2(this,param1);
         }
         else if(_loc3_ == "monkey3")
         {
            _loc2_ = new PetMonkey3(this,param1);
         }
         else if(_loc3_ == "horse1")
         {
            _loc2_ = new PetHorse1(this,param1);
         }
         else if(_loc3_ == "horse2")
         {
            _loc2_ = new PetHorse2(this,param1);
         }
         else if(_loc3_ == "horse3")
         {
            _loc2_ = new PetHorse3(this,param1);
         }
         else if(_loc3_ == "ufo1")
         {
            _loc2_ = new PetKabu1(this,param1);
         }
         else if(_loc3_ == "ufo2")
         {
            _loc2_ = new PetKabu2(this,param1);
         }
         else if(_loc3_ == "ufo3")
         {
            _loc2_ = new PetKabu3(this,param1);
         }
         return _loc2_;
      }
      
      protected function initMagicWeapon() : void
      {
         var _loc1_:MyEquipObj = null;
         var _loc2_:MutiUser = null;
         if(this.getPlayer())
         {
            _loc1_ = this.getPlayer().getCurEquipByType("zbfb");
            Debug.trace("initMagicWeapon---fb:" + _loc1_);
            if(_loc1_)
            {
               if(_loc1_.getFillName() == "xhhl")
               {
                  this.curMagicWeapon = new MagicBottle(this);
               }
               else if(_loc1_.getFillName() == "kyl")
               {
                  this.curMagicWeapon = new MagicLeaf(this);
               }
               else if(_loc1_.getFillName() == "qyj")
               {
                  this.curMagicWeapon = new MagicSword(this);
               }
               else if(_loc1_.getFillName() == "hyzzs")
               {
                  this.curMagicWeapon = new MagicUmbrella(this);
               }
               else if(_loc1_.getFillName() == "zjld")
               {
                  this.curMagicWeapon = new MagicRing(this);
               }
               if(this.curMagicWeapon)
               {
                  gc.gameSence.addChild(this.curMagicWeapon);
               }
            }
         }
         else
         {
            _loc2_ = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
            if(_loc2_)
            {
               if(_loc2_.bmwId == BaseMagicWeapon.BMW_Bottle)
               {
                  this.curMagicWeapon = new MagicBottle(this);
               }
               else if(_loc2_.bmwId == BaseMagicWeapon.BMW_Leaf)
               {
                  this.curMagicWeapon = new MagicLeaf(this);
               }
               else if(_loc2_.bmwId == BaseMagicWeapon.BMW_Ring)
               {
                  this.curMagicWeapon = new MagicRing(this);
               }
               else if(_loc2_.bmwId == BaseMagicWeapon.BMW_Sword)
               {
                  this.curMagicWeapon = new MagicSword(this);
               }
               else if(_loc2_.bmwId == BaseMagicWeapon.BMW_Umbrella)
               {
                  this.curMagicWeapon = new MagicUmbrella(this);
               }
               if(this.curMagicWeapon)
               {
                  gc.gameSence.addChild(this.curMagicWeapon);
               }
            }
         }
      }
      
      override public function reduceHp(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:MutiUser = null;
         var _loc4_:MyEquipObj = null;
         var _loc5_:uint = 0;
         if(this.curAddEffect)
         {
            if(this.curAddEffect.curDebuff(BaseAddEffect.MAGIC_UMBRELLA_DEFEND))
            {
               this.curAddEffect.reduceMagicUmbDef(param1);
               return;
            }
         }
         if(gc.sid == this.sid && gc.isInRoom())
         {
            _loc3_ = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId()) as MutiUser;
            if(_loc3_)
            {
               _loc3_.hp -= param1;
               gc.sendSelfMutiUserInfo(this.getRoleId());
            }
         }
         this.roleProperies.setHHP(this.roleProperies.getHHP() - param1);
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            this.addHeroHurtMc(param1);
         }
         if(!this.isDead())
         {
            if(param2)
            {
               this.setAction("hurt");
               this.doubleCount = 0;
            }
         }
         else
         {
            if(gc.isSingleGame() && this.getPlayer())
            {
               if(_loc4_ = this.getPlayer().getCurEquipByType("zbsp"))
               {
                  if(_loc4_.getFillName() == "shsjt")
                  {
                     _loc5_ = _loc4_.getStrengthValue();
                     this.roleProperies.setHHP(this.roleProperies.getSHHP() * (_loc5_ + 1) * 0.2);
                     this.getPlayer().removeCurEquip(_loc4_);
                     return;
                  }
               }
            }
            if(!this.isAlreadyDead)
            {
               this.isAlreadyDead = true;
               this.destroy();
               if(gc.sid == this.sid && gc.isInRoom())
               {
                  gc.sendDead(this.getRoleId());
               }
               gc.eventManger.dispatchEvent(new CommonEvent("heroDead",this));
            }
         }
      }
      
      override public function isWaiting() : Boolean
      {
         return this.curAction == "wait" || this.curAction == "wait2";
      }
      
      public function reduceMp(param1:int) : void
      {
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      protected function setPet() : void
      {
         this.updatePet();
      }
      
      public function getCurMagicWeapon() : BaseMagicWeapon
      {
         return this.curMagicWeapon;
      }
      
      public function updateMagicWeapon() : void
      {
         if(this.curMagicWeapon)
         {
            this.curMagicWeapon.step();
         }
      }
      
      public function updatePet() : void
      {
         if(this.myPet)
         {
            this.myPet.step();
         }
      }
      
      public function clearPet() : void
      {
         this.myPet = null;
      }
      
      public function sendSkill(param1:int) : void
      {
         if(this.isDead())
         {
            return;
         }
         var _loc2_:String = "";
         switch(param1)
         {
            case 0:
               if(this.getPlayer().controlPlayer == 0)
               {
                  _loc2_ = "Y";
               }
               else
               {
                  _loc2_ = "8";
               }
               this.showSkill(_loc2_);
               break;
            case 1:
               if(this.getPlayer().controlPlayer == 0)
               {
                  _loc2_ = "L";
               }
               else
               {
                  _loc2_ = "3";
               }
               this.showSkill(_loc2_);
               break;
            case 2:
               if(this.getPlayer().controlPlayer == 0)
               {
                  _loc2_ = "U";
               }
               else
               {
                  _loc2_ = "4";
               }
               this.showSkill(_loc2_);
               break;
            case 3:
               if(this.getPlayer().controlPlayer == 0)
               {
                  _loc2_ = "I";
               }
               else
               {
                  _loc2_ = "5";
               }
               this.showSkill(_loc2_);
               break;
            case 4:
               if(this.getPlayer().controlPlayer == 0)
               {
                  _loc2_ = "O";
               }
               else
               {
                  _loc2_ = "6";
               }
               this.showSkill(_loc2_);
               break;
            case 5:
               this.showSkillKongGe();
               break;
            case 6:
               this.showSkillFaBao();
         }
      }
      
      protected function showSkill(param1:String) : void
      {
      }
      
      protected function showSkillKongGe() : void
      {
      }
      
      protected function showSkillFaBao() : void
      {
         if(!gc.isSingleGame())
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         if(this.curMagicWeapon)
         {
            this.curMagicWeapon.useSkill();
         }
      }
      
      public function __keyBoardUp(param1:KeyboardEvent) : void
      {
         if(!gc.keyboardControl.isInThisPlayerKeyboard(this.player,param1.keyCode))
         {
            return;
         }
         if(param1.keyCode == this.lastKey.keyCode)
         {
            ++this.keyId;
         }
         switch(param1.keyCode)
         {
            case gc.keyboardControl.getLeftByPlayer(this.player):
               this.stopMoveLeft();
               if(this.lastDirbtn == param1.keyCode)
               {
                  this.lastDirbtn = 0;
               }
               this.doubleCount = 0;
               break;
            case gc.keyboardControl.getRightByPlayer(this.player):
               this.stopMoveRight();
               if(this.lastDirbtn == param1.keyCode)
               {
                  this.lastDirbtn = 0;
               }
               this.doubleCount = 0;
         }
         var _loc2_:uint = this.keyList.length;
         while(_loc2_-- > 0)
         {
            if(this.keyList[_loc2_] == param1.keyCode)
            {
               this.cannextaction = true;
               this.keyarray[_loc2_] = 0;
            }
         }
      }
      
      public function stopMoveLeft() : void
      {
         this.isLeft = false;
         if(!this.isRight)
         {
            if(!this.isAttacking())
            {
               if(!this.isInSky())
               {
                  if(!this.isWaiting())
                  {
                     this.setAction("wait");
                  }
                  if(this.sid == gc.sid)
                  {
                     gc.sendPosition(this);
                  }
               }
               else if(this.sid == gc.sid)
               {
                  gc.sendLorRInfo(this);
               }
            }
            if(!this.isCanMoveWhenAttack())
            {
               this.speed.x = 0;
            }
         }
         else
         {
            this.bbdc.turnRight();
         }
      }
      
      public function stopMoveRight() : void
      {
         this.isRight = false;
         if(!this.isLeft)
         {
            if(!this.isAttacking())
            {
               if(!this.isInSky())
               {
                  if(!this.isWaiting())
                  {
                     this.setAction("wait");
                  }
                  if(this.sid == gc.sid)
                  {
                     gc.sendPosition(this);
                  }
               }
               else if(this.sid == gc.sid)
               {
                  gc.sendLorRInfo(this);
               }
            }
            if(!this.isCanMoveWhenAttack())
            {
               this.speed.x = 0;
            }
         }
         else
         {
            this.bbdc.turnLeft();
         }
      }
      
      override public function getHurtByPig8(param1:int) : void
      {
         this.reduceHp(param1);
         this.addHeroHurtMc(param1);
      }
      
      override public function beMagicAttack(param1:BaseBullet, param2:BaseObject, param3:Boolean = false) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:Point = null;
         var _loc9_:Number = NaN;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Array = null;
         var _loc13_:uint = 0;
         var _loc14_:Object = null;
         if(gc.protectedPerproty.getProperty(this,"isYourFather"))
         {
            return false;
         }
         if(param3 || this.colipse && AUtils.testIntersects(this.colipse,param1,gc.gameSence) && HitTest.complexHitTestObject(this.colipse,param1))
         {
            if(Math.random() <= this.roleProperies.getMiss())
            {
               this.addMissMc();
               return true;
            }
            _loc4_ = (Math.random() - 0.5) * 10;
            _loc5_ = param2.getRealPower(param1.curAction);
            _loc7_ = param2.attackBackInfoDict[param1.curAction];
            if(param1.getImcName() == "Role1Bullet12")
            {
               if((_loc9_ = AUtils.GetDisBetweenTwoObj(this,param2)) > 1000)
               {
                  _loc9_ = 1000;
               }
               _loc5_ = _loc5_ * (1000 - _loc9_) / 1000;
            }
            _loc6_ = this.countHurt(_loc5_,_loc7_);
            if(param1.getImcName() == "Role1Bullet12")
            {
               this.reduceHp(_loc6_,false);
            }
            else
            {
               this.reduceHp(_loc6_,true);
            }
            if(param2 is BaseHero)
            {
               if(_loc7_ && _loc7_.attackKind == "physics")
               {
                  if(BaseHero(param2).sid == gc.sid && gc.isInRoom())
                  {
                     _loc10_ = BaseHero(param2).roleProperies.getEatBlood();
                     trace("吸血：" + _loc10_ + "%");
                     if((_loc11_ = int(_loc10_ / 100 * _loc6_)) > 0)
                     {
                        BaseHero(param2).cureHp(_loc11_);
                     }
                  }
               }
            }
            else if(param2 is Monster6)
            {
               if(Math.random() <= 0.1)
               {
                  if(this.curAddEffect)
                  {
                     this.curAddEffect.add([{
                        "name":BaseAddEffect.PETHORSE_ICE,
                        "time":gc.frameClips * 2
                     }]);
                  }
               }
            }
            else if(param2 is Monster16)
            {
               if(Math.random() <= 0.2)
               {
                  if(this.curAddEffect)
                  {
                     this.curAddEffect.add([{
                        "name":BaseAddEffect.PETMONKEY_FIRE,
                        "hurt":10,
                        "time":gc.frameClips * 3
                     }]);
                  }
               }
            }
            else if(param2 is Monster34)
            {
               if(_loc7_ && _loc7_.attackKind == "physics")
               {
                  Monster34(param2).cureHp(_loc6_ * 0.05);
               }
            }
            _loc8_ = this.getBeattackBackSpeed(param1,_loc7_);
            if(param2 is BaseHero && this.sid != gc.sid)
            {
               if(BaseHero(param2).sid == gc.sid)
               {
                  if(param1.getImcName() == "Role1Bullet12")
                  {
                     gc.sendHurt(_loc6_,this.sid,this.getRoleId() * 10 + BaseHero(param2).getRoleId(),param1.curAction,_loc8_.x,_loc8_.y,param1.initTimer,false,false);
                  }
                  else
                  {
                     gc.sendHurt(_loc6_,this.sid,this.getRoleId() * 10 + BaseHero(param2).getRoleId(),param1.curAction,_loc8_.x,_loc8_.y,param1.initTimer);
                  }
               }
            }
            else if(param2 is BasePet && this.sid != gc.sid)
            {
               if(BasePet(param2).getSourceRole().sid == gc.sid)
               {
                  if(param1.getImcName() == "Role1Bullet12")
                  {
                     gc.sendHurt(_loc6_,this.sid,this.getRoleId() * 10 + BasePet(param2).getSourceRole().getRoleId(),param1.curAction,_loc8_.x,_loc8_.y,param1.initTimer,false,false);
                  }
                  else
                  {
                     gc.sendHurt(_loc6_,this.sid,this.getRoleId() * 10 + BasePet(param2).getSourceRole().getRoleId(),param1.curAction,_loc8_.x,_loc8_.y,param1.initTimer);
                  }
               }
            }
            if(this is Role3)
            {
               if(this.curAction == "hit12")
               {
                  trace("反弹");
                  if(param2 is BaseMonster)
                  {
                     param2.reduceHp(_loc6_ * 2);
                     BaseMonster(param2).addMonHurtMc(_loc6_ * 2,false);
                  }
                  else if(param2.sid == gc.sid)
                  {
                     param2.reduceHp(_loc6_);
                  }
               }
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(Role3(this).getPlayer())
                  {
                     if(Role3(this).getPlayer().findSkillIsInTheSkillAry("rj"))
                     {
                        if(Math.random() <= 0.1)
                        {
                           trace("反弹！");
                           this.cureHp(this.roleProperies.getHurt());
                        }
                     }
                  }
               }
            }
            if(param1.getImcName() != "Role1Bullet12")
            {
               this.setAttackBack(_loc8_);
            }
            if(_loc7_.addEffect)
            {
               _loc12_ = AUtils.clone(_loc7_.addEffect) as Array;
               _loc13_ = 0;
               while(_loc13_ < _loc12_.length)
               {
                  if((_loc14_ = _loc12_[_loc13_]).time == BaseBullet.DESIDE_BY_FRAMES_LEFT)
                  {
                     _loc14_.time = param1.getFrameLeft();
                  }
                  _loc13_++;
               }
               this.addCurAddEffect(_loc12_);
            }
            this.beAttackIdArray.push(param1.getAttackId());
            this.beAttackDoing();
            if(this is Role1)
            {
               SoundManager.play("Role1_beAttack");
            }
            else if(this is Role2)
            {
               SoundManager.play("Role2_beAttack");
            }
            else if(this is Role3)
            {
               SoundManager.play("Role3_beAttack");
            }
            else if(this is Role4)
            {
               SoundManager.play("Role3_beAttack");
            }
            return true;
         }
         return false;
      }
      
      protected function countHurt(param1:int, param2:Object) : int
      {
         var _loc3_:MutiUser = null;
         var _loc4_:Number = NaN;
         var _loc5_:uint = 0;
         if(param2)
         {
            if(param2.attackKind == "magic")
            {
               if(this.getPlayer())
               {
                  _loc4_ = this.roleProperies.getMagicDef() / 100;
               }
               else
               {
                  _loc3_ = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
                  _loc4_ = _loc3_.mDef / 100;
               }
               if(_loc4_ > 1)
               {
                  param1 = 99999;
               }
               else
               {
                  param1 *= 1 - _loc4_;
               }
               return param1;
            }
            if(param2.attackKind == "physics")
            {
               if(this.getPlayer())
               {
                  _loc5_ = this.roleProperies.getDefense();
               }
               else
               {
                  _loc3_ = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
                  _loc5_ = _loc3_.def;
               }
               if(param1 > _loc5_)
               {
                  param1 -= _loc5_;
               }
               else
               {
                  param1 = 1;
               }
               return param1;
            }
         }
         return param1;
      }
      
      public function beAttackDoing() : void
      {
         this.resetGraity();
         this.addBeAttackEffect(null);
         if(this.curAddEffect)
         {
            this.curAddEffect.updateFather();
         }
      }
      
      override protected function addBeAttackEffect(param1:BaseObject) : void
      {
         var _loc2_:MovieClip = AUtils.getNewObj("HeroBeHurt");
         var _loc3_:ColorMatrix = new ColorMatrix();
         if(this is Role2)
         {
            _loc3_.adjustColor(0,0,0,160);
         }
         _loc2_.filters = [new ColorMatrixFilter(_loc3_)];
         _loc2_.x = this.colipse.x;
         _loc2_.y = this.colipse.y;
         this.addChild(_loc2_);
      }
      
      public function getPet() : BasePet
      {
         return this.myPet;
      }
      
      public function getKeyArray() : Array
      {
         return this.keyarray;
      }
      
      public function getPlayer() : User
      {
         return this.player;
      }
      
      override public function isAttacking() : Boolean
      {
         return false;
      }
      
      override public function isWalkOrRun() : Boolean
      {
         return this.curAction == "walk" || this.doubleCount == 1;
      }
      
      public function normalHit() : *
      {
      }
      
      override public function resetGraity() : void
      {
         super.resetGraity();
      }
      
      public function setKeyList(param1:Array) : void
      {
         this.keyList = param1;
      }
      
      public function setPlayer(param1:User) : void
      {
         this.player = param1;
      }
      
      public function setLostKeyboard() : void
      {
         gc.keyboardControl.setNoControlByPlayer(this.getPlayer());
         var _loc1_:int = 0;
         while(_loc1_ < this.keyarray.length)
         {
            this.keyarray[_loc1_] = 0;
            _loc1_++;
         }
         this.lastDirbtn = 0;
         this.lastKey = {};
         this.cannextaction = true;
      }
      
      public function reSetLostKeyboard() : void
      {
         gc.keyboardControl.setYesControlByPlayer(this.getPlayer());
      }
      
      override public function step() : void
      {
         super.step();
         this.stepOther();
         if(this.curAction == "jump1" && this.speed.y > 0)
         {
            this.setAction("jump3");
            if(this.getPlayer())
            {
               gc.sendPosition(this);
            }
         }
         this.setPet();
         this.updateMagicWeapon();
      }
      
      protected function stepOther() : void
      {
         var _loc1_:RoleInfo = null;
         if(this.isGXP)
         {
            if(this.getPlayer())
            {
               _loc1_ = gc.gameInfo.getRoleInfoByPlayer(this.player);
            }
            ++shadowCount;
            if(this.shadowCount % 4 == 0)
            {
               this.shadowEffect();
               if(this.getPlayer())
               {
                  if(_loc1_.isGXPAlive())
                  {
                     _loc1_.reduceGXP(1);
                  }
                  else
                  {
                     this.isGXP = false;
                     this.turnToNormal();
                     if(gc.sid == this.sid && gc.isInRoom())
                     {
                        gc.sendAttack(this.getRoleId(),"wushuangOver",0,0,0,[]);
                     }
                  }
               }
            }
         }
         if(this.getPlayer())
         {
            this.roleProperies.step();
            this.executeKeyCode();
            this.executeLastDirKey();
         }
      }
      
      public function upGrade(param1:Boolean = true) : *
      {
         if(this.roleProperies)
         {
            this.roleProperies.removeAllBuff();
         }
      }
      
      protected function addDoubleCount(param1:uint) : *
      {
         if(param1 == this.lastKey.keyCode && this.keyId != this.lastKey.keyId)
         {
            this.curUpTime = getTimer();
            if(this.curUpTime - this.lastUpTime >= 500)
            {
               this.doubleCount = 0;
            }
            else
            {
               if(this.doubleCount == 0)
               {
                  if(this.getPlayer())
                  {
                     gc.sendRun(this.getRoleId());
                  }
               }
               this.doubleCount = 1;
            }
            this.lastUpTime = this.curUpTime;
         }
         if(param1 != this.lastKey.keyCode)
         {
            this.doubleCount = 0;
            this.curUpTime = getTimer();
            this.lastUpTime = this.curUpTime;
         }
      }
      
      public function addHeroHurtMc(param1:int) : void
      {
         var _loc2_:ANumber = new ANumber();
         this.gc.gameSence.addChild(_loc2_);
         _loc2_.aNumImage("pnum",param1,this.x - 20,this.y - 60,20);
      }
      
      protected function addMissMc() : void
      {
         var missMc:* = undefined;
         missMc = AUtils.getImageObj("miss");
         missMc.x = this.x - 20;
         missMc.y = this.y - 60;
         this.gc.gameSence.addChild(missMc);
         TweenMax.to(missMc,2,{
            "y":missMc.y - 60,
            "alpha":0,
            "onComplete":function():*
            {
               if(missMc && gc.gameSence && gc.gameSence.contains(missMc))
               {
                  gc.gameSence.removeChild(missMc);
               }
            }
         });
      }
      
      protected function checkDirect() : void
      {
         if(this.isLeft)
         {
            this.bbdc.turnLeft();
         }
         if(this.isRight)
         {
            this.bbdc.turnRight();
         }
      }
      
      protected function checkDoubleCount(param1:uint) : void
      {
      }
      
      protected function doWsEffect() : void
      {
         var _loc1_:WsEffect = new WsEffect();
         _loc1_.x = 470;
         _loc1_.y = 295;
         if(this is Role1)
         {
            _loc1_.Role2Mc.visible = false;
            _loc1_.Role3Mc.visible = false;
         }
         else if(this is Role2)
         {
            _loc1_.Role1Mc.visible = false;
            _loc1_.Role3Mc.visible = false;
         }
         else if(this is Role3)
         {
            _loc1_.Role1Mc.visible = false;
            _loc1_.Role2Mc.visible = false;
         }
         gc.gameInfo.addChild(_loc1_);
      }
      
      protected function executeKeyCode() : *
      {
         this.myKeyDown(this.keyarray.join(""));
      }
      
      protected function executeLastDirKey() : void
      {
         if(!this.isAttacking())
         {
            switch(this.lastDirbtn)
            {
               case 65:
               case 37:
                  this.turnLeft();
                  break;
               case 68:
               case 39:
                  this.turnRight();
            }
         }
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return false;
      }
      
      override protected function isRunning() : Boolean
      {
         return this.doubleCount == 1;
      }
      
      override protected function jump() : void
      {
         if(gc.protectedPerproty.getProperty(this,"jumpCount") < 2 && !this.isAttacking() && !this.isBeAttacking())
         {
            this.speed.y = jumpPower;
            if(gc.protectedPerproty.getProperty(this,"jumpCount") == 0)
            {
               gc.protectedPerproty.setProperty(this,"jumpCount",1);
               this.setAction("jump1");
               if(this.getPlayer())
               {
                  gc.sendWalkInfo(this);
               }
            }
            else
            {
               gc.protectedPerproty.setProperty(this,"jumpCount",2);
               this.setAction("jump2");
               if(this.getPlayer())
               {
                  gc.sendWalkInfo(this);
               }
            }
         }
      }
      
      public function doJump() : void
      {
         this.jump();
      }
      
      override protected function move() : void
      {
         if(this.curAddEffect)
         {
            if(this.curAddEffect.curDebuff(BaseAddEffect.FIX) || this.curAddEffect.curDebuff(BaseAddEffect.PETHORSE_ICE))
            {
               return;
            }
         }
         if(this.isCanMoveByStage())
         {
            if(this.standInObj)
            {
               if(this.isWaiting())
               {
                  if(this.standInObj is Wall)
                  {
                     this.speed.x = Wall(this.standInObj).speedX;
                  }
                  else
                  {
                     this.speed.x = 0;
                  }
               }
            }
            if(this.standInObj is Wall && this.speed.x == 0)
            {
               this.speed.x = Wall(this.standInObj).speedX;
            }
            this.x += this.speed.x;
         }
         this.y += this.speed.y;
         this.speed.y += graity;
         this.x += this.enforceSpeed.x;
         this.y += this.enforceSpeed.y;
      }
      
      override public function isCanMoveByStage() : Boolean
      {
         if(gc.isSingleGame() || gc.sid == this.sid)
         {
            return super.isCanMoveByStage();
         }
         return true;
      }
      
      protected function myKeyDown(param1:String) : *
      {
         if(this.timers > 0)
         {
            --this.timers;
         }
      }
      
      override protected function setSpeed() : void
      {
         super.setSpeed();
      }
      
      override protected function checkOver() : void
      {
         if(this.y >= 1500)
         {
            this.roleProperies.setHHP(-1);
         }
      }
      
      override protected function turnToGXP() : void
      {
         this.isGXP = true;
         this.graity = 3.75;
         this.horizenSpeed *= 1.5;
         this.horizenRunSpeed *= 1.5;
         this.jumpPower *= 1.5;
         if(this.sid == gc.sid && gc.isInRoom())
         {
            gc.sendAttack(this.getRoleId(),"wushuangStart",0,0,0,[]);
         }
      }
      
      override public function isDead() : Boolean
      {
         var _loc1_:MutiUser = null;
         if(this.player)
         {
            return this.roleProperies.getHHP() <= 0;
         }
         _loc1_ = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
         if(_loc1_)
         {
            return _loc1_.hp <= 0;
         }
         return true;
      }
      
      override public function setStatic() : void
      {
         super.setStatic();
         this.doubleCount = 0;
      }
      
      public function setSpeedStaticOnly() : void
      {
         super.setStatic();
      }
      
      protected function turnToNormal() : void
      {
         this.graity = 1.5;
         this.horizenSpeed /= 1.5;
         this.horizenRunSpeed /= 1.5;
         this.jumpPower /= 1.5;
      }
      
      public function checkTransferDoor() : Boolean
      {
         var _loc3_:MovieClip = null;
         var _loc1_:Array = gc.pWorld.getTransferDoorArray();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as MovieClip;
            if(_loc3_.hitTestObject(this.colipse) && _loc3_.visible)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function setCurPower() : void
      {
      }
      
      override public function isNormalHit() : Boolean
      {
         return true;
      }
      
      public function setCurClothId(param1:int) : void
      {
         this.protectedEquipObject.curClothId1 = AUtils.getRandomValue();
         this.protectedEquipObject.curClothId2 = param1 - this.protectedEquipObject.curClothId1;
         var _loc2_:MutiUser = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
         if(_loc2_)
         {
            if(param1 != _loc2_.equpId)
            {
               _loc2_.equpId = param1;
               gc.sendSelfMutiUserInfo(this.getRoleId());
            }
         }
      }
      
      public function getCurClothId() : int
      {
         return this.protectedEquipObject.curClothId1 + this.protectedEquipObject.curClothId2;
      }
      
      public function setCurWeaponId(param1:int) : void
      {
         var _loc2_:MutiUser = null;
         this.protectedEquipObject.curWeaponId1 = AUtils.getRandomValue();
         this.protectedEquipObject.curWeaponId2 = param1 - this.protectedEquipObject.curWeaponId1;
         if(gc.sid == this.sid && !gc.isSingleGame())
         {
            _loc2_ = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
            if(_loc2_)
            {
               if(param1 != _loc2_.weaponId)
               {
                  _loc2_.weaponId = param1;
                  gc.sendSelfMutiUserInfo(this.getRoleId());
               }
            }
         }
      }
      
      public function getCurWeaponId() : int
      {
         return this.protectedEquipObject.curWeaponId1 + this.protectedEquipObject.curWeaponId2;
      }
      
      public function registerProtectedProperty() : void
      {
         gc.protectedPerproty.addProperty(this,"isYourFather",false);
         gc.protectedPerproty.addProperty(this,"jumpCount",0);
      }
      
      override public function getRoleId() : uint
      {
         if(this.getPlayer())
         {
            return this.getPlayer().roleid;
         }
         return this.roleId;
      }
      
      public function setRoleId(param1:uint) : void
      {
         this.roleId = param1;
      }
      
      public function clearAllBullets() : void
      {
         var _loc2_:BaseBullet = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.magicBulletArray.length)
         {
            _loc2_ = this.magicBulletArray[_loc1_] as BaseBullet;
            _loc2_.setDisable();
            TweenMax.killChildTweensOf(_loc2_);
            _loc2_.destroy();
            _loc1_++;
         }
         this.magicBulletArray = [];
      }
      
      public function getServerSaveInfo() : String
      {
         var _loc1_:String = "";
         return _loc1_ + this.roleProperies.getLevel();
      }
      
      public function destroy() : void
      {
         trace("---destroy---");
         if(this.bbdc)
         {
            this.bbdc.destroy();
         }
         if(this.isGXP)
         {
            this.isGXP = false;
            this.turnToNormal();
         }
         if(this.getPlayer())
         {
            if(gc.keyboardControl)
            {
               this.keyarray = gc.keyboardControl.getZeroKeyArray();
            }
         }
         this.resetGraity();
         this.setStatic();
         this.speed.y = 0;
         this.doubleCount = 0;
         this.lastKey = new Object();
         this.lasttime = 0;
         this.lastUpTime = 0;
         this.lastDirbtn = 0;
         this.fatherCount = 0;
         if(this.curAddEffect)
         {
            this.curAddEffect.destroy();
            this.curAddEffect = null;
         }
         this.beAttackIdArray = [];
         this.clearAllBullets();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.isReadyToDestroy = true;
         gc.protectedPerproty.removeProperty(this);
         if(this.curMagicWeapon)
         {
            this.curMagicWeapon.destroy();
            this.curMagicWeapon = null;
         }
         if(this.getPet())
         {
            this.getPet().destroy();
            this.myPet = null;
         }
      }
      
      public function refreshEquip() : void
      {
      }
      
      public function changeEquip(param1:Object) : void
      {
         this.setCurClothId(param1.zbfj);
         this.setCurWeaponId(param1.zbwq);
         this.refreshEquip();
      }
      
      public function changePet() : void
      {
         var _loc1_:MutiUser = null;
         var _loc2_:PetInfo = null;
         if(this.getPet())
         {
            this.getPet().destroy();
         }
         this.initPet();
         if(gc.sid == this.sid && !gc.isSingleGame())
         {
            _loc1_ = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
            if(_loc1_ && this.getPlayer())
            {
               _loc2_ = this.getPlayer().findCurrentPet();
               if(_loc2_)
               {
                  _loc1_.petName = _loc2_.getPetName();
                  _loc1_.petHp = _loc2_.getHp();
                  _loc1_.petMp = _loc2_.getMp();
                  gc.sendSelfMutiUserInfo(this.getRoleId());
               }
               else
               {
                  _loc1_.petName = "";
                  _loc1_.petHp = 0;
                  _loc1_.petMp = 0;
                  gc.sendSelfMutiUserInfo(this.getRoleId());
               }
            }
         }
      }
      
      public function changeMagicWeapon() : void
      {
         var _loc1_:MutiUser = null;
         if(this.getCurMagicWeapon())
         {
            this.getCurMagicWeapon().destroy();
         }
         this.initMagicWeapon();
         if(gc.sid == this.sid && !gc.isSingleGame())
         {
            _loc1_ = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
            if(_loc1_ && this.getPlayer())
            {
               if(_loc1_.bmwId != this.getCurMagicWeapon().bmwId)
               {
                  _loc1_.bmwId = this.getCurMagicWeapon().bmwId;
                  gc.sendSelfMutiUserInfo(this.getRoleId());
               }
            }
         }
      }
      
      protected function beAttackByRole2Hit7(param1:Point) : void
      {
         var p:Point = param1;
         this.resetGraity();
         TweenMax.to(this,0.625,{
            "x":p.x,
            "y":p.y - 30,
            "onComplete":function(param1:BaseObject):*
            {
               if(!param1.isDead())
               {
                  TweenMax.to(param1,0.625,{"y":param1.y - 20});
               }
            },
            "onCompleteParams":[this]
         });
      }
      
      protected function beAttackByRole3Hit6(param1:Point) : void
      {
         this.resetGraity();
         TweenMax.to(this,1,{
            "x":param1.x,
            "y":param1.y
         });
      }
   }
}
