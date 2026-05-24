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
   import export.monster.MonsterRole4Hit5;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import manager.SoundManager;
   import my.MainGame;
   
   public class Role4 extends BaseHero
   {
       
      
      private var hit11Biaoji:SpecialEffectBullet;
      
      private var hit11BiaojiCount:uint;
      
      private var curHit11BiaojiCount:uint = 0;
      
      private var role4Hit5:MonsterRole4Hit5;
      
      private var isNotArrow:Boolean = true;
      
      private var hit12Dict:Dictionary;
      
      public function Role4()
      {
         this.hit12Dict = new Dictionary();
         super();
         roleName = "沙僧";
         userType = "沙僧";
         this.horizenSpeed = 6;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[2,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit1Arrow"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2Arrow"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":5,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":7,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,-3],
            "attackInterval":12,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 8,
               "power":10
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
         this.attackBackInfoDict["hit4Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,-3],
            "attackInterval":999,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 8,
               "power":10
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit6"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit7"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 4,
               "power":20
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
         this.attackBackInfoDict["hit8"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-30,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit8Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-30,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-15,-25],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,0],
            "attackInterval":4,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,-2],
            "attackInterval":8,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit11"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":7,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit12"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-5,-2],
            "attackInterval":20,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit12Arrow"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-5,-2],
            "attackInterval":10,
            "attackKind":"magic"
         };
         nameTextField.y = -this.colipse.height / 2 - 30;
         nameTextField.x = -this.colipse.width / 2 - 30;
         nameTextField.selectable = false;
         nameTextField.autoSize = "center";
         nameTextField.cacheAsBitmap = true;
         this.addChild(nameTextField);
         this.hit11BiaojiCount = gc.frameClips * 10;
      }
      
      override public function initPopertits() : void
      {
         super.initPopertits();
         this.attackBackInfoDict["hit7"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 4,
               "power":0.5 * this.roleProperies.getHurt()
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
      }
      
      override protected function initBBDC() : void
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         trace("initBBDC");
         var _loc1_:uint = this.getCurClothId();
         var _loc2_:uint = this.getCurWeaponId();
         if(!(_loc2_ == 4 || _loc2_ == 5))
         {
            this.isNotArrow = true;
            _loc3_ = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE4_SHOVEL_" + _loc1_);
         }
         else
         {
            this.isNotArrow = false;
            _loc3_ = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE4_ARROW_" + _loc1_);
         }
         _loc4_ = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE4_EQUIP_" + _loc2_);
         if(_loc3_ && _loc4_)
         {
            if(bbdc)
            {
               this.bbdc.replaceBitmapDataByName("body",_loc3_);
               this.bbdc.replaceBitmapDataByName("equip",_loc4_);
               if(this.isNotArrow)
               {
                  bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,13,2,24],[4,4,4,4],[2,2,2,2],[1,1,8,6,10,4],[2,2,2,2,2],[2,2,6],[2,2,11],[1,1,1,2],[2,19],[2,2,30],[2,2,2,15],[2,2,16],[2,2,14]]);
                  bbdc.setFrameCount([36,6,4,4,[1,1,1,1,1,1],5,3,3,12,2,3,4,3,3]);
               }
               else
               {
                  bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,13,2,24],[4,4,4,4],[2,2,2,2],[1,1,8,10,20,4],[2,2,2,2,2],[2,2,1,1,12],[2,2,2,2,2,10],[2,4,1,1,10],[2,2,30],[2,2,1,1,12],[2,2,2,2,2,20],[2,7,1,1,25],[2,18,2,2,2,24]]);
                  bbdc.setFrameCount([36,6,4,4,[1,1,1,1,1,1],5,5,6,5,3,5,6,5,6]);
               }
            }
            else
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
               bbdc.setOffsetXY(15,-13);
               if(this.isNotArrow)
               {
                  bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,13,2,24],[4,4,4,4],[2,2,2,2],[1,1,8,6,10,4],[2,2,2,2,2],[2,2,6],[2,2,11],[1,1,1,2],[2,19],[2,2,30],[2,2,2,15],[2,2,16],[2,2,14]]);
                  bbdc.setFrameCount([36,6,4,4,[1,1,1,1,1,1],5,3,3,12,2,3,4,3,3]);
               }
               else
               {
                  bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,13,2,24],[4,4,4,4],[2,2,2,2],[1,1,8,10,20,4],[2,2,2,2,2],[2,2,1,1,12],[2,2,2,2,2,10],[2,4,1,1,10],[2,2,30],[2,2,1,1,12],[2,2,2,2,2,20],[2,7,1,1,25],[2,18,2,2,2,24]]);
                  bbdc.setFrameCount([36,6,4,4,[1,1,1,1,1,1],5,5,6,5,3,5,6,5,6]);
               }
               bbdc.setEnterFrameCallBack(this.enterFrameFunc,this.exitFrameFunc);
               bbdc.setAddScriptWhenFrameOver(this.scriptFrameOverFunc);
               this.body.addChild(bbdc);
               this.bbdc.turnRight();
            }
            return;
         }
         throw new Error("ROLE4--BitmapData Error!");
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
               if(this.isNotArrow)
               {
                  if(_loc2_.y != 6)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(6);
                  }
               }
               else if(_loc2_.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(param1);
               break;
            case "hit2":
               if(this.isNotArrow)
               {
                  if(_loc2_.y != 7)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(7);
                  }
               }
               else if(_loc2_.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(param1);
               break;
            case "hit3":
               if(this.isNotArrow)
               {
                  if(_loc2_.y != 8)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(8);
                  }
               }
               else if(_loc2_.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(param1);
               break;
            case "hit4":
               if(this.isNotArrow)
               {
                  if(_loc2_.y != 9)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(9);
                  }
               }
               else if(_loc2_.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(param1);
               break;
            case "hit5":
               if(this.isNotArrow)
               {
                  if(_loc2_.y != 9)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(9);
                  }
               }
               else if(_loc2_.x != 4 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(4);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hit6":
               if(this.isNotArrow)
               {
                  if(_loc2_.x != 4 || _loc2_.y != 4)
                  {
                     this.bbdc.setFramePointX(4);
                     this.bbdc.setFramePointY(4);
                  }
               }
               else if(_loc2_.x != 3 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hit7":
               if(this.isNotArrow)
               {
                  if(_loc2_.y != 10)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(10);
                  }
               }
               else if(_loc2_.y != 9)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(9);
               }
               this.bbdc.setState(param1);
               break;
            case "hit8":
               if(this.isNotArrow)
               {
                  if(_loc2_.y != 11)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(11);
                  }
               }
               else if(_loc2_.y != 10)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(10);
               }
               this.bbdc.setState(param1);
               break;
            case "hit9":
               if(this.isNotArrow)
               {
                  if(_loc2_.y != 12)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(12);
                  }
               }
               else if(_loc2_.y != 11)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(11);
               }
               this.bbdc.setState(param1);
               break;
            case "hit10":
               if(this.isNotArrow)
               {
                  if(_loc2_.y != 10)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(10);
                  }
               }
               else if(_loc2_.y != 12)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(param1);
               break;
            case "hit11":
               if(_loc2_.x != 5 || _loc2_.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(param1);
               break;
            case "hit12":
               if(_loc2_.y != 13)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(13);
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
               this.setStatic();
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
               this.speed.y = 0;
               this.setAction("wait");
               break;
            case "hit10":
               this.setStatic();
               this.setAction("wait");
               break;
            case "hit11":
               this.setAction("wait");
               break;
            case "hit11Frame2":
               this.setAction("wait");
               break;
            case "hit12":
               this.lastHit = "";
               this.getBBDC().show();
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
         }
      }
      
      override protected function enterFrameFunc(param1:Point) : void
      {
         var _loc4_:BaseObject = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:BaseObject = null;
         var _loc8_:BaseBullet = null;
         var _loc2_:String = this.bbdc.getState();
         var _loc3_:Point = new Point();
         switch(_loc2_)
         {
            case "hit1":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(param1.x == 1)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              _loc3_.x = this.x - 20;
                           }
                           else
                           {
                              _loc3_.x = this.x + 20;
                           }
                           _loc3_.y = this.y + 30;
                           this.doHit1(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"hit1",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               else if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 90;
                        }
                        else
                        {
                           _loc3_.x = this.x + 90;
                        }
                        _loc3_.y = this.y;
                        this.doHit1Arrow(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"doHit1Arrow",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit2":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(param1.x == 1)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              _loc3_.x = this.x - 15;
                           }
                           else
                           {
                              _loc3_.x = this.x + 15;
                           }
                           _loc3_.y = this.y;
                           this.doHit2(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"hit2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               else if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 90;
                        }
                        else
                        {
                           _loc3_.x = this.x + 90;
                        }
                        _loc3_.y = this.y;
                        this.doHit1Arrow(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"doHit1Arrow",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit3":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 1)
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
                           _loc3_.y = this.y;
                           this.doHit3(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"hit3",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
                  if(this.getBBDC().getDirect() == 0)
                  {
                     this.speed.x = -8;
                  }
                  else
                  {
                     this.speed.x = 8;
                  }
               }
               else if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(param1.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 115;
                        }
                        else
                        {
                           _loc3_.x = this.x + 115;
                        }
                        _loc3_.y = this.y - 20;
                        this.doHit2Arrow(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"doHit2Arrow",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit4":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 19)
                     {
                        if(param1.x == 1)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              _loc3_.x = this.x - 245;
                           }
                           else
                           {
                              _loc3_.x = this.x + 245;
                           }
                           _loc3_.y = this.y - 110;
                           this.doHit4(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"hit4",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               else if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 30;
                        }
                        else
                        {
                           _loc3_.x = this.x + 30;
                        }
                        _loc3_.y = this.y;
                        this.doHit4Arrow(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"doHit4Arrow",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit5":
               if(this.isNotArrow)
               {
                  if(this.bbdc.getCurFrameCount() == 19)
                  {
                     if(param1.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 115;
                        }
                        else
                        {
                           _loc3_.x = this.x + 115;
                        }
                        _loc3_.y = this.y - 110;
                        this.doHit5_1(this.getBBDC().getDirect(),_loc3_);
                     }
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 20)
               {
                  if(param1.x == 4)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        _loc3_.x = this.x - 115;
                     }
                     else
                     {
                        _loc3_.x = this.x + 115;
                     }
                     _loc3_.y = this.y - 110;
                     this.doHit5_1(this.getBBDC().getDirect(),_loc3_);
                  }
               }
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 14)
                  {
                     if(param1.x == 1 || param1.x == 4)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x;
                        }
                        else
                        {
                           _loc3_.x = this.x;
                        }
                        _loc3_.y = this.y - 20;
                        _loc5_ = 9999;
                        for each(_loc7_ in gc.obbsiteArray)
                        {
                           if(this.getBBDC().getDirect() == 0)
                           {
                              if(this.x > _loc7_.x)
                              {
                                 _loc6_ = AUtils.GetDisBetweenTwoObj(this,_loc7_);
                                 if(_loc5_ > _loc6_)
                                 {
                                    _loc5_ = _loc6_;
                                    _loc4_ = _loc7_;
                                 }
                              }
                           }
                           else if(this.x < _loc7_.x)
                           {
                              _loc6_ = AUtils.GetDisBetweenTwoObj(this,_loc7_);
                              if(_loc5_ > _loc6_)
                              {
                                 _loc5_ = _loc6_;
                                 _loc4_ = _loc7_;
                              }
                           }
                        }
                        if(_loc4_)
                        {
                           this.doHit5_2(this.getBBDC().getDirect(),_loc3_,[_loc4_.sid,_loc4_.getRoleId()]);
                           gc.sendAttack(this.getRoleId(),"hit5_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[_loc4_.sid,_loc4_.getRoleId()]);
                        }
                     }
                  }
               }
               break;
            case "hit6":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 10)
                     {
                        if(param1.x == 4)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              _loc3_.x = this.x - 25;
                           }
                           else
                           {
                              _loc3_.x = this.x + 25;
                           }
                           _loc3_.y = this.y - 30;
                           this.doHit6(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"hit6",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               else if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     if(param1.x == 3)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 25;
                        }
                        else
                        {
                           _loc3_.x = this.x + 25;
                        }
                        _loc3_.y = this.y - 30;
                        this.doHit6(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit6",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit7":
               if(this.bbdc.getCurFrameCount() == 20)
               {
                  if(param1.x == 2)
                  {
                     for each(_loc8_ in this.magicBulletArray)
                     {
                        if(_loc8_.getImcName() == "Role4Bullet7_1")
                        {
                           _loc8_.destroy();
                        }
                     }
                     if(this.bbdc.getDirect() == 0)
                     {
                        _loc3_.x = this.x - 155;
                     }
                     else
                     {
                        _loc3_.x = this.x + 155;
                     }
                     _loc3_.y = this.y - 50;
                     this.doHit7_1(this.getBBDC().getDirect(),_loc3_);
                  }
               }
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 8)
                  {
                     if(param1.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 150;
                        }
                        else
                        {
                           _loc3_.x = this.x + 150;
                        }
                        _loc3_.y = this.y - 70;
                        this.doHit7_2(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit7_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit8":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(param1.x == 2)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              _loc3_.x = this.x - 125;
                           }
                           else
                           {
                              _loc3_.x = this.x + 125;
                           }
                           _loc3_.y = this.y - 30;
                           this.doHit8(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"hit8",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               else
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(param1.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 75;
                        }
                        else
                        {
                           _loc3_.x = this.x + 75;
                        }
                        _loc3_.y = this.y - 60;
                        this.doHit8Arrow_1(this.getBBDC().getDirect(),_loc3_);
                     }
                  }
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(param1.x == 0)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              _loc3_.x = this.x - 65;
                           }
                           else
                           {
                              _loc3_.x = this.x + 65;
                           }
                           _loc3_.y = this.y - 10;
                           this.doHit8Arrow_2(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"doHit8Arrow_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
                  if(param1.x == 0)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        this.isRight = true;
                        this.isLeft = false;
                        this.speed.x = 25;
                        this.speed.y = -25;
                     }
                     else
                     {
                        this.isLeft = true;
                        this.isRight = false;
                        this.speed.x = -25;
                        this.speed.y = -25;
                     }
                  }
                  else
                  {
                     this.setStatic();
                     this.speed.y = 0;
                  }
               }
               break;
            case "hit9":
               if(this.isNotArrow)
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
                        _loc3_.y = this.y;
                        this.doHit9_1(this.getBBDC().getDirect(),_loc3_);
                     }
                  }
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 13)
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
                           _loc3_.y = this.y - 80;
                           this.doHit9_2(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"hit9_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
                  if(param1.x == 2)
                  {
                     this.speed.y = -10;
                  }
               }
               else
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(param1.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 80;
                        }
                        else
                        {
                           _loc3_.x = this.x + 80;
                        }
                        _loc3_.y = this.y - 80;
                        this.doHit9Arrow_1(this.getBBDC().getDirect(),_loc3_);
                     }
                  }
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(param1.x == 1)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              _loc3_.x = this.x - 60;
                           }
                           else
                           {
                              _loc3_.x = this.x + 60;
                           }
                           _loc3_.y = this.y + 30;
                           this.doHit9Arrow_2(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"doHit9Arrow_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
                  if(param1.x <= 1)
                  {
                     this.speed.y = -35;
                  }
                  else
                  {
                     this.speed.y = 0;
                  }
                  this.setStatic();
               }
               break;
            case "hit10":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(param1.x == 0)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              _loc3_.x = this.x - 150;
                           }
                           else
                           {
                              _loc3_.x = this.x + 150;
                           }
                           _loc3_.y = this.y - 50;
                           this.doHit10(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"hit10",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
                  if(param1.x < 2)
                  {
                     if(this.getBBDC().getDirect() == 0)
                     {
                        this.speed.x = -20;
                     }
                     else
                     {
                        this.speed.x = 20;
                     }
                  }
                  else
                  {
                     this.setStatic();
                  }
               }
               else
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
                        _loc3_.y = this.y;
                        this.doHit10Arrow_1(this.getBBDC().getDirect(),_loc3_);
                     }
                  }
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 24)
                     {
                        if(param1.x == 4)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              _loc3_.x = this.x - 225;
                           }
                           else
                           {
                              _loc3_.x = this.x + 225;
                           }
                           _loc3_.y = this.y - 80;
                           this.doHit10Arrow_2(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"doHit10Arrow_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit11":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 4)
                  {
                     if(param1.x == 5)
                     {
                        _loc3_.x = this.x;
                        _loc3_.y = this.y;
                        this.doHit11(this.getBBDC().getDirect(),_loc3_);
                        gc.sendAttack(this.getRoleId(),"hit11",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                     }
                  }
               }
               break;
            case "hit12":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 14)
                     {
                        if(param1.x == 2)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              _loc3_.x = this.x - 150;
                           }
                           else
                           {
                              _loc3_.x = this.x + 150;
                           }
                           _loc3_.y = this.y;
                           this.doHit12(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"hit12",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
               else
               {
                  if(param1.x == 0 || param1.x == 1 && this.bbdc.getCurFrameCount() >= 16)
                  {
                     this.setStatic();
                     this.speed.y = -35;
                  }
                  else if(param1.x >= 2 && param1.x <= 3)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        this.speed.x = -25;
                     }
                     else
                     {
                        this.speed.x = 25;
                     }
                     this.speed.y = 0;
                  }
                  else if(param1.x == 4 && this.bbdc.getCurFrameCount() == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        this.isRight = true;
                        this.isLeft = false;
                        this.bbdc.turnRight();
                     }
                     else
                     {
                        this.isRight = false;
                        this.isLeft = true;
                        this.bbdc.turnLeft();
                     }
                  }
                  else
                  {
                     this.setStatic();
                     this.speed.y = 0;
                  }
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(param1.x == 0 || param1.x == 4)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           _loc3_.x = this.x - 80;
                        }
                        else
                        {
                           _loc3_.x = this.x + 80;
                        }
                        _loc3_.y = this.y - 100;
                        this.doHit12Arrow_1(this.getBBDC().getDirect(),_loc3_);
                     }
                  }
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(param1.x == 0 || param1.x == 4)
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
                           this.doHit12Arrow_2(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"doHit12Arrow_2",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                     if(this.bbdc.getCurFrameCount() == 17 || this.bbdc.getCurFrameCount() == 12 || this.bbdc.getCurFrameCount() == 6)
                     {
                        if(param1.x == 1 || param1.x == 5)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              _loc3_.x = this.x - (88 + this.bbdc.getCurFrameCount());
                           }
                           else
                           {
                              _loc3_.x = this.x + (88 + this.bbdc.getCurFrameCount());
                           }
                           _loc3_.y = this.y - (-7 + this.bbdc.getCurFrameCount() * 2);
                           this.doHit12Arrow_3(this.getBBDC().getDirect(),_loc3_);
                           gc.sendAttack(this.getRoleId(),"doHit12Arrow_3",this.getBBDC().getDirect(),_loc3_.x,_loc3_.y,[]);
                        }
                     }
                  }
               }
         }
      }
      
      private function doHit1(param1:uint, param2:Point) : void
      {
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit1");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit1Arrow(param1:uint, param2:Point) : void
      {
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit1Arrow");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit2(param1:uint, param2:Point) : void
      {
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet2");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit2");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit2Arrow(param1:uint, param2:Point) : void
      {
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow2");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit2Arrow");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit3(param1:uint, param2:Point) : void
      {
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet3");
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
         SoundManager.play("Role4_hit4");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet4");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit4");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit4Arrow(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role4_hit4Arrow");
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow4");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit4Arrow");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit5_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role4_hit5");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet5");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDisable();
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit5");
         var _loc4_:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(_loc3_,_loc4_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit5_2(param1:uint, param2:Point, param3:Array) : void
      {
         var _loc7_:BaseObject = null;
         var _loc8_:BaseObject = null;
         var _loc4_:int = gc.pWorld.likeMonsterArray.indexOf(this.role4Hit5);
         if(this.role4Hit5 && _loc4_ != -1)
         {
            this.role4Hit5.destroy();
            gc.pWorld.likeMonsterArray.splice(_loc4_,1);
            this.role4Hit5 = null;
         }
         var _loc5_:uint = parseInt(param3[0]);
         var _loc6_:uint = parseInt(param3[1]);
         for each(_loc8_ in gc.obbsiteArray)
         {
            if(_loc8_.sid == _loc5_ && _loc8_.getRoleId() == _loc6_)
            {
               _loc7_ = _loc8_;
            }
         }
         if(gc.sid != this.sid)
         {
            if(!_loc7_)
            {
               _loc7_ = gc.getHeroBySidAndRoleId(_loc5_,_loc6_);
            }
         }
         if(_loc7_)
         {
            this.role4Hit5 = new MonsterRole4Hit5(_loc7_,this);
            this.role4Hit5.x = param2.x;
            this.role4Hit5.y = param2.y;
            gc.gameSence.addChild(this.role4Hit5);
            gc.pWorld.likeMonsterArray.push(this.role4Hit5);
         }
      }
      
      private function doHit6(param1:uint, param2:Point) : void
      {
         var target:BaseObject = null;
         var newObbsiteArray:Array = null;
         var bo:BaseObject = null;
         var dis:Number = NaN;
         var moveTime:Number = NaN;
         var direct:uint = param1;
         var p:Point = param2;
         SoundManager.play("Role4_hit6");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet6");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDestroyWhenLastFrame(false);
         b.setDirect(direct);
         b.setAction("hit6");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            newObbsiteArray = gc.obbsiteArray.concat(gc.pWorld.likeMonsterArray);
            for each(bo in newObbsiteArray)
            {
               if(this.bbdc.getDirect() == 0)
               {
                  if(bo.x < this.x)
                  {
                     if(AUtils.GetDisBetweenTwoObj(bo,this) <= 500)
                     {
                        target = bo;
                        break;
                     }
                  }
               }
               else if(bo.x > this.x)
               {
                  if(AUtils.GetDisBetweenTwoObj(bo,this) <= 500)
                  {
                     target = bo;
                     break;
                  }
               }
            }
            if(target)
            {
               dis = AUtils.GetDisBetweenTwoObj(target,this);
               moveTime = dis / 500 * 1.2;
               this.reHit6(b,target,8,moveTime);
            }
            else
            {
               TweenMax.to(b,1,{
                  "alpha":0,
                  "onComplete":function(param1:SpecialEffectBullet):*
                  {
                     param1.destroy();
                  },
                  "onCompleteParams":[b]
               });
            }
         }
      }
      
      private function reHit6(param1:SpecialEffectBullet, param2:BaseObject, param3:uint, param4:Number) : void
      {
         var _b:SpecialEffectBullet = param1;
         var _target:BaseObject = param2;
         var _times:uint = param3;
         var _moveTime:Number = param4;
         if(_times > 0)
         {
            SoundManager.play("Role4_hit6");
            _times--;
            TweenMax.to(_b,_moveTime,{
               "x":_target.x,
               "y":_target.y,
               "onComplete":function(param1:Role4, param2:SpecialEffectBullet, param3:BaseObject, param4:uint):*
               {
                  var _loc5_:* = undefined;
                  var _loc6_:* = undefined;
                  var _loc7_:* = undefined;
                  var _loc8_:* = undefined;
                  var _loc9_:* = undefined;
                  if(!param3.isYourFather() && AUtils.GetDisBetweenTwoObj(param2,param3) <= 50)
                  {
                     if(param3.curAddEffect)
                     {
                        param3.curAddEffect.add([{
                           "name":BaseAddEffect.POISON_TIMES,
                           "time":gc.frameClips * 7
                        }]);
                        param3.curAddEffect.add([{
                           "name":BaseAddEffect.STUN,
                           "time":gc.frameClips * 0.5
                        }]);
                     }
                     (_loc5_ = AUtils.getNewObj("HeroBeHurt")).x = colipse.x;
                     _loc5_.y = colipse.y;
                     param3.addChild(_loc5_);
                     if(gc.isInRoom())
                     {
                        if(param3 is BaseHero)
                        {
                           BaseHero(param3).beAttackDoing();
                        }
                        gc.sendOtherBuff(param3.sid,param3.getRoleId(),"Role4_hit6",[]);
                     }
                     _loc6_ = false;
                     _loc7_ = gc.obbsiteArray.concat(gc.pWorld.likeMonsterArray);
                     for each(_loc8_ in _loc7_)
                     {
                        if(_loc8_ != param3)
                        {
                           if((_loc9_ = AUtils.GetDisBetweenTwoObj(_loc8_,param2)) <= 500)
                           {
                              _loc6_ = true;
                              param1.reHit6(param2,_loc8_,param4,_loc9_ / 500 * 1.2);
                              break;
                           }
                        }
                     }
                     if(!_loc6_)
                     {
                        param2.destroy();
                     }
                  }
                  else
                  {
                     param2.destroy();
                  }
               },
               "onCompleteParams":[this,_b,_target,_times]
            });
            gc.sendAttack(this.getRoleId(),"hit6_2",this.getBBDC().getDirect(),_b.x,_b.y,[_target.x,_target.y,_moveTime]);
         }
         else
         {
            _b.destroy();
         }
      }
      
      private function otherAttackHit6_2(param1:uint, param2:Point, param3:Array) : void
      {
         var b:SpecialEffectBullet = null;
         var direct:uint = param1;
         var p:Point = param2;
         var targetPointArray:Array = param3;
         b = new SpecialEffectBullet("Role4Bullet6");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDestroyWhenLastFrame(false);
         b.setDirect(direct);
         b.setAction("hit6");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         var targetX:int = parseInt(targetPointArray[0]);
         var targetY:int = parseInt(targetPointArray[1]);
         var moveTime:Number = targetPointArray[2];
         TweenMax.to(b,moveTime,{
            "x":targetX,
            "y":targetY,
            "onComplete":function():*
            {
               b.destroy();
            },
            "onCompleteParams":[b]
         });
      }
      
      private function doHit7_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role4_hit7");
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet7_1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDisable();
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit7_1");
         var _loc4_:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(_loc3_,_loc4_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit7_2(param1:uint, param2:Point) : void
      {
         var _loc3_:BaseBullet = null;
         var _loc4_:SpecialEffectBullet = null;
         for each(_loc3_ in this.magicBulletArray)
         {
            if(_loc3_.getImcName() == "Role4Bullet7_2")
            {
               _loc3_.destroy();
            }
         }
         (_loc4_ = new SpecialEffectBullet("Role4Bullet7_2")).x = param2.x;
         _loc4_.y = param2.y;
         _loc4_.setRole(this);
         _loc4_.setDirect(param1);
         _loc4_.setAction("hit7");
         gc.gameSence.addChild(_loc4_);
         this.magicBulletArray.push(_loc4_);
         _loc4_ = new SpecialEffectBullet("Role4Bullet7_2");
         if(param1 == 0)
         {
            _loc4_.x = param2.x - 40;
         }
         else
         {
            _loc4_.x = param2.x + 40;
         }
         _loc4_.y = param2.y - 20;
         _loc4_.setRole(this);
         _loc4_.setDirect(param1);
         _loc4_.setAction("hit7");
         gc.gameSence.addChild(_loc4_);
         this.magicBulletArray.push(_loc4_);
         _loc4_ = new SpecialEffectBullet("Role4Bullet7_2");
         if(param1 == 0)
         {
            _loc4_.x = param2.x + 40;
         }
         else
         {
            _loc4_.x = param2.x - 40;
         }
         _loc4_.y = param2.y - 10;
         _loc4_.setRole(this);
         _loc4_.setDirect(param1);
         _loc4_.setAction("hit7");
         gc.gameSence.addChild(_loc4_);
         this.magicBulletArray.push(_loc4_);
      }
      
      private function doHit8(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role4_hit8");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet8");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit8");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit8Arrow_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role4_hit8Arrow");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow8_1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDisable();
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit8");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit8Arrow_2(param1:uint, param2:Point) : void
      {
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow8_2");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit8Arrow");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit9_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role4_hit9");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet9_1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDisable();
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit9");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit9_2(param1:uint, param2:Point) : void
      {
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet9_2");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit9");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit9Arrow_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role4_hit9Arrow");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow9_1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDisable();
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit9");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit9Arrow_2(param1:uint, param2:Point) : void
      {
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow9_2");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit9Arrow");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit10(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role4_hit10");
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet10");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit10");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit10Arrow_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role4_hit10Arrow");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow10_1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDisable();
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit10");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit10Arrow_2(param1:uint, param2:Point) : void
      {
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow10_2");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit10Arrow");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit11(param1:uint, param2:Point) : void
      {
         var _loc3_:int = 0;
         if(!this.hit11Biaoji)
         {
            SoundManager.play("Role4_hit11");
            this.hit11Biaoji = new SpecialEffectBullet("Role4Bullet11");
            this.curHit11BiaojiCount = 0;
            this.hit11Biaoji.x = param2.x;
            this.hit11Biaoji.y = param2.y;
            this.hit11Biaoji.setDestroyWhenLastFrame(false);
            this.hit11Biaoji.setDirect(param1);
            this.hit11Biaoji.setDisable();
            _loc3_ = gc.gameSence.getChildIndex(this);
            gc.gameSence.addChildAt(this.hit11Biaoji,_loc3_);
            this.magicBulletArray.push(this.hit11Biaoji);
         }
      }
      
      private function doHit11_2(param1:uint, param2:Point) : void
      {
         this.x = this.hit11Biaoji.x;
         this.y = this.hit11Biaoji.y;
         this.speed.y = 0;
      }
      
      public function clearBiaoJi() : void
      {
         if(this.hit11Biaoji)
         {
            this.hit11Biaoji.destroy();
            this.hit11Biaoji = null;
         }
      }
      
      private function doHit12(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role4_hit12");
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet12");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDestroyWhenLastFrame(false);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit12");
         _loc3_.setDestroyInCount(gc.frameClips * 10);
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit12Arrow_1(param1:uint, param2:Point) : void
      {
         SoundManager.play("Role4_hit12Arrow");
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow12_1");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setDisable();
         _loc3_.setAction("hit12");
         var _loc4_:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(_loc3_,_loc4_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit12Arrow_2(param1:uint, param2:Point) : void
      {
         var _loc3_:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow12_2");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit12Arrow");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      private function doHit12Arrow_3(param1:uint, param2:Point) : void
      {
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow12_3");
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         _loc3_.setRole(this);
         _loc3_.setDirect(param1);
         _loc3_.setAction("hit12Arrow");
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
            case "doHit1Arrow":
               this.doHit1Arrow(param2,param3);
               break;
            case "hit2":
               this.doHit2(param2,param3);
               break;
            case "doHit2Arrow":
               this.doHit2Arrow(param2,param3);
               break;
            case "hit3":
               this.doHit3(param2,param3);
               break;
            case "hit4":
               this.doHit4(param2,param3);
               break;
            case "doHit4Arrow":
               this.doHit4Arrow(param2,param3);
               break;
            case "hit5_2":
               this.doHit5_2(param2,param3,param4);
               break;
            case "hit6_2":
               this.otherAttackHit6_2(param2,param3,param4);
               break;
            case "hit7_2":
               this.doHit7_2(param2,param3);
               break;
            case "hit8":
               this.doHit8(param2,param3);
               break;
            case "doHit8Arrow_2":
               this.doHit8Arrow_2(param2,param3);
               break;
            case "hit9_2":
               this.doHit9_2(param2,param3);
               break;
            case "doHit9Arrow_2":
               this.doHit9Arrow_2(param2,param3);
               break;
            case "hit10":
               this.doHit10(param2,param3);
               break;
            case "doHit10Arrow_2":
               this.doHit10Arrow_2(param2,param3);
               break;
            case "hit11":
               this.doHit11(param2,param3);
               break;
            case "hit11_2":
               this.doHit11_2(param2,param3);
               break;
            case "hit12":
               this.doHit12(param2,param3);
               break;
            case "doHit12Arrow_2":
               this.doHit12Arrow_2(param2,param3);
               break;
            case "doHit12Arrow_3":
               this.doHit12Arrow_3(param2,param3);
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
         if(this.hit11Biaoji)
         {
            if(this.curHit11BiaojiCount < this.hit11BiaojiCount)
            {
               ++this.curHit11BiaojiCount;
            }
            if(this.curHit11BiaojiCount == this.hit11BiaojiCount)
            {
               this.hit11Biaoji.destroy();
               this.hit11Biaoji = null;
            }
         }
      }
      
      override public function reduceHp(param1:int, param2:Boolean = false) : void
      {
         if(this.isGXP || this.curAction == "hit12")
         {
            param2 = false;
         }
         super.reduceHp(param1,param2);
      }
      
      override public function setAttackBack(param1:Point) : void
      {
         if(!(this.isGXP || this.curAction == "hit12"))
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
               if(param1 == "zq")
               {
                  this.skill_zq(_loc3_);
               }
               else if(param1 == "mbyj")
               {
                  this.skill_mbyj(_loc3_);
               }
               else if(param1 == "wdww")
               {
                  this.skill_wdww(_loc3_);
               }
               else if(param1 == "jdz")
               {
                  this.skill_jdz(_loc3_);
               }
               else if(param1 == "mds")
               {
                  this.skill_mds(_loc3_);
               }
               else if(param1 == "qlj")
               {
                  this.skill_qlj(_loc3_);
               }
               else if(param1 == "tkj")
               {
                  this.skill_tkj(_loc3_);
               }
               else if(param1 == "dzj")
               {
                  this.skill_dcj(_loc3_);
               }
               else if(param1 == "lybj")
               {
                  this.skill_lvbj(_loc3_);
               }
               else if(param1 == "mmw")
               {
                  this.skill_mmw(_loc3_);
               }
            }
         }
      }
      
      private function skill_zq(param1:uint) : void
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
      
      private function skill_mbyj(param1:uint) : void
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
         this.newAttackId();
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_wdww(param1:uint) : void
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
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_jdz(param1:uint) : void
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
      
      private function skill_mmw(param1:uint) : void
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
         this.lastHit = "hit12";
         this.setAction("hit12");
         this.hitNum = 0;
         this.newAttackId();
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_mds(param1:uint) : void
      {
         var _loc2_:BaseObject = null;
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         SoundManager.play("Role4_mds");
         for each(_loc2_ in gc.obbsiteArray)
         {
            _loc2_.curAddEffect.poison_times_bomb(this.roleProperies.getHurt(),this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_qlj(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
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
         this.roleProperies.setMMP(this.roleProperies.getMMP() - 15);
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_tkj(param1:uint) : void
      {
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit9";
         this.setAction("hit9");
         this.newAttackId();
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      private function skill_dcj(param1:uint) : void
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
      
      private function skill_lvbj(param1:uint) : void
      {
         var _loc2_:Rectangle = null;
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         if(this.roleProperies.getMMP() < param1)
         {
            return;
         }
         if(!this.hit11Biaoji)
         {
            this.lastHit = "hit11";
            this.setAction("hit11");
            this.newAttackId();
            this.hitNum = 0;
            if(gc.sid == this.sid)
            {
               gc.sendPosition(this);
            }
         }
         else
         {
            _loc2_ = this.hit11Biaoji.getBounds(gc.gameSence.parent);
            if(_loc2_.x < 30 || _loc2_.x > 930)
            {
               this.hit11Biaoji.destroy();
               this.hit11Biaoji = null;
            }
            else
            {
               this.doHit11_2(this.getBBDC().getDirect(),new Point());
               if(gc.sid == this.sid)
               {
                  gc.sendPosition(this);
                  gc.sendAttack(this.getRoleId(),"hit11_2",this.getBBDC().getDirect(),0,0,[]);
               }
            }
         }
         this.roleProperies.setMMP(this.roleProperies.getMMP() - param1);
      }
      
      override protected function showSkillKongGe() : void
      {
         var _loc1_:RoleInfo = gc.gameInfo.getRoleInfoByPlayer(this.player) as RoleInfo;
         if(_loc1_.isGXPReady() && !this.isGXP)
         {
            this.turnToGXP();
         }
      }
      
      private function refreshByWeapon() : void
      {
         this.initBBDC();
      }
      
      override public function refreshEquip() : void
      {
         this.refreshByWeapon();
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
                  this.setAction("hit" + this.hitNum);
                  this.lastHit = "hit" + this.hitNum;
                  if(this.isNotArrow)
                  {
                     SoundManager.play("Role4_hit" + this.hitNum);
                  }
                  else if(this.hitNum == 1 || this.hitNum == 2)
                  {
                     SoundManager.play("Role4_hit1Arrow");
                  }
                  else
                  {
                     SoundManager.play("Role4_hit2Arrow");
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
               if(this.isNotArrow)
               {
                  this.setAction("hit2");
                  this.lastHit = "hit2";
                  SoundManager.play("Role4_hit2");
               }
               else
               {
                  this.setAction("hit3");
                  this.lastHit = "hit3";
                  SoundManager.play("Role4_hit2Arrow");
               }
               if(this.getPlayer())
               {
                  gc.sendPosition(this);
               }
               this.hitNum = 0;
               this.newAttackId();
            }
         }
         this.lasttime = this.curtime;
      }
      
      private function isDefending() : Boolean
      {
         return this.curAction == "hit6";
      }
      
      override public function isNormalHit() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      private function runAttack() : void
      {
         if(!this.isInSky())
         {
            if(this.roleProperies.getMMP() >= 20)
            {
               this.hitNum = 1;
               this.doubleCount = 0;
               this.lastHit = "hit6";
               this.curAction = "hit6";
               this.newAttackId();
               this.roleProperies.setMMP(this.roleProperies.getMMP() - 20);
            }
            else
            {
               this.doubleCount = 0;
               this.normalHit();
            }
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
            this.roleProperies.setSHHP((70 + 30 * (this.roleProperies.getLevel() - 1)) * 10);
         }
         else
         {
            this.roleProperies.setSHHP(70 + 30 * (this.roleProperies.getLevel() - 1));
         }
         this.roleProperies.setHHP(this.roleProperies.getSHHP());
         this.roleProperies.setSMMP(70 + 30 * (this.roleProperies.getLevel() - 1));
         this.roleProperies.setMMP(this.roleProperies.getSMMP());
         this.roleProperies.setBasePower(16 + 4 * (this.roleProperies.getLevel() - 1));
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
         switch(param1)
         {
            case "hit1":
            case "hit1Arrow":
            case "hit2":
            case "hit2Arrow":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit3":
               return 0.5 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit4":
               return 0.3 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit4Arrow":
               return 1.2 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit5":
               return 0;
            case "hit6":
               return 0;
            case "hit7":
               return 0.5 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit8":
               return 2 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit8Arrow":
               return 2 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit9":
               return 2 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit9Arrow":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit10":
               return 1.2 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit10Arrow":
               return 4 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit11":
               return 0;
            case "hit12":
               return 3 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "hit12Arrow":
               return 2 * this.roleProperies.getHurt() * _loc3_ * _loc4_;
            case "fabao-sword":
               return this.roleProperies.getHurt() * _loc3_ * _loc4_;
            default:
               return 0;
         }
      }
      
      private function isAttackingButCanAttack() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3";
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         if(this.isNotArrow)
         {
            return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit9" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
         }
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         if(this.isNotArrow)
         {
            return this.curAction == "hit10" || this.curAction == "hit8";
         }
         return this.curAction == "hit8";
      }
   }
}
