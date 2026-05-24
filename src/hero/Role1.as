package export.hero
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import com.hexagonstar.util.debug.Debug;
   import export.RoleInfo;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import manager.SoundManager;
   import my.MainGame;
   
   public class Role1 extends BaseHero
   {
       
      
      private var hit11Count:uint = 35;
      
      private var shallowArray:Array;
      
      public function Role1()
      {
         this.shallowArray = [];
         super();
         roleName = "悟空";
         userType = "悟空";
         this.horizenSpeed = 6;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-2,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[-0.5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[-0.5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-8,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-15,-2],
            "attackInterval":999,
            "attackKind":"physics"
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
         this.attackBackInfoDict["hit9"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10_2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-2,-2],
            "attackInterval":5,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit10_3"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,20],
            "attackInterval":5,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10_4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,-15],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit11_1"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-20,0],
            "attackInterval":5,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit11_2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-25],
            "attackInterval":5,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit12"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":5,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit13"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit14"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-20,0],
            "attackInterval":999,
            "attackKind":"physics"
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
         Debug.trace("weaponId:" + _loc2_);
         var _loc3_:Array = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE1_" + _loc1_);
         var _loc4_:Array = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE1_EQUIP_" + _loc2_);
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
            bbdc.setOffsetXY(5,-15);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[5,5],[4,4,4,4],[2,2,2,2],[1,1,10,100,this.hit11Count,this.hit11Count],[2,2,2,2,2],[2,2,1,1,3],[1,1,1,1,5],[1,1,1,1,12],[2,2,1,1,10],[2,2,1,6],[2,3,2,3],[17,15,8,10],[2,12,16]]);
            bbdc.setFrameCount([36,8,4,4,[1,1,1,1,1,1],5,5,5,5,5,4,4,[1,1,1,1],3]);
            bbdc.setEnterFrameCallBack(this.enterFrameFunc,this.exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(this.scriptFrameOverFunc);
            this.body.addChild(bbdc);
            this.bbdc.turnRight();
            return;
         }
         throw new Error("ROLE1--BitmapData Error!");
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
         if(param1 != "hit14")
         {
            this.bbdc.setOffsetXY(5,-15);
         }
         else
         {
            this.bbdc.setOffsetXY(5,-30);
         }
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
            case "hit4":
               if(_loc2_.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(param1);
               break;
            case "hit5":
               if(_loc2_.y != 9)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(9);
               }
               this.bbdc.setState(param1);
               break;
            case "hit6":
               if(_loc2_.y != 10)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(10);
               }
               this.bbdc.setState(param1);
               break;
            case "hit7":
               if(_loc2_.x != 1 || _loc2_.y != 12)
               {
                  this.bbdc.setFramePointX(1);
                  this.bbdc.setFramePointY(12);
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
               if(_loc2_.x != 2 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(2);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hit10":
               if(_loc2_.x != 3 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hit11_1":
               if(_loc2_.x != 4 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(4);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hit11_2":
               if(_loc2_.x != 5 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hit12":
               if(_loc2_.x != 0 || _loc2_.y != 12)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(param1);
               break;
            case "hit13":
               if(_loc2_.x != 3 || _loc2_.y != 12)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(param1);
               break;
            case "hit14":
               if(_loc2_.x != 0 || _loc2_.y != 13)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(13);
               }
               this.bbdc.setState(param1);
               break;
            case "hurt":
               this.getBBDC().show();
               this.resetGraity();
               if(_loc2_.x == 2 && _loc2_.y == 12)
               {
                  this.getBBDC().resetCurFrameStopCount();
               }
               else
               {
                  this.bbdc.setFramePointX(2);
                  this.bbdc.setFramePointY(12);
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
            case "hit2":
               this.setAction("wait");
               break;
            case "hit3":
               this.setAction("wait");
               break;
            case "hit4":
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
               this.getBBDC().show();
               this.setSpeedStaticOnly();
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit10":
               this.hit10Over();
               break;
            case "hit11_1":
               this.hit11Over();
               break;
            case "hit11_2":
               this.hit11Over();
               break;
            case "hit12":
               this.setAction("wait");
               break;
            case "hit13":
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit14":
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
         }
      }
      
      override protected function enterFrameFunc(param1:Point) : void
      {
         var _loc4_:Role1Shadow = null;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc2_:String = this.bbdc.getState();
         var _loc3_:Point = new Point();
         switch(_loc2_)
         {
            case "hit1":
            case "hit2":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 120;
                        }
                        else
                        {
                           _loc3_.x = this.x + 120;
                        }
                        _loc3_.y = this.y + 5;
                        this.doHit1(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit1",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit3":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(param1.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 30;
                        }
                        else
                        {
                           _loc3_.x = this.x + 30;
                        }
                        _loc3_.y = this.y - 110;
                        this.doHit3(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit3",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit4":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(param1.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 160;
                        }
                        else
                        {
                           _loc3_.x = this.x + 160;
                        }
                        _loc3_.y = this.y - 10;
                        this.doHit4(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit4",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit5":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 165;
                        }
                        else
                        {
                           _loc3_.x = this.x + 165;
                        }
                        _loc3_.y = this.y - 20;
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
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(param1.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 30;
                        }
                        else
                        {
                           _loc3_.x = this.x + 30;
                        }
                        _loc3_.y = this.y + 40;
                        this.doHit6(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit6",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit7":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 15)
                  {
                     if(param1.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 175;
                        }
                        else
                        {
                           _loc3_.x = this.x + 175;
                        }
                        _loc3_.y = this.y - 30;
                        this.doHit7(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit7",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               if(this.bbdc.getDirect() == 0)
               {
                  this.speed.x = -25 * this.bbdc.getCurFrameCount() / 15;
               }
               else
               {
                  this.speed.x = 25 * this.bbdc.getCurFrameCount() / 15;
               }
               break;
            case "hit8":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(param1.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x + 20;
                        }
                        else
                        {
                           _loc3_.x = this.x - 20;
                        }
                        _loc3_.y = this.y + 30;
                        this.doHit8(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit8",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(param1.x == 0)
                  {
                     for each(_loc4_ in this.shallowArray)
                     {
                        if(_loc4_)
                        {
                           if(!_loc4_.isReadyToDestroy)
                           {
                              _loc4_.setAction("hit1");
                           }
                        }
                     }
                  }
               }
               break;
            case "hit9":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 120;
                        }
                        else
                        {
                           _loc3_.x = this.x + 120;
                        }
                        _loc3_.y = this.y - 50;
                        this.doHit9(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit9",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit10":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 100)
                  {
                     if(param1.x == 3)
                     {
                        _loc3_ = new Point(0,0);
                        this.doHit10_1(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit10_1",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
                  else if(this.bbdc.getCurFrameCount() == 95)
                  {
                     if(param1.x == 3)
                     {
                        _loc3_ = new Point(this.x - 10,this.y);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit10_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                        this.doHit10_2(this.getBBDC().getDirect(),_loc3_);
                     }
                  }
               }
               if(this.lastHit == "hit10_3")
               {
                  if(this.standInObj)
                  {
                     if(gc.sid == this.sid)
                     {
                        gc.sendAttack(this.getRoleId(),"hit10_4",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                     this.doHit10_4(this.getBBDC().getDirect(),_loc3_);
                  }
               }
               break;
            case "hit11_1":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == this.hit11Count)
                  {
                     if(param1.x == 4)
                     {
                        this.doHit11_1(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit11_1",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit11_2":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  _loc6_ = (_loc5_ = this.bbdc.getFrameStopCount())[4][5];
                  if(this.bbdc.getCurFrameCount() == _loc6_)
                  {
                     if(param1.x == 5)
                     {
                        this.doHit11_2(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendPositionAndDirect(this);
                           gc.sendAttack(this.getRoleId(),"hit11_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit12":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 17)
                  {
                     if(param1.x == 0)
                     {
                        this.doHit12_1(this.getBBDC().getDirect(),_loc3_);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit12_1",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
                  else if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(param1.x == 0)
                     {
                        if(gc.sid == this.sid || gc.isSingleGame())
                        {
                           this.doHit12_2(this.getBBDC().getDirect(),_loc3_);
                        }
                     }
                  }
               }
               break;
            case "hit13":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(param1.x == 3)
                  {
                     _loc3_.x = this.x;
                     _loc3_.y = this.y;
                     this.checkHit13(this.getBBDC().getDirect(),_loc3_);
                     if(gc.sid == this.sid)
                     {
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit13Check",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit14":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(param1.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x;
                        }
                        else
                        {
                           _loc3_.x = this.x;
                        }
                        _loc3_.y = this.y - 85;
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit14_1",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                        this.doHit14_1(this.getBBDC().getDirect(),_loc3_);
                     }
                  }
                  else if(this.bbdc.getCurFrameCount() == 16)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 145;
                        }
                        else
                        {
                           _loc3_.x = this.x + 145;
                        }
                        _loc3_.y = this.y - 60;
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit14_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                        this.doHit14_2(this.getBBDC().getDirect(),_loc3_);
                     }
                  }
               }
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(param1.x == 0)
                  {
                     for each(_loc4_ in this.shallowArray)
                     {
                        if(_loc4_)
                        {
                           if(!_loc4_.isReadyToDestroy)
                           {
                              _loc4_.setAction("hit2");
                           }
                        }
                     }
                  }
               }
               this.speed.y = 0;
         }
      }
      
      private function doHit1(param1:uint, param2:Point) : void
      {
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit1");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit3(param1:uint, param2:Point) : void
      {
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet3");
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
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet4");
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
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet5");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit5");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit6(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role1_hit6");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet6");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit6");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit7(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role1_hit7");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet7");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit7");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      public function doHit8(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role1_hit8");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet8");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit8");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit9(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role1_hit9");
         this.getBBDC().hide();
         this.setYourFather(11);
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet9");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit9");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
         if(this.bbdc.getDirect() == 0)
         {
            this.speed.x = -40;
         }
         else
         {
            this.speed.x = 40;
         }
      }
      
      private function doHit10_1(param1:uint, param2:Point) : void
      {
         if(this.bbdc.getDirect() == 0)
         {
            this.speed.x = -28;
         }
         else
         {
            this.speed.x = 28;
         }
         this.speed.y = -35;
         this.setYourFather(5);
      }
      
      private function doHit10_2(param1:uint, param2:Point) : void
      {
         var bm:BaseObject = null;
         var b:SpecialEffectBullet = null;
         var direct:uint = param1;
         var p:Point = param2;
         SoundManager.play("Role1_hit10_2");
         this.setStatic();
         this.speed.y = 0;
         this.setLostGraity();
         this.getBBDC().hide();
         if(gc.isInRoom())
         {
            gc.obbsiteArray = gc.pWorld.getOtherHeroArray();
         }
         else
         {
            gc.obbsiteArray = gc.pWorld.monsterArray;
         }
         var bmLen:uint = gc.obbsiteArray.length;
         var i:uint = 0;
         while(i < bmLen)
         {
            bm = gc.obbsiteArray[i] as BaseObject;
            if(AUtils.GetDisBetweenTwoObj(this,bm) < 100)
            {
               this.setYourFather(45);
               b = new SpecialEffectBullet("Role1Bullet10_2");
               b.x = p.x;
               b.y = p.y;
               b.setRole(this);
               b.setDirect(direct);
               b.setAction("hit10_2");
               this.lastHit = "hit10_2";
               gc.gameSence.addChild(b);
               this.magicBulletArray.push(b);
               TweenMax.delayedCall(1.9,function(param1:Role1, param2:uint, param3:Point):*
               {
                  if(gc.sid == param1.sid)
                  {
                     gc.sendAttack(param1.getRoleId(),"hit10_3",param1.getBBDC().getDirect(),param3.x,param3.y,[]);
                  }
                  param1.doHit10_3(param2,param3);
               },[this,direct,p]);
               return;
            }
            i++;
         }
         this.doHit10_3(direct,p);
         if(gc.sid == this.sid)
         {
            gc.sendAttack(this.getRoleId(),"hit10_3",this.getBBDC().getDirect(),p.x,p.y,[]);
         }
      }
      
      private function doHit10_3(param1:uint, param2:Point) : void
      {
         this.setYourFather(80);
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet10_3");
         _loc3_.x = this.x;
         _loc3_.y = this.y - 40;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit10_3");
         this.lastHit = "hit10_3";
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
         this.setYourFather(60);
         this.resetGraity();
         if(this.bbdc.getDirect() == 0)
         {
            this.speed.x = -40;
         }
         else
         {
            this.speed.x = 40;
         }
         this.speed.y = 40;
      }
      
      private function doHit10_4(param1:uint, param2:Point) : void
      {
         var direct:uint = param1;
         var p:Point = param2;
         SoundManager.play("Role1_hit10_4");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet10_4");
         b.x = this.x;
         b.y = this.y + 40;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit10_4");
         this.lastHit = "hit10_4";
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         gc.vControllor.shake(25);
         this.setStatic();
         this.setYourFather(10);
         TweenMax.delayedCall(0.45,function(param1:Role1):*
         {
            param1.hit10Over();
         },[this]);
      }
      
      private function hit10Over() : void
      {
         this.getBBDC().show();
         this.setAction("wait");
      }
      
      private function hit11Over() : *
      {
         var _loc1_:BaseBullet = null;
         for each(_loc1_ in this.magicBulletArray)
         {
            if(_loc1_.getImcName() == "Role1Bullet11_1" || _loc1_.getImcName() == "Role1Bullet11_2")
            {
               _loc1_.destroy();
            }
         }
         this.resetGraity();
         this.speed.y = 0;
         if(!this.isInSky())
         {
            this.setAction("wait");
         }
         else
         {
            this.setAction("jump3");
         }
      }
      
      private function doHit11_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role1_hit11");
         if(this.bbdc.getDirect() == 0)
         {
            this.speed.x = -25;
         }
         else
         {
            this.speed.x = 25;
         }
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet11_1");
         if(this.bbdc.getDirect() == 0)
         {
            _loc3_.x = this.x - 50;
         }
         else
         {
            _loc3_.x = this.x + 50;
         }
         _loc3_.y = this.y - 50;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit11_1");
         this.lastHit = "hit11_1";
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit11_2(param1:uint, param2:Point) : void
      {
         var _loc3_:BaseBullet = null;
         var _loc4_:FollowBaseObjectBullet = null;
         SoundManager.play("Role1_hit11");
         this.speed.x = 0;
         this.speed.y = -25;
         this.setLostGraity();
         for each(_loc3_ in this.magicBulletArray)
         {
            if(_loc3_.getImcName() == "Role1Bullet11_1")
            {
               _loc3_.destroy();
            }
         }
         _loc4_ = new FollowBaseObjectBullet("Role1Bullet11_2");
         if(this.bbdc.getDirect() == 0)
         {
            _loc4_.x = this.x;
         }
         else
         {
            _loc4_.x = this.x;
         }
         _loc4_.y = this.y - 50;
         _loc4_.setRole(this);
         _loc4_.setDirect(param1);
         _loc4_.setAction("hit11_2");
         this.lastHit = "hit11_2";
         gc.gameSence.addChild(_loc4_);
         this.magicBulletArray.push(_loc4_);
      }
      
      private function doHit12_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role1_hit12_1");
         var _loc3_:MovieClip = AUtils.getNewObj("Role1Bullet12_1_1") as MovieClip;
         var _loc4_:MovieClip = AUtils.getNewObj("Role1Bullet12_1_2") as MovieClip;
         if(this.bbdc.getDirect() == 0)
         {
            _loc3_.x = this.x - 22;
         }
         else
         {
            _loc3_.x = this.x + 21;
            AUtils.flipHorizontal(_loc3_,-1);
         }
         _loc3_.y = this.y - 10;
         if(this.bbdc.getDirect() == 0)
         {
            _loc4_.x = this.x - 55;
         }
         else
         {
            _loc4_.x = this.x - 65;
         }
         _loc4_.y = this.y;
         gc.gameSence.addChild(_loc3_);
         gc.gameSence.addChild(_loc4_);
      }
      
      private function doHit12_2(param1:uint, param2:Point) : void
      {
         var _loc3_:BaseObject = null;
         var _loc4_:BaseObject = null;
         var _loc5_:Number = 9999;
         if(gc.isInRoom())
         {
            gc.obbsiteArray = gc.pWorld.getOtherHeroArray();
         }
         else
         {
            gc.obbsiteArray = gc.pWorld.monsterArray;
         }
         var _loc6_:uint = gc.obbsiteArray.length;
         var _loc7_:uint = 0;
         for(; _loc7_ < _loc6_; _loc7_++)
         {
            _loc4_ = gc.obbsiteArray[_loc7_] as BaseObject;
            if(this.getBBDC().getDirect() == 0)
            {
               if(_loc4_.x > this.x)
               {
                  continue;
               }
            }
            else if(_loc4_.x < this.x)
            {
               continue;
            }
            if(_loc5_ > AUtils.GetDisBetweenTwoObj(this,_loc4_))
            {
               _loc5_ = AUtils.GetDisBetweenTwoObj(this,_loc4_);
               _loc3_ = _loc4_;
            }
         }
         if(_loc3_)
         {
            this.hit12Boom(_loc3_,this,3);
         }
      }
      
      private function hit12Boom(param1:BaseObject, param2:Role1, param3:uint) : void
      {
         var b:SpecialEffectBullet = null;
         var _target:BaseObject = param1;
         var _self:Role1 = param2;
         var times:uint = param3;
         if(times > 0)
         {
            if(!this.isDead())
            {
               SoundManager.play("Role1_hit12_2");
               b = new SpecialEffectBullet("Role1Bullet12");
               b.x = _target.x;
               b.y = _target.y;
               b.setRole(_self);
               b.setDirect(_self.getBBDC().getDirect());
               b.setAction("hit12");
               gc.gameSence.addChild(b);
               _self.magicBulletArray.push(b);
               gc.sendAttack(this.getRoleId(),"otherShowHit12",this.getBBDC().getDirect(),_target.x,_target.y,[]);
               times--;
               TweenMax.delayedCall(2,function(param1:BaseObject, param2:Role1, param3:uint):*
               {
                  _self.hit12Boom(param1,param2,param3);
               },[_target,_self,times]);
            }
            else
            {
               times = 0;
            }
         }
      }
      
      private function otherShowHit12(param1:uint, param2:Point) : void
      {
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet12");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setDisable();
         _loc3_.setAction("hit12_2");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function checkHit13(param1:uint, param2:Point) : void
      {
         var _loc3_:BaseObject = null;
         var _loc4_:Point = null;
         SoundManager.play("Role1_hit13_1");
         this.curAction = "hit13";
         if(param1 == 0)
         {
            this.speed.x = -30;
         }
         else
         {
            this.speed.x = 30;
         }
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            if(gc.isInRoom())
            {
               gc.obbsiteArray = gc.pWorld.getOtherHeroArray();
            }
            else
            {
               gc.obbsiteArray = gc.pWorld.monsterArray;
            }
            for each(_loc3_ in gc.obbsiteArray)
            {
               if(this.colipse.hitTestObject(_loc3_.colipse))
               {
                  trace("击中");
                  (_loc4_ = new Point()).x = _loc3_.x;
                  _loc4_.y = _loc3_.y;
                  this.doHit13(this.getBBDC().getDirect(),_loc4_);
                  if(gc.isInRoom())
                  {
                     gc.sendAttack(this.getRoleId(),"hit13",this.getBBDC().getDirect(),_loc4_.x,_loc4_.y,[]);
                  }
                  return;
               }
            }
         }
      }
      
      private function doHit13(param1:uint, param2:Point) : void
      {
         var direct:uint = param1;
         var point:Point = param2;
         SoundManager.play("Role1_hit13_2");
         this.curAction = "hit13";
         this.getBBDC().stopFrame();
         this.setStatic();
         this.getBBDC().hide();
         TweenMax.delayedCall(1.25,function(param1:Role1):*
         {
            param1.setAction("wait");
            param1.getBBDC().continueFrame();
            param1.getBBDC().show();
         },[this]);
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet13");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit13");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      public function createShallow(param1:uint = 0, param2:Point = null) : void
      {
         var _loc4_:Point = null;
         trace("Role1-》产生分身");
         if(!param2)
         {
            (_loc4_ = new Point()).x = this.x + (Math.random() - 0.5) * 150;
            _loc4_.y = this.y;
         }
         else
         {
            _loc4_ = param2;
         }
         var _loc3_:Role1Shadow = new Role1Shadow(this);
         if(this.getBBDC().getDirect() == 1)
         {
            _loc3_.getBBDC().turnRight();
         }
         _loc3_.x = _loc4_.x;
         _loc3_.y = _loc4_.y;
         gc.gameSence.addChild(_loc3_);
         this.shallowArray.push(_loc3_);
         if(this.sid == gc.sid && gc.isInRoom())
         {
            gc.sendAttack(this.getRoleId(),"createShallow",0,_loc4_.x,_loc4_.y,[]);
         }
      }
      
      public function doHit14_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role1_hit14");
         this.curAction = "hit14";
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet14_1");
         if(param1 == 0)
         {
            _loc3_.x = param2.x + 15;
         }
         else
         {
            _loc3_.x = param2.x - 15;
         }
         _loc3_.y = param2.y;
         _loc3_.setDisable();
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit14");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      public function doHit14_2(param1:uint, param2:Point) : void
      {
         this.curAction = "hit14";
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet14_2");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit14");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      override public function setOtherAttack(param1:String, param2:uint, param3:Point, param4:Array = null, param5:uint = 0) : void
      {
         switch(param1)
         {
            case "hit1":
               this.doHit1(param2,param3);
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
            case "hit7":
               this.doHit7(param2,param3);
               break;
            case "hit8":
               this.doHit8(param2,param3);
               break;
            case "hit9":
               this.doHit9(param2,param3);
               break;
            case "hit10_1":
               this.doHit10_1(param2,param3);
               break;
            case "hit10_2":
               this.doHit10_2(param2,param3);
               break;
            case "hit10_3":
               this.doHit10_3(param2,param3);
               break;
            case "hit10_4":
               this.doHit10_4(param2,param3);
               break;
            case "hit11_1":
               this.doHit11_1(param2,param3);
               break;
            case "hit11_2":
               this.doHit11_2(param2,param3);
               break;
            case "hit12_1":
               this.doHit12_1(param2,param3);
               break;
            case "otherShowHit12":
               this.otherShowHit12(param2,param3);
               break;
            case "hit13":
               this.doHit13(param2,param3);
               break;
            case "hit13Check":
               this.checkHit13(param2,param3);
               break;
            case "hit14_1":
               this.doHit14_1(param2,param3);
               break;
            case "hit14_2":
               this.doHit14_2(param2,param3);
               break;
            case "createShallow":
               this.createShallow(param2,param3);
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
         var _loc3_:Role1Shadow = null;
         super.step();
         var _loc1_:uint = this.shallowArray.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.shallowArray[_loc2_] as Role1Shadow;
            if(_loc3_)
            {
               if(_loc3_.isReadyToDestroy)
               {
                  this.shallowArray[_loc2_] = null;
               }
               else
               {
                  _loc3_.step();
               }
            }
            _loc2_++;
         }
      }
      
      override protected function myKeyDown(param1:String) : *
      {
         var needMp:uint = 0;
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
                  cannextaction = false;
                  break;
               case "0101":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  if(this.getPlayer())
                  {
                     if(this.getPlayer().findSkillIsInTheSkillAry("slz"))
                     {
                        needMp = 10;
                        if(this.roleProperies.getMMP() >= needMp)
                        {
                           this.skill_slz(needMp);
                        }
                        else
                        {
                           this.normalHit();
                        }
                     }
                     else
                     {
                        this.normalHit();
                     }
                  }
                  break;
               case "0001":
                  gc.pWorld.getBaseLevelListener().keyBoardDownForW(this);
                  if(!gc.isLevelClear && this.checkTransferDoor())
                  {
                     gc.isLevelClear = true;
                     gc.keyboardControl.destroy();
                     if(!gc.isInHost())
                     {
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
                     else
                     {
                        MainGame.getInstance().levelClear();
                     }
                  }
            }
         }
      }
      
      private function skill_slz(param1:uint) : void
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
         this.hitNum = 0;
         this.timers = 15;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_zz(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit14");
         this.curAction = "hit14";
         this.hitNum = 0;
         this.timers = 20;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_qsez(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit13");
         this.curAction = "hit13";
         this.hitNum = 0;
         this.timers = 20;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_hmz(param1:uint) : void
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
         this.hitNum = 0;
         this.timers = 30;
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_lys(param1:uint) : void
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
         this.setYourFather(10);
         this.hitNum = 0;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_hytj(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.hitNum = 0;
         this.doubleCount = 0;
         this.setAction("hit7");
         this.lastHit = "hit7";
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_lyfb(param1:uint) : void
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
      
      private function skill_jdy(param1:uint) : void
      {
         var _loc2_:Array = null;
         if(!this.isAttacking())
         {
            if(this.roleProperies.getMMP() < param1)
            {
               return;
            }
         }
         if(this.curAction != "hit11_1")
         {
            if(this.isAttacking() || this.isBeAttacking())
            {
               return;
            }
         }
         if(this.curAction != "hit11_1")
         {
            this.setAction("hit11_1");
            this.lastHit = "hit11_1";
            this.hitNum = 0;
            this.timers = this.hit11Count;
            this.newAttackId();
            if(this.getPlayer())
            {
               gc.sendPosition(this);
            }
            this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
         }
         else
         {
            _loc2_ = this.bbdc.getFrameStopCount();
            _loc2_[4][5] = this.bbdc.getCurFrameCount();
            this.setAction("hit11_2");
            this.lastHit = "hit11_2";
            this.hitNum = 0;
            this.timers = this.hit11Count;
            this.newAttackId();
            if(this.getPlayer())
            {
               gc.sendPosition(this);
            }
         }
      }
      
      private function skill_hyjj(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         if(this.isInSky())
         {
            return;
         }
         this.setAction("hit12");
         this.curAction = "hit12";
         this.hitNum = 0;
         this.timers = 17;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
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
            trace("skillArray[2] --->>" + _loc3_[2]);
            if(_loc3_)
            {
               param1 = _loc3_[0];
               _loc4_ = parseInt(_loc3_[1]);
               if(param1 == "slz")
               {
                  this.skill_slz(_loc4_);
               }
               else if(param1 == "hmz")
               {
                  this.skill_hmz(_loc4_);
               }
               else if(param1 == "hyjj")
               {
                  this.skill_hyjj(_loc4_);
               }
               else if(param1 == "zz")
               {
                  this.skill_zz(_loc4_);
               }
               else if(param1 == "qsez")
               {
                  this.skill_qsez(_loc4_);
               }
               else if(param1 == "lys")
               {
                  this.skill_lys(_loc4_);
               }
               else if(param1 == "hytj")
               {
                  this.skill_hytj(_loc4_);
               }
               else if(param1 == "lyfb")
               {
                  this.skill_lyfb(_loc4_);
               }
               else if(param1 == "jdy")
               {
                  this.skill_jdy(_loc4_);
               }
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
      
      override public function reduceHp(param1:int, param2:Boolean = false) : void
      {
         if(this.isGXP)
         {
            param2 = false;
         }
         super.reduceHp(param1,param2);
      }
      
      override public function setAttackBack(param1:Point) : void
      {
         if(!this.isGXP)
         {
            super.setAttackBack(param1);
         }
      }
      
      override public function normalHit() : *
      {
         var _loc1_:uint = 0;
         this.curtime = getTimer();
         if(this.timers <= 0)
         {
            if(!this.isInSky())
            {
               if(!this.isRunning() && (!this.isAttacking() || this.isNormalHit()))
               {
                  if(this.curtime - this.lasttime > 1500)
                  {
                     this.hitNum = 1;
                  }
                  else if(++this.hitNum > 5)
                  {
                     this.hitNum = 1;
                  }
                  switch(this.hitNum)
                  {
                     case 1:
                     case 2:
                     case 3:
                        this.timers = 9;
                        break;
                     case 4:
                        this.timers = 15;
                        break;
                     case 5:
                        this.timers = 15;
                  }
                  if(this.hitNum == 1 || this.hitNum == 2)
                  {
                     SoundManager.play("Role1_hit1AndHit2");
                  }
                  else if(this.hitNum == 3 || this.hitNum == 4)
                  {
                     SoundManager.play("Role1_hit3AndHit4");
                  }
                  else
                  {
                     SoundManager.play("Role1_hit5");
                  }
                  this.setAction("hit" + this.hitNum);
                  if(this.getPlayer())
                  {
                     gc.sendPosition(this);
                  }
                  this.lastHit = "hit" + this.hitNum;
                  this.newAttackId();
               }
               else if(this.isRunning() && !this.isAttacking())
               {
                  if(this.getPlayer())
                  {
                     if(this.getPlayer().findSkillIsInTheSkillAry("hytj"))
                     {
                        _loc1_ = 20;
                        if(this.roleProperies.getMMP() >= _loc1_)
                        {
                           this.skill_hytj(_loc1_);
                        }
                        else
                        {
                           this.setAction("hit1");
                           if(this.getPlayer())
                           {
                              gc.sendPosition(this);
                           }
                        }
                     }
                     else
                     {
                        this.setAction("hit1");
                        if(this.getPlayer())
                        {
                           gc.sendPosition(this);
                        }
                     }
                  }
               }
            }
            else if(!this.isAttacking() && !this.isBeAttacking())
            {
               this.timers = 15;
               this.setAction("hit3");
               if(this.getPlayer())
               {
                  gc.sendPosition(this);
               }
               this.lastHit = "hit3";
               this.hitNum = 0;
               SoundManager.play("Role1_hit3AndHit4");
               this.newAttackId();
            }
         }
         this.lasttime = this.curtime;
      }
      
      override public function refreshEquip() : void
      {
         var _loc1_:uint = this.getCurClothId();
         var _loc2_:uint = this.getCurWeaponId();
         var _loc3_:Array = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE1_" + _loc1_);
         if(_loc3_)
         {
            this.bbdc.replaceBitmapDataByName("body",_loc3_);
         }
         _loc3_ = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE1_EQUIP_" + _loc2_);
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
            this.roleProperies.setSHHP((80 + 50 * (this.roleProperies.getLevel() - 1)) * 10);
         }
         else
         {
            this.roleProperies.setSHHP(80 + 50 * (this.roleProperies.getLevel() - 1));
         }
         this.roleProperies.setHHP(this.roleProperies.getSHHP());
         this.roleProperies.setSMMP(50 + 20 * (this.roleProperies.getLevel() - 1));
         this.roleProperies.setMMP(this.roleProperies.getSMMP());
         this.roleProperies.setBasePower(10 + 5 * (this.roleProperies.getLevel() - 1));
         this.roleProperies.setDefense(2 + 2 * (this.roleProperies.getLevel() - 1));
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
            case "hit4":
            case "hit5":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit6":
               return 2 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit7":
               return 0.5 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit8":
               return 1.2 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit9":
               return 100;
            case "hit10_2":
               return 0.5 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit10_3":
               return 0.5 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit10_4":
               return 3 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit11_1":
               return 0.3 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit11_2":
               return 0.3 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit12":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit13":
               return 0.24 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit14":
               return 5 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "fabao-sword":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_;
            default:
               return 10;
         }
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" && gc.protectedPerproty.getProperty(this,"jumpCount") == 0 || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit8" || this.curAction == "hit14";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11_1" || this.curAction == "hit11_2" || this.curAction == "hit12" || this.curAction == "hit13" || this.curAction == "hit14";
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit14" || this.curAction == "hit12";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit7" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11_1" || this.curAction == "hit11_2" || this.curAction == "hit13";
      }
   }
}
