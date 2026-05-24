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
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.bullet.StabBullet;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import manager.SoundManager;
   import my.ANumber;
   import my.MainGame;
   
   public class Role3 extends BaseHero
   {
       
      
      public function Role3()
      {
         super();
         roleName = "八戒";
         userType = "八戒";
         this.horizenSpeed = 6;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-30,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit6"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,-2],
            "attackInterval":5,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit7_1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-2],
            "attackInterval":4,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit7_2"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-30,-2],
            "attackInterval":gc.frameClips,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit8_1"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[2,-22],
            "attackInterval":2,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit8_2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[10,-4],
            "attackInterval":8,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,-4],
            "attackInterval":7,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-15,-2],
            "attackInterval":7,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit11"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":7,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit12"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-5],
            "attackInterval":7,
            "attackKind":"magic"
         };
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
         var _loc3_:Array = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE3_" + _loc1_);
         var _loc4_:Array = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE3_EQUIP_" + _loc2_);
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
            bbdc = new BaseBitmapDataClip([_loc5_,_loc6_],300,200,new Point(0,0));
            bbdc.setOffsetXY(-15,0);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[3,3,3,9,5,9],[4,4,4,4],[2,2,2,2],[1,1,8,6,2,160],[2,2,2,2,2],[2,2,6],[2,2,6],[2,2,2,10],[24,2,8],[2,2,20],[2,2,2,20],[2,2,2,20],[4,3,25]]);
            bbdc.setFrameCount([36,6,4,4,[1,1,1,1,1,1],5,3,3,4,3,3,4,4,3]);
            bbdc.setEnterFrameCallBack(this.enterFrameFunc,this.exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(this.scriptFrameOverFunc);
            this.body.addChild(bbdc);
            this.bbdc.turnRight();
            return;
         }
         throw new Error("ROLE3--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(param1:String) : void
      {
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
            case "hit2":
               if(_loc2_.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(param1);
               break;
            case "hit3":
               if(_loc2_.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(param1);
               break;
            case "hit4":
               if(_loc2_.y != 9)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(9);
               }
               this.bbdc.setState(param1);
               break;
            case "hit5":
               if(_loc2_.x != 5 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hit6":
               if(_loc2_.x != 3 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hit7":
               if(_loc2_.y != 10)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(10);
               }
               this.bbdc.setState(param1);
               break;
            case "hit8":
               if(_loc2_.y != 11)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(11);
               }
               this.bbdc.setState(param1);
               break;
            case "hit9":
               if(_loc2_.y != 12)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(param1);
               break;
            case "hit10":
               if(_loc2_.y != 13)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(13);
               }
               this.bbdc.setState(param1);
               break;
            case "hit11":
               if(_loc2_.x != 4 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(4);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hit11Frame2":
               if(_loc2_.x != 5 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hit12":
               if(_loc2_.x != 5 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hurt":
               if(_loc2_.x != 2 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(2);
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
            case "wait":
               this.setAction("wait2");
               break;
            case "wait2":
               this.setAction("wait");
               break;
            case "walk":
               this.bbdc.setFramePointX(0);
               break;
            case "run":
               this.bbdc.setFramePointX(0);
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
            case "hit2":
               this.setAction("wait");
               break;
            case "hit3":
               this.setAction("wait");
               break;
            case "hit4":
               this.setAction("wait");
               break;
            case "hit5":
               this.setAction("wait");
               break;
            case "hit6":
               this.setAction("wait");
               break;
            case "hit7":
               this.setAction("wait");
               break;
            case "hit8":
               this.setAction("wait");
               break;
            case "hit9":
               this.setAction("wait");
               break;
            case "hit10":
               this.setStatic();
               this.setAction("wait");
               break;
            case "hit11":
               this.setAction("hit11Frame2");
               break;
            case "hit11Frame2":
               this.getBBDC().show();
               this.setAction("wait");
               break;
            case "hit12":
               this.lastHit = "";
               this.getBBDC().show();
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.getBBDC().show();
               this.setAction("wait");
         }
      }
      
      override protected function enterFrameFunc(param1:Point) : void
      {
         var _loc2_:String = this.bbdc.getState();
         var _loc3_:Point = new Point();
         switch(_loc2_)
         {
            case "hit1":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(param1.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 130;
                        }
                        else
                        {
                           _loc3_.x = this.x + 130;
                        }
                        _loc3_.y = this.y - 72;
                        this.doHit1(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit1",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit2":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(param1.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 140;
                        }
                        else
                        {
                           _loc3_.x = this.x + 140;
                        }
                        _loc3_.y = this.y - 30;
                        this.doHit2(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
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
                           _loc3_.x = this.x - 180;
                        }
                        else
                        {
                           _loc3_.x = this.x + 180;
                        }
                        _loc3_.y = this.y - 140;
                        this.doHit3(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit3",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit4":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 24)
                  {
                     if(param1.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 35;
                        }
                        else
                        {
                           _loc3_.x = this.x + 35;
                        }
                        _loc3_.y = this.y - 55;
                        this.doHit4(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit4",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit5":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 160)
                  {
                     if(param1.x == 5)
                     {
                        this.bbdc.setCurFrameCount(4);
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 70;
                        }
                        else
                        {
                           _loc3_.x = this.x + 70;
                        }
                        _loc3_.y = this.y - 110;
                        this.doHit5(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit5",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit6":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 6)
                  {
                     if(param1.x == 3)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 120;
                        }
                        else
                        {
                           _loc3_.x = this.x + 120;
                        }
                        _loc3_.y = this.y - 115;
                        this.doHit6(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit6",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit7":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 140;
                        }
                        else
                        {
                           _loc3_.x = this.x + 140;
                        }
                        _loc3_.y = this.y - 160;
                        this.doHit7_1(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit7_1",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
                  if(this.bbdc.getCurFrameCount() == 8)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 135;
                        }
                        else
                        {
                           _loc3_.x = this.x + 135;
                        }
                        _loc3_.y = this.y - 145;
                        this.doHit7_2(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit7_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit8":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     if(param1.x == 3)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 95;
                        }
                        else
                        {
                           _loc3_.x = this.x + 95;
                        }
                        _loc3_.y = this.y;
                        this.doHit8_1(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit8_1",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x + 20;
                        }
                        else
                        {
                           _loc3_.x = this.x - 20;
                        }
                        _loc3_.y = this.y - 20;
                        this.doHit8_2(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit8_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit9":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     if(param1.x == 3)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 195;
                        }
                        else
                        {
                           _loc3_.x = this.x + 195;
                        }
                        _loc3_.y = this.y - 160;
                        this.doHit9(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit9",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit10":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 25)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 55;
                        }
                        else
                        {
                           _loc3_.x = this.x + 55;
                        }
                        _loc3_.y = this.y - 25;
                        this.doHit10(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit10",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               if(param1.x == 2)
               {
                  if(this.getBBDC().getDirect() == 0)
                  {
                     this.speed.x = -15;
                  }
                  else
                  {
                     this.speed.x = 15;
                  }
               }
               break;
            case "hit11Frame2":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 160)
                  {
                     if(param1.x == 5)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 135;
                        }
                        else
                        {
                           _loc3_.x = this.x + 135;
                        }
                        _loc3_.y = this.y - 90;
                        this.doHit11(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit11Frame2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        this.bbdc.setCurFrameCount(28);
                     }
                  }
               }
               this.getBBDC().hide();
               break;
            case "hit12":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 160)
                  {
                     if(param1.x == 5)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x;
                        }
                        else
                        {
                           _loc3_.x = this.x;
                        }
                        _loc3_.y = this.y;
                        this.doHit12_1(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit12_1",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
                  else if(this.bbdc.getCurFrameCount() == 150)
                  {
                     this.getBBDC().hide();
                  }
               }
         }
      }
      
      private function doHit1(param1:uint, param2:Point) : void
      {
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit1");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit2(param1:uint, param2:Point) : void
      {
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet2");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit2");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit3(param1:uint, param2:Point) : void
      {
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet3");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit3");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit4(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role3_hit4");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet4");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit4");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit5(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role3_hit5");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet5");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDisable();
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit5");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
         if(this.curAddEffect)
         {
            this.curAddEffect.add([{
               "name":BaseAddEffect.BAJIE_DUNPAI_BUFF,
               "time":gc.frameClips * 10
            }]);
         }
      }
      
      private function doHit6(param1:uint, param2:Point) : void
      {
         var bmLen:uint = 0;
         var bo:BaseObject = null;
         var i:uint = 0;
         var direct:uint = param1;
         var p:Point = param2;
         SoundManager.play("Role3_hit6");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet6");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit6");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            bmLen = gc.obbsiteArray.length;
            i = 0;
            while(i < bmLen)
            {
               bo = gc.obbsiteArray[i] as BaseObject;
               bo.setLostGraity();
               TweenMax.to(bo,1,{
                  "x":this.x,
                  "y":this.y - 40,
                  "onComplete":function(param1:BaseObject):*
                  {
                     param1.resetGraity();
                  },
                  "onCompleteParams":[bo]
               });
               if(gc.isInRoom())
               {
                  gc.sendAttack(bo.getRoleId(),"Role3Hit6",this.getBBDC().getDirect(),this.x,this.y - 80,[bo.sid]);
               }
               i++;
            }
         }
      }
      
      private function doHit7_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role3_hit7");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet7_1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDisable();
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit7_1");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit7_2(param1:uint, param2:Point) : void
      {
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role3Bullet7_2");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit7_2");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit8_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role3_hit8");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet8_1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDisable();
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit8_1");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit8_2(param1:uint, param2:Point) : void
      {
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role3Bullet8_2");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit8_2");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit9(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role3_hit9");
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role3Bullet9");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit9");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit10(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role3_hit10");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet10");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit10");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit11(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role3_hit11");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet11");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit11");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit12_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role3_hit12_1");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet12_1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDisable();
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit12");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit12_2(param1:*, param2:*, param3:Point = null, param4:uint = 10) : void
      {
         var _loc5_:BaseBullet = null;
         var _loc6_:StabBullet = null;
         var _loc7_:Point = null;
         var _loc9_:BaseObject = null;
         var _loc10_:Number = NaN;
         SoundManager.play("Role3_hit12_2");
         for each(_loc5_ in this.magicBulletArray)
         {
            if(_loc5_.getImcName() == "Role3Bullet12_1")
            {
               if(_loc5_.getImgMc())
               {
                  _loc5_.getImgMc().gotoAndPlay(140);
               }
            }
         }
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            param4 = 10;
            if(this.isGXP)
            {
               param4 = 20;
            }
            param3 = !!(_loc9_ = gc.obbsiteArray[int(Math.random() * gc.obbsiteArray.length)] as BaseObject) ? new Point(_loc9_.x,_loc9_.y) : new Point(this.x + 1,this.y + 300);
         }
         else
         {
            param3 = !!param3 ? param3 : new Point(this.x + 1,this.y + 300);
         }
         var _loc8_:int = 0;
         while(_loc8_ < param4)
         {
            _loc10_ = 360 / param4 * _loc8_;
            _loc7_ = new Point(param2.x + Math.sin(_loc10_ * Math.PI / 180) * 100,param2.y - Math.cos(_loc10_ * Math.PI / 180) * 100);
            (_loc6_ = new StabBullet("Role3Bullet12_2",param3,1,_loc7_)).setRole(this);
            _loc6_.setDestroyWhenLastFrame(false);
            _loc6_.setAction("hit12");
            _loc6_.rotation = _loc10_;
            _loc6_.x = _loc7_.x;
            _loc6_.y = _loc7_.y;
            gc.gameSence.addChild(_loc6_);
            this.magicBulletArray.push(_loc6_);
            _loc8_++;
         }
         if(gc.sid == this.sid)
         {
            gc.sendAttack(this.getRoleId(),"hit12_2",this.getBBDC().getDirect(),this.x,this.y,[param3.x,param3.y,param4]);
         }
      }
      
      override public function setOtherAttack(param1:String, param2:uint, param3:Point, param4:Array = null, param5:uint = 0) : void
      {
         var _loc6_:Point = null;
         var _loc7_:uint = 0;
         switch(param1)
         {
            case "hit1":
               this.doHit1(param2,param3);
               break;
            case "hit2":
               this.doHit2(param2,param3);
               break;
            case "hit3":
               this.doHit3(param2,param3);
               break;
            case "hit4":
               this.doHit4(param2,param3);
               break;
            case "hit5":
               this.doHit5(param2,param3);
               break;
            case "hit6":
               this.doHit6(param2,param3);
               break;
            case "hit7_1":
               this.doHit7_1(param2,param3);
               break;
            case "hit7_2":
               this.doHit7_2(param2,param3);
               break;
            case "hit8_1":
               this.doHit8_1(param2,param3);
               break;
            case "hit8_2":
               this.doHit8_2(param2,param3);
               break;
            case "hit9":
               this.doHit9(param2,param3);
               break;
            case "hit10":
               this.doHit10(param2,param3);
               break;
            case "hit11Frame2":
               this.doHit11(param2,param3);
               break;
            case "hit12_1":
               this.doHit12_1(param2,param3);
               break;
            case "hit12_2":
               _loc6_ = new Point(parseInt(param4[0]),parseInt(param4[1]));
               _loc7_ = parseInt(param4[2]);
               this.doHit12_2(param2,param3,_loc6_,_loc7_);
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
         super.step();
      }
      
      override public function reduceHp(param1:int, param2:Boolean = false) : void
      {
         if(this.curAddEffect && this.curAddEffect.curDebuff(BaseAddEffect.BAJIE_DUNPAI_BUFF) || this.curAction == "hit12")
         {
            param2 = false;
         }
         if(this.isGXP)
         {
            param1 *= 0.5;
         }
         super.reduceHp(param1,param2);
      }
      
      override public function setAttackBack(param1:Point) : void
      {
         if(!(this.curAddEffect && this.curAddEffect.curDebuff(BaseAddEffect.BAJIE_DUNPAI_BUFF) || this.curAction == "hit12"))
         {
            super.setAttackBack(param1);
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
               case "0101":
                  if(this.getPlayer().isstudyskill[3] != 1)
                  {
                     return;
                  }
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  if(this.roleProperies.getMMP() >= 20)
                  {
                     SoundManager.play("Role3_hit6");
                     this.lastHit = "hit8";
                     this.curAction = "hit8";
                     this.hitNum = 0;
                     this.timers = 40;
                     this.newAttackId();
                     this.roleProperies.setMMP(this.roleProperies.getMMP() - 20);
                  }
                  else
                  {
                     this.normalHit();
                     cannextaction = false;
                  }
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
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         if(this.getPlayer())
         {
            _loc2_ = ["Y","U","I","O","L"];
            _loc3_ = this.getPlayer().returnSkillNameBySkillKey(param1);
            if(_loc3_)
            {
               param1 = _loc3_[0];
               _loc4_ = parseInt(_loc3_[1]);
               if(param1 == "dj")
               {
                  this.skill_dj(_loc4_);
               }
               else if(param1 == "sd")
               {
                  this.skill_sd(_loc4_);
               }
               else if(param1 == "zznh")
               {
                  this.skill_zznh(_loc4_);
               }
               else if(param1 == "syzq")
               {
                  this.skill_syzq(_loc4_);
               }
               else if(param1 == "ssp")
               {
                  this.skill_ssp(_loc4_);
               }
               else if(param1 == "jsp")
               {
                  this.skill_jsp(_loc4_);
               }
               else if(param1 == "dgq")
               {
                  this.skill_dgq(_loc4_);
               }
               else if(param1 == "xgq")
               {
                  this.skill_xgq(_loc4_);
               }
               else if(param1 == "tmc")
               {
                  this.skill_tmc(_loc4_);
               }
            }
         }
      }
      
      private function skill_dj(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit4";
         this.setAction("hit4");
         this.hitNum = 0;
         this.newAttackId();
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_sd(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit5";
         this.setAction("hit5");
         this.newAttackId();
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_zznh(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit6";
         this.setAction("hit6");
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_syzq(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit7";
         this.setAction("hit7");
         this.hitNum = 0;
         this.newAttackId();
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_ssp(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isInSky())
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit8";
         this.setAction("hit8");
         this.hitNum = 0;
         this.newAttackId();
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_jsp(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isInSky())
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit9";
         this.setAction("hit9");
         this.hitNum = 0;
         this.newAttackId();
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_dgq(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit10";
         this.setAction("hit10");
         this.newAttackId();
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_xgq(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit11";
         this.setAction("hit11");
         this.newAttackId();
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_tmc(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() && this.curAction != "hit12" || this.isBeAttacking())
         {
            return;
         }
         if(this.lastHit == "hit12" && this.getBBDC().getCurFrameCount() <= 130)
         {
            this.lastHit = "hit12_2";
            this.getBBDC().setCurFrameCount(20);
            this.doHit12_2(this.getBBDC().getDirect(),new Point(this.x,this.y));
            this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
         }
         else if(this.lastHit != "hit12_2" && this.lastHit != "hit12")
         {
            this.lastHit = "hit12";
            this.setAction("hit12");
            this.hitNum = 0;
            if(gc.sid == this.sid)
            {
               gc.sendPosition(this);
            }
            this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
         }
      }
      
      override protected function showSkillKongGe() : void
      {
         var _loc1_:RoleInfo = gc.gameInfo.getRoleInfoByPlayer(this.player) as RoleInfo;
         if(_loc1_.isGXPReady() && !this.isGXP)
         {
            this.turnToGXP();
         }
      }
      
      override public function normalHit() : *
      {
         this.curtime = getTimer();
         if(this.timers <= 0)
         {
            if(!this.isInSky())
            {
               if(!this.isRunning() && (!this.isAttacking() || this.isNormalHit()))
               {
                  this.timers = 13;
                  if(this.curtime - this.lasttime > 1500)
                  {
                     this.hitNum = 1;
                  }
                  else if(++this.hitNum > 3)
                  {
                     this.hitNum = 1;
                  }
                  SoundManager.play("Role3_hit" + this.hitNum);
                  if(this.hitNum == 1)
                  {
                     this.setAction("hit2");
                     this.lastHit = "hit2";
                  }
                  else if(this.hitNum == 2)
                  {
                     this.setAction("hit1");
                     this.lastHit = "hit1";
                  }
                  else if(this.hitNum == 3)
                  {
                     this.lastHit = "hit3";
                     this.setAction("hit3");
                  }
                  if(this.getPlayer())
                  {
                     gc.sendPosition(this);
                  }
                  this.newAttackId();
               }
               else if(this.isRunning() && !this.isAttacking())
               {
                  this.doubleCount = 0;
                  this.normalHit();
               }
            }
            else
            {
               this.timers = 15;
               this.setAction("hit1");
               if(this.getPlayer())
               {
                  gc.sendPosition(this);
               }
               this.lastHit = "hit1";
               this.hitNum = 0;
               SoundManager.play("Role3_hit3");
               this.newAttackId();
            }
         }
         this.lasttime = this.curtime;
      }
      
      override public function refreshEquip() : void
      {
         var _loc1_:uint = this.getCurClothId();
         var _loc2_:uint = this.getCurWeaponId();
         var _loc3_:Array = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE3_" + _loc1_);
         if(_loc3_)
         {
            this.bbdc.replaceBitmapDataByName("body",_loc3_);
         }
         _loc3_ = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE3_EQUIP_" + _loc2_);
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
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
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
            this.roleProperies.setSHHP((100 + 70 * (this.roleProperies.getLevel() - 1)) * 10);
         }
         else
         {
            this.roleProperies.setSHHP(100 + 70 * (this.roleProperies.getLevel() - 1));
         }
         this.roleProperies.setHHP(this.roleProperies.getSHHP());
         this.roleProperies.setSMMP(35 + 15 * (this.roleProperies.getLevel() - 1));
         this.roleProperies.setMMP(this.roleProperies.getSMMP());
         this.roleProperies.setBasePower(20 + 6 * (this.roleProperies.getLevel() - 1));
         this.roleProperies.setDefense(4 + (this.roleProperies.getLevel() - 1));
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
         switch(param1)
         {
            case "hit1":
            case "hit2":
            case "hit3":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit4":
               return 2 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit5":
               return 0;
            case "hit6":
               return 0;
            case "hit7_1":
               return 0;
            case "hit7_2":
               return 2 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit8_1":
               return 0;
            case "hit8_2":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit9":
               return 1.5 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit10":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit11":
               return 3 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit12":
               return 0.5 * this.roleProperies.getHurt() * _loc3_ * _loc4_ + this.roleProperies.getSHHP() * 0.03;
            case "fabao-sword":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_;
            default:
               return 0;
         }
      }
      
      override public function addHeroHurtMc(param1:int) : void
      {
         if(this.isGXP)
         {
            param1 /= 2;
         }
         var _loc2_:ANumber = new ANumber();
         gc.gameSence.addChild(_loc2_);
         _loc2_.aNumImage("pnum",param1,this.x - 20,this.y - 60,20);
      }
      
      private function isAttackingButCanAttack() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3";
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" && gc.protectedPerproty.getProperty(this,"jumpCount") == 0 || this.curAction == "hit4" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit5" || this.curAction == "hit10";
      }
   }
}
