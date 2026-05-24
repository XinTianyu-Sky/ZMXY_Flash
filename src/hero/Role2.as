package export.hero
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.RoleInfo;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import manager.SoundManager;
   import my.ANumber;
   import my.ExceedPower;
   import my.MainGame;
   
   public class Role2 extends BaseHero
   {
       
      
      private var hit11Count:uint = 35;
      
      private var hit2NeedCount:uint = 48;
      
      private var hit2CurrentCount:uint = 0;
      
      private var hit5NeedCount:uint = 48;
      
      private var hit5CurrentCount:uint = 0;
      
      private var hit4_2Point:Point;
      
      public var role2Shalldow:Role2Shadow;
      
      private var isHit7Ok:Boolean = false;
      
      public function Role2()
      {
         this.hit4_2Point = new Point(-99,-99);
         super();
         roleName = "唐僧";
         userType = "唐僧";
         this.horizenSpeed = 6;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[-2,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-10,-1],
            "attackInterval":4,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[-7,-4],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-8,-3],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-15,-2],
            "attackInterval":48,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit6"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-14,-25],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit7"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-15,0],
            "attackInterval":4,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit8"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-8,-2],
            "attackInterval":3,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9_1"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9_2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-8,-2],
            "attackInterval":5,
            "attackKind":"magic"
         };
         this.exceedPowerSprite = new ExceedPower(this.colipse.width,9,this.hit2NeedCount);
         this.exceedPowerSprite.x = this.x - this.colipse.width / 2;
         this.exceedPowerSprite.y = this.y - this.colipse.height / 2 - 20;
         this.addChild(this.exceedPowerSprite);
         nameTextField.y = -this.colipse.height / 2 - 30;
         nameTextField.x = -this.colipse.width / 2 - 30;
         nameTextField.selectable = false;
         nameTextField.autoSize = "center";
         nameTextField.cacheAsBitmap = true;
         this.addChild(nameTextField);
      }
      
      override protected function initBBDC() : void
      {
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc1_:uint = this.getCurClothId();
         var _loc2_:uint = this.getCurWeaponId();
         var _loc3_:Array = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE2_" + _loc1_);
         var _loc4_:Array = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE2_EQUIP_" + _loc2_);
         if(_loc3_)
         {
            _loc5_ = {
               "name":"body",
               "source":_loc3_
            };
            _loc6_ = {
               "name":"equip",
               "source":_loc4_
            };
            bbdc = new BaseBitmapDataClip([_loc5_,_loc6_],200,200,new Point(0,0));
            bbdc.setOffsetXY(15,0);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,14],[4,4,4,4],[2,2,2,2],[1,1,30,55,8],[2,2,2,2,2],[2,4,12],[2,10,2,40],[2,2],[2,2,6],[48,2,15],[2,2,20],[2,2,10]]);
            bbdc.setFrameCount([36,4,4,4,[1,1,1,1,1,1],5,3,4,24,3,3,3,3]);
            bbdc.setEnterFrameCallBack(this.enterFrameFunc,this.exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(this.scriptFrameOverFunc);
            this.body.addChild(bbdc);
            this.bbdc.turnRight();
            return;
         }
         throw new Error("ROLE2--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(param1:String) : void
      {
         var _loc3_:BaseBullet = null;
         super.setAction(param1);
         var _loc2_:Point = this.bbdc.getCurPoint();
         switch(param1)
         {
            case "wait":
               if(_loc2_.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(param1);
               break;
            case "wait2":
               if(_loc2_.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(param1);
               break;
            case "walk":
               if(_loc2_.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(param1);
               break;
            case "run":
               if(_loc2_.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(param1);
               break;
            case "jump1":
               if(_loc2_.x != 0 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "jump2":
               if(_loc2_.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(param1);
               break;
            case "jump3":
               if(_loc2_.x != 1 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(1);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hit1":
               if(_loc2_.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(param1);
               break;
            case "hit3":
               if(_loc2_.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(param1);
               break;
            case "hit4_1":
               if(_loc2_.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(param1);
               break;
            case "hit4_2":
               for each(_loc3_ in this.magicBulletArray)
               {
                  if(_loc3_.name == "Role1Bullet4_1")
                  {
                     _loc3_.destroy();
                  }
               }
               if(_loc2_.y != 9)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(9);
               }
               this.bbdc.setState(param1);
               break;
            case "hit5":
               if(_loc2_.y != 10)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(10);
               }
               this.bbdc.setState(param1);
               break;
            case "hit6":
               if(_loc2_.y != 11)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(11);
               }
               this.bbdc.setState(param1);
               break;
            case "hit7":
               if(_loc2_.x != 0 || _loc2_.y != 12)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(param1);
               break;
            case "hit8":
               if(_loc2_.x != 2 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(2);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hit9":
               if(_loc2_.x != 3 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hurt":
               this.hit5CurrentCount = 0;
               if(_loc2_.x == 4 && _loc2_.y == 4)
               {
                  this.getBBDC().resetCurFrameStopCount();
               }
               else
               {
                  this.bbdc.setFramePointX(4);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
         }
      }
      
      override protected function scriptFrameOverFunc(param1:int) : void
      {
         var _loc2_:String = this.bbdc.getState();
         switch(_loc2_)
         {
            case "walk":
               this.bbdc.setFramePointX(0);
               break;
            case "run":
               this.bbdc.setFramePointX(0);
               break;
            case "wait":
               this.setAction("wait2");
               break;
            case "wait2":
               this.setAction("wait");
               break;
            case "jump1":
               this.bbdc.setFramePointX(0);
               break;
            case "jump2":
               this.setAction("jump3");
               break;
            case "jump3":
               this.bbdc.setFramePointX(1);
               break;
            case "hit1":
               this.setAction("wait");
               break;
            case "hit3":
               this.resetGraity();
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit4_1":
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit4_2":
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit5":
               this.setAction("wait");
               break;
            case "hit6":
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit7":
               this.setStatic();
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit8":
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit9":
               this.resetGraity();
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hurt":
               this.resetGraity();
               this.setStatic();
               this.setAction("wait");
         }
      }
      
      override protected function enterFrameFunc(param1:Point) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:BaseBullet = null;
         var _loc2_:String = this.bbdc.getState();
         var _loc3_:Point = new Point();
         switch(_loc2_)
         {
            case "hit1":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(param1.x == 1)
                  {
                     if(this.getPlayer())
                     {
                        if(this.getPlayer().findSkillIsInTheSkillAry("blb"))
                        {
                           if(this.roleProperies.getMMP() >= 20 && this.keyarray[1] == 1)
                           {
                              ++this.hit2CurrentCount;
                              this.bbdc.resetCurFrameStopCount();
                           }
                           else
                           {
                              this.bbdc.setFramePointX(2);
                              this.bbdc.resetCurFrameStopCount();
                           }
                        }
                        else
                        {
                           this.bbdc.setFramePointX(2);
                           this.bbdc.resetCurFrameStopCount();
                        }
                     }
                  }
                  if(this.bbdc.getCurFrameCount() == 12)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 50;
                        }
                        else
                        {
                           _loc3_.x = this.x + 50;
                        }
                        _loc3_.y = this.y + 10;
                        if(this.hit2NeedCount <= this.hit2CurrentCount)
                        {
                           this.doHit2(this.getBBDC().getDirect(),_loc3_);
                           if(gc.sid == this.sid)
                           {
                              gc.sendAttack(this.getRoleId(),"hit2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                           }
                           this.roleProperies.setMMP(this.roleProperies.getMMP() - 20);
                        }
                        else
                        {
                           _loc4_ = getTimer();
                           this.doHit1(this.getBBDC().getDirect(),_loc3_,_loc4_);
                           if(gc.sid == this.sid)
                           {
                              gc.sendAttack(this.getRoleId(),"hit1",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[],_loc4_);
                           }
                        }
                        this.hit2CurrentCount = 0;
                     }
                  }
               }
               else if(param1.x == 1)
               {
                  this.bbdc.resetCurFrameStopCount();
               }
               break;
            case "hit3":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x;
                        }
                        else
                        {
                           _loc3_.x = this.x;
                        }
                        _loc3_.y = this.y + 10;
                        this.doHit3(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit3",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
                  if(param1.x == 3)
                  {
                     if(this.bbdc.getCurFrameCount() >= 20 && this.bbdc.getCurFrameCount() % 8 == 0)
                     {
                        gc.vControllor.shake(25);
                     }
                  }
               }
               if(param1.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(this.role2Shalldow)
                     {
                        this.role2Shalldow.setAction("hit1");
                     }
                  }
               }
               this.speed.y = 0;
               break;
            case "hit4_1":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  _loc5_ = false;
                  for each(_loc6_ in this.magicBulletArray)
                  {
                     if(_loc6_.name == "Role1Bullet4_1")
                     {
                        this.hit4_2Point.x = _loc6_.x;
                        this.hit4_2Point.y = _loc6_.y;
                        _loc5_ = true;
                        break;
                     }
                  }
                  if(!_loc5_ && this.bbdc.getCurFrameCount() == 1)
                  {
                     if(param1.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 200;
                        }
                        else
                        {
                           _loc3_.x = this.x + 200;
                        }
                        _loc3_.y = this.y + 10;
                        this.doHit4_1(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit4_1",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               this.speed.y = -4;
               break;
            case "hit4_2":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 6)
                  {
                     if(param1.x == 2)
                     {
                        _loc3_.x = this.hit4_2Point.x;
                        _loc3_.y = this.hit4_2Point.y - 320;
                        this.doHit4_2(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit4_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               this.speed.y = 0;
               break;
            case "hit5":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(param1.x == 0)
                  {
                     ++this.hit5CurrentCount;
                  }
                  if(this.bbdc.getCurFrameCount() == 15)
                  {
                     if(param1.x == 2)
                     {
                        this.hit5CurrentCount = 0;
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 175;
                        }
                        else
                        {
                           _loc3_.x = this.x + 175;
                        }
                        _loc3_.y = this.y - 110;
                        this.doHit5(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit5",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit6":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x;
                        }
                        else
                        {
                           _loc3_.x = this.x;
                        }
                        _loc3_.y = this.y - 25;
                        this.doHit6(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit6",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               if(param1.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     if(this.role2Shalldow)
                     {
                        this.role2Shalldow.setAction("hit2");
                     }
                  }
               }
               break;
            case "hit7":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     if(param1.x == 2)
                     {
                        if(this.getBBDC().getDirect() == 0)
                        {
                           _loc3_.x = this.x - 210;
                        }
                        else
                        {
                           _loc3_.x = this.x + 210;
                        }
                        _loc3_.y = this.y + 30;
                        this.doHit7(this.getBBDC().getDirect(),_loc3_);
                     }
                  }
               }
               break;
            case "hit8":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x + 5;
                        }
                        else
                        {
                           _loc3_.x = this.x - 5;
                        }
                        _loc3_.y = this.y - 60;
                        this.doHit8(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit8",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               if(param1.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     if(this.role2Shalldow)
                     {
                        this.role2Shalldow.setAction("hit3");
                     }
                  }
               }
               this.speed.y = 0;
               break;
            case "hit9":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 55)
                  {
                     if(param1.x == 3)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 20;
                        }
                        else
                        {
                           _loc3_.x = this.x + 20;
                        }
                        _loc3_.y = this.y - 20;
                        this.doHit9_1(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit9_1",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
                  else if(this.bbdc.getCurFrameCount() == 45)
                  {
                     if(param1.x == 3)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 150;
                        }
                        else
                        {
                           _loc3_.x = this.x + 150;
                        }
                        _loc3_.y = this.y - 150;
                        this.doHit9_2(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit9_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               if(param1.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 55)
                  {
                     if(this.role2Shalldow)
                     {
                        this.role2Shalldow.setAction("hit4");
                     }
                  }
               }
         }
      }
      
      private function doHit1(param1:uint, param2:Point, param3:uint) : void
      {
         SoundManager.play("Role2_hit1");
         if(this.sid != gc.sid)
         {
            this.bbdc.setFramePointX(2);
            this.bbdc.resetCurFrameStopCount();
         }
         var _loc4_:SpecialEffectBullet;
         (_loc4_ = new SpecialEffectBullet("Role2Bullet1")).x = param2.x;
         _loc4_.y = param2.y;
         _loc4_.initTimer = param3;
         _loc4_.setRole(this);
         _loc4_.setDirect(param1);
         _loc4_.setAction("hit1");
         gc.gameSence.addChild(_loc4_);
         this.magicBulletArray.push(_loc4_);
      }
      
      private function doHit2(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role2_hit2");
         if(this.sid != gc.sid)
         {
            this.bbdc.setFramePointX(2);
            this.bbdc.resetCurFrameStopCount();
         }
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet2");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit2");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      public function doHit3(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role2_hit3");
         this.setStatic();
         this.setLostGraity();
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet3");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setHurtCanCutDownEffect(false);
         _loc3_.setAction("hit3");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit4_1(param1:uint, param2:Point) : void
      {
         var _loc3_:EnemyMoveBullet = new EnemyMoveBullet("Role2Bullet4_1");
         _loc3_.name = "Role1Bullet4_1";
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         if(param1 == 0)
         {
            _loc3_.setSpeed(-10);
         }
         else
         {
            _loc3_.setSpeed(10);
         }
         _loc3_.setDistance(9999);
         _loc3_.setHurtCanCutDownEffect(true);
         _loc3_.setRole(this);
         _loc3_.setDisable();
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit4");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit4_2(param1:uint, param2:Point) : void
      {
         var direct:uint = param1;
         var p:Point = param2;
         SoundManager.play("Role2_hit4");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet4_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         TweenMax.delayedCall(0.75,function(param1:Role2):*
         {
            param1.resetGraity();
            gc.vControllor.shake(20);
         },[this]);
      }
      
      private function doHit5(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role2_hit5");
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet5");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit5");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      public function doHit6(param1:uint, param2:Point) : void
      {
         var direct:uint = param1;
         var p:Point = param2;
         SoundManager.play("Role2_hit6");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet6");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit6");
         var idx:uint = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(b,idx);
         this.magicBulletArray.push(b);
         TweenMax.delayedCall(0.9,function(param1:BaseBullet, param2:Role2):*
         {
            var _loc4_:BaseHero = null;
            var _loc3_:Array = gc.getPlayerArray();
            for each(_loc4_ in _loc3_)
            {
               if(AUtils.GetDisBetweenTwoObj(_loc4_,param1) < 100)
               {
                  _loc4_.addCurAddEffect([{
                     "name":BaseAddEffect.SLOWLY_ADDHP,
                     "value":0.25 * param2.roleProperies.getHurt(),
                     "time":10 * gc.frameClips
                  }]);
               }
            }
         },[b,this]);
      }
      
      private function doHit7(param1:uint, param2:Point) : void
      {
         var hit7Point:Point = null;
         var bmLen:uint = 0;
         var bo:BaseObject = null;
         var i:uint = 0;
         var direct:uint = param1;
         var p:Point = param2;
         SoundManager.play("Role2_hit7");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet7");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit7");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            hit7Point = new Point();
            if(direct == 0)
            {
               hit7Point.x = this.x - 200;
            }
            else
            {
               hit7Point.x = this.x + 200;
            }
            hit7Point.y = this.y - 20;
            if(gc.sid == this.sid)
            {
               gc.sendAttack(this.getRoleId(),"hit7",this.getBBDC().getDirect(),p.x,p.y,[]);
            }
            if(gc.isInRoom())
            {
               gc.obbsiteArray = gc.pWorld.getOtherHeroArray();
            }
            else
            {
               gc.obbsiteArray = gc.pWorld.monsterArray;
            }
            bmLen = gc.obbsiteArray.length;
            i = 0;
            while(i < bmLen)
            {
               bo = gc.obbsiteArray[i] as BaseObject;
               if(AUtils.GetDisBetweenTwoObj(b,bo) <= 240)
               {
                  bo.setLostGraity();
                  TweenMax.to(bo,0.625,{
                     "x":hit7Point.x,
                     "y":hit7Point.y - 30,
                     "onComplete":function(param1:BaseObject):*
                     {
                        param1.resetGraity();
                        if(!param1.isDead())
                        {
                           TweenMax.to(param1,0.625,{
                              "x":param1.x,
                              "y":param1.y - 10
                           });
                        }
                     },
                     "onCompleteParams":[bo]
                  });
                  if(gc.isInRoom())
                  {
                     gc.sendAttack(bo.getRoleId(),"Role2Hit7",this.getBBDC().getDirect(),hit7Point.x,hit7Point.y,[bo.sid]);
                  }
               }
               i++;
            }
         }
         this.isHit7Ok = true;
      }
      
      public function doHit8(param1:uint, param2:Point) : void
      {
         var b:SpecialEffectBullet = null;
         var direct:uint = param1;
         var p:Point = param2;
         SoundManager.play("Role2_hit8");
         b = new SpecialEffectBullet("Role2Bullet8");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit8");
         var idx:uint = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(b,idx);
         this.magicBulletArray.push(b);
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            TweenMax.delayedCall(1.2,function(param1:SpecialEffectBullet):*
            {
               var _loc4_:BaseHero = null;
               var _loc6_:uint = 0;
               var _loc2_:Array = gc.getPlayerArray();
               var _loc3_:uint = _loc2_.length;
               var _loc5_:uint = 0;
               while(_loc5_ < _loc3_)
               {
                  _loc6_ = (_loc4_ = _loc2_[_loc5_] as BaseHero).roleProperies.getSHHP() * 0.3;
                  if(this.isGXP)
                  {
                     _loc6_ *= 1.5;
                  }
                  if(AUtils.GetDisBetweenTwoObj(_loc4_,b) <= 150)
                  {
                     _loc4_.cureHp(_loc6_);
                  }
                  if(_loc4_.getPet())
                  {
                     if(AUtils.GetDisBetweenTwoObj(_loc4_.getPet(),b) <= 150)
                     {
                        _loc4_.getPet().cureHp(_loc6_);
                     }
                  }
                  _loc5_++;
               }
            },[b]);
         }
      }
      
      public function doHit9_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role2_hit9");
         this.setLostGraity();
         this.setStatic();
         this.speed.y = 0;
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet9_1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setHurtCanCutDownEffect(true);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit9_1");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      public function doHit9_2(param1:uint, param2:Point) : void
      {
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet9_2");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setHurtCanCutDownEffect(true);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit9_2");
         gc.gameSence.addChild(_loc3_);
         var _loc4_:uint = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(_loc3_,_loc4_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit10(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role2_hit10");
         if(!this.role2Shalldow)
         {
            this.role2Shalldow = new Role2Shadow(this);
            this.role2Shalldow.x = param2.x;
            this.role2Shalldow.y = param2.y;
            this.role2Shalldow.setDirect(param1);
            gc.gameSence.addChild(this.role2Shalldow);
            if(gc.sid == this.sid)
            {
               gc.sendAttack(this.getRoleId(),"hit10",param1,param2.x,param2.y,[]);
            }
         }
         else
         {
            this.x = this.role2Shalldow.x;
            this.y = this.role2Shalldow.y;
            this.role2Shalldow.destroy();
            this.role2Shalldow = null;
            if(gc.sid == this.sid)
            {
               gc.sendAttack(this.getRoleId(),"hit10",param1,this.x,this.y,[]);
            }
         }
      }
      
      override public function setOtherAttack(param1:String, param2:uint, param3:Point, param4:Array = null, param5:uint = 0) : void
      {
         switch(param1)
         {
            case "hit1":
               this.doHit1(param2,param3,param5);
               break;
            case "hit2":
               this.doHit2(param2,param3);
               break;
            case "hit3":
               this.doHit3(param2,param3);
               break;
            case "hit4_1":
               this.doHit4_1(param2,param3);
               break;
            case "hit4_2":
               this.doHit4_2(param2,param3);
               break;
            case "hit5":
               this.doHit5(param2,param3);
               break;
            case "hit6":
               this.doHit6(param2,param3);
               break;
            case "hit7":
               this.doHit7(param2,param3);
               break;
            case "hit8":
               this.doHit8(param2,param3);
               break;
            case "hit9_1":
               this.doHit9_1(param2,param3);
               break;
            case "hit9_2":
               this.doHit9_2(param2,param3);
               break;
            case "hit10":
               this.doHit10(param2,param3);
               break;
            case "wushuangStart":
               this.turnToGXP();
               break;
            case "wushuangOver":
               this.turnToNormal();
               break;
            case "Role2Hit7":
               this.beAttackByRole2Hit7(param3);
               break;
            case "Role3Hit6":
               this.beAttackByRole3Hit6(param3);
         }
      }
      
      override public function setOtherBuff(param1:String, param2:Array) : void
      {
         switch(param1)
         {
            case "poison_bomb":
               this.curAddEffect.poison_times_bomb_other();
               break;
            case "Role4_hit6":
               if(this.curAddEffect)
               {
                  this.curAddEffect.add([{
                     "name":BaseAddEffect.POISON_TIMES,
                     "time":gc.frameClips * 7
                  }]);
                  this.curAddEffect.add([{
                     "name":BaseAddEffect.STUN,
                     "time":gc.frameClips * 2
                  }]);
               }
         }
      }
      
      override protected function exitFrameFunc(param1:Point) : void
      {
      }
      
      override public function step() : void
      {
         var _loc1_:Boolean = false;
         super.step();
         if(this.hit2CurrentCount > 0)
         {
            this.exceedPowerSprite.step(this.hit2CurrentCount);
         }
         else if(this.hit5CurrentCount > 0)
         {
            this.exceedPowerSprite.step(this.hit5CurrentCount);
         }
         if(this.hit2CurrentCount == 0 && this.hit5CurrentCount == 0)
         {
            this.exceedPowerSprite.clear();
         }
         if(this.role2Shalldow)
         {
            this.role2Shalldow.step();
         }
         if(this.hit2NeedCount == 48 || this.hit5NeedCount == 48)
         {
            if(this.getPlayer())
            {
               _loc1_ = this.getPlayer().findSkillIsInTheSkillAry("sjt");
               if(_loc1_)
               {
                  this.hit2NeedCount = 12;
                  this.hit5NeedCount = 12;
                  bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,14],[4,4,4,4],[2,2,2,2],[1,1,30,55,8],[2,2,2,2,2],[2,4,12],[2,10,2,40],[2,2],[2,2,6],[24,2,15],[2,2,20],[2,2,10]]);
                  this.exceedPowerSprite.setMaxPower(this.hit2NeedCount);
               }
            }
         }
         else if(this.getPlayer())
         {
            _loc1_ = this.getPlayer().findSkillIsInTheSkillAry("sjt");
            if(!_loc1_)
            {
               this.hit2NeedCount = 48;
               this.hit5NeedCount = 48;
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,14],[4,4,4,4],[2,2,2,2],[1,1,30,55,8],[2,2,2,2,2],[2,4,12],[2,10,2,40],[2,2],[2,2,6],[48,2,15],[2,2,20],[2,2,10]]);
               this.exceedPowerSprite.setMaxPower(this.hit2NeedCount);
            }
         }
      }
      
      override protected function myKeyDown(param1:String) : *
      {
         var keyStr:String = param1;
         super.myKeyDown(keyStr);
         if(cannextaction)
         {
            switch(keyStr)
            {
               case "0010":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  this.jump();
                  cannextaction = false;
                  break;
               case "0100":
               case "1100":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  this.normalHit();
                  cannextaction = false;
                  break;
               case "1010":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  this.getFallDown();
                  cannextaction = false;
                  break;
               case "0110":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  cannextaction = false;
                  break;
               case "0001":
                  gc.pWorld.getBaseLevelListener().keyBoardDownForW(this);
                  if(!gc.isLevelClear && this.checkTransferDoor())
                  {
                     gc.isLevelClear = true;
                     gc.keyboardControl.destroy();
                     TweenMax.to(gc.gameInfo,1,{"alpha":0});
                     TweenMax.to(gc.gameSence,1,{
                        "alpha":0,
                        "onComplete":function():*
                        {
                           gc.eventManger.dispatchEvent(new Event("LevelVictor"));
                           MainGame.getInstance().levelClear();
                        }
                     });
                  }
            }
         }
      }
      
      override protected function showSkill(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         if(this.getPlayer())
         {
            _loc2_ = this.getPlayer().returnSkillNameBySkillKey(param1);
            if(_loc2_)
            {
               param1 = _loc2_[0];
               _loc3_ = parseInt(_loc2_[1]);
               if(param1 == "sgq")
               {
                  this.skill_sgq(_loc3_);
               }
               else if(param1 == "myhc")
               {
                  this.skill_myhc(_loc3_);
               }
               else if(param1 == "jgz")
               {
                  this.skill_jgz(_loc3_);
               }
               else if(param1 == "tjgl")
               {
                  this.skill_tjgl(_loc3_);
               }
               else if(param1 == "jhsj")
               {
                  this.skill_jhsj(_loc3_);
               }
               else if(param1 == "blb")
               {
                  this.skill_blb(_loc3_);
               }
               else if(param1 == "xbz")
               {
                  this.skill_xbz(_loc3_);
               }
               else if(param1 == "shy")
               {
                  this.skill_shy(_loc3_);
               }
               else if(param1 == "smb")
               {
                  this.skill_smb(_loc3_);
               }
            }
         }
      }
      
      private function skill_sgq(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit5");
         this.curAction = "hit5";
         this.hitNum = 0;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_myhc(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit6");
         this.lastHit = "hit6";
         this.newAttackId();
         this.hitNum = 0;
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_jgz(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit7");
         this.curAction = "hit7";
         this.hitNum = 0;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_tjgl(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit8");
         this.lastHit = "hit8";
         this.newAttackId();
         this.hitNum = 0;
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_jhsj(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit9");
         this.curAction = "hit9";
         this.hitNum = 0;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_blb(param1:uint) : void
      {
      }
      
      private function skill_xbz(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit3");
         this.curAction = "hit3";
         this.hitNum = 0;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_shy(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.doHit10(this.getBBDC().getDirect(),new Point(this.x,this.y));
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_smb(param1:uint) : void
      {
         var _loc3_:BaseBullet = null;
         if(!this.isAttacking())
         {
            if(this.roleProperies.getMMP() < param1)
            {
               return;
            }
         }
         if(this.curAction != "hit4_1" && !this.standInObj || this.isAttacking() && this.curAction != "hit4_1" || this.isBeAttacking())
         {
            return;
         }
         var _loc2_:Boolean = false;
         for each(_loc3_ in this.magicBulletArray)
         {
            if(_loc3_.name == "Role1Bullet4_1")
            {
               this.hit4_2Point.x = _loc3_.x;
               this.hit4_2Point.y = _loc3_.y;
               _loc2_ = true;
               break;
            }
         }
         if(!_loc2_)
         {
            this.setAction("hit4_1");
            this.lastHit = "hit4_1";
            this.newAttackId();
            if(this.getPlayer())
            {
               gc.sendPosition(this);
            }
            this.hit4_2Point.x = -99;
            this.hit4_2Point.y = -99;
            this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
         }
         else
         {
            this.setAction("hit4_2");
            this.lastHit = "hit4_2";
            this.newAttackId();
            if(this.getPlayer())
            {
               gc.sendPosition(this);
            }
         }
      }
      
      override protected function showSkillKongGe() : void
      {
         var _loc1_:RoleInfo = gc.gameInfo.getRoleInfoByPlayer(this.player) as RoleInfo;
         if(_loc1_.isGXPReady() && !this.isGXP)
         {
            this.turnToGXP();
            if(this.getPlayer())
            {
               gc.sendPosition(this);
            }
         }
      }
      
      override public function normalHit() : *
      {
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit1");
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.lastHit = "hit1";
         this.hitNum = 0;
         this.newAttackId();
      }
      
      override public function refreshEquip() : void
      {
         var _loc1_:uint = this.getCurClothId();
         var _loc2_:uint = this.getCurWeaponId();
         var _loc3_:Array = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE2_" + _loc1_);
         if(_loc3_)
         {
            this.bbdc.replaceBitmapDataByName("body",_loc3_);
         }
         _loc3_ = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE2_EQUIP_" + _loc2_);
         if(_loc3_)
         {
            this.bbdc.replaceBitmapDataByName("equip",_loc3_);
         }
      }
      
      private function isDefending() : Boolean
      {
         return this.curAction == "hit6";
      }
      
      override public function isNormalHit() : Boolean
      {
         return this.curAction == "hit1";
      }
      
      private function runAttack() : void
      {
         if(!this.isInSky())
         {
            this.doubleCount = 0;
            this.normalHit();
         }
      }
      
      override public function __keyBoardDown(param1:KeyboardEvent) : void
      {
         super.__keyBoardDown(param1);
      }
      
      override public function __keyBoardUp(param1:KeyboardEvent) : void
      {
         super.__keyBoardUp(param1);
      }
      
      override public function upGrade(param1:Boolean = true) : *
      {
         super.upGrade();
         if(!param1)
         {
            this.roleProperies.removeAllEquipAndPassive();
         }
         if(gc.curStage == 0)
         {
            this.roleProperies.setSHHP((50 + 20 * (this.roleProperies.getLevel() - 1)) * 10);
         }
         else
         {
            this.roleProperies.setSHHP(50 + 20 * (this.roleProperies.getLevel() - 1));
         }
         this.roleProperies.setHHP(this.roleProperies.getSHHP());
         this.roleProperies.setSMMP(100 + 40 * (this.roleProperies.getLevel() - 1));
         this.roleProperies.setMMP(this.roleProperies.getSMMP());
         this.roleProperies.setBasePower(12 + 8 * (this.roleProperies.getLevel() - 1));
         this.roleProperies.setDefense(this.roleProperies.getLevel() - 1);
         if(this.roleProperies.getLevel() < 7)
         {
            this.roleProperies.setexp(135 + 10 * (this.roleProperies.getLevel() - 1));
         }
         else if(this.roleProperies.getLevel() < 13)
         {
            this.roleProperies.setexp(625 + 50 * (this.roleProperies.getLevel() - 7));
         }
         else if(this.roleProperies.getLevel() < 19)
         {
            this.roleProperies.setexp(1950 + 100 * (this.roleProperies.getLevel() - 13));
         }
         else
         {
            this.roleProperies.setexp(5000 + 5000 * (this.roleProperies.getLevel() - 19));
         }
         this.roleProperies.initAll();
      }
      
      override public function getRealPower(param1:String, param2:Boolean = true) : int
      {
         var _loc3_:Number = 1;
         if(this.isGXP)
         {
            _loc3_ = 1.5;
         }
         var _loc4_:int = 1;
         if(param2 && Math.random() <= this.roleProperies.getCrit() / 100)
         {
            _loc4_ = 2;
         }
         var _loc5_:Number = 1;
         if(this.isHit7Ok)
         {
            _loc5_ = 1.3;
         }
         var _loc6_:Number = 1;
         var _loc7_:Boolean;
         if(_loc7_ = this.getPlayer().findSkillIsInTheSkillAry("sjt"))
         {
            _loc6_ = 1.3;
         }
         switch(param1)
         {
            case "hit1":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_ * _loc5_;
            case "hit2":
               return 0.2 * this.roleProperies.getHurt() * _loc3_ * _loc4_ * _loc5_ * _loc6_;
            case "hit3":
               return 0.8 * this.roleProperies.getHurt() * _loc3_ * _loc4_ * _loc5_ * _loc6_;
            case "hit4":
               return 8 * this.roleProperies.getHurt() * _loc3_ * _loc4_ * _loc5_ * _loc6_;
            case "hit5":
               return 2 * this.roleProperies.getHurt() * _loc3_ * _loc4_ * _loc5_ * _loc6_;
            case "hit6":
               return 10;
            case "hit7":
               return 10;
            case "hit8":
               return 10;
            case "hit9_1":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_ * _loc5_ * _loc6_;
            case "hit9_2":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_ * _loc5_ * _loc6_;
            case "fabao-sword":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_;
            default:
               return 0;
         }
      }
      
      override public function addHeroHurtMc(param1:int) : void
      {
         var _loc2_:ANumber = new ANumber();
         gc.gameSence.addChild(_loc2_);
         _loc2_.aNumImage("pnum",param1,this.x - 20,this.y - 60,20);
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4_1" || this.curAction == "hit4_2" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9";
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit8";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4_1" || this.curAction == "hit4_2" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit4_1" || this.curAction == "hit4_2" || this.curAction == "hit8" || this.curAction == "hit10" || this.curAction == "hit11_1" || this.curAction == "hit11_2" || this.curAction == "hit13";
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.role2Shalldow)
         {
            this.role2Shalldow.destroy();
            this.role2Shalldow = null;
         }
      }
   }
}
