package
{
   import PhysicsWorld.PhysicsWorld;
   import com.greensock.TweenMax;
   import com.hexagonstar.util.debug.Debug;
   import config.Config;
   import event.CommonEvent;
   import export.AboutUs;
   import export.GameMenu;
   import export.Help;
   import export.LineChoose;
   import export.LoadingBar;
   import export.LoadingBar2;
   import export.SelectPLace;
   import export.SelectRole;
   import export.cartoon.GameCartoon;
   import export.huodong.AllHuoDongInterface;
   import export.huodong.ChineseValentinesDay;
   import export.lose.GameFail;
   import export.microshop.Micropayment;
   import export.shop.BuySkill;
   import export.strength.StrengthEquipment;
   import export.taskInterface.TaskInterface;
   import export.win.GameWin;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.net.LocalConnection;
   import loader.Aloader;
   import manager.SoundManager;
   import my.MainGame;
   import my.UString;
   import myanalysis.MyAllEquipId;
   import myanalysis.MyAnalyzingEquip;
   import unit4399.events.PayEvent;
   import unit4399.events.SaveEvent;
   
   public class GMain extends MovieClip
   {
      
      public static var _4399_function_ad_id:String = "92d6cef76cd06829e088932fe9fd819b";
      
      public static var serviceHold = null;
      
      private static var _this:GMain;
       
      
      var _4399_function_shop_id:String = "30ea6b51a23275df624b781c3eb43ac6";
      
      var _4399_function_payMoney_id:String = "10f73c09b41d9f41e761232f5f322f38";
      
      var _4399_function_store_id:String = "3885799f65acec467d97b4923caebaae";
      
      private var meid:MyAllEquipId;
      
      private var gc:Config;
      
      private var pay:PayMoneyVar;
      
      private var _loader:Aloader;
      
      private var mainSence:Sprite;
      
      private var topSence:Sprite;
      
      private var curState:String;
      
      private const _0:String = UString.ddb416368e17ec1e([52,51,57,57,46,99,111,109]);
      
      private const _1:String = UString.ddb416368e17ec1e([109,121,52,51,57,57,46,99,111,109]);
      
      private const _2:String = UString.ddb416368e17ec1e([102,102,49,51,48,46,99,111,109]);
      
      private const _3:String = UString.ddb416368e17ec1e([52,51,57,57,112,107,46,99,111,109]);
      
      private const _4:String = UString.ddb416368e17ec1e([47]);
      
      private const _5:String = UString.ddb416368e17ec1e([46]);
      
      private const _6:String = UString.ddb416368e17ec1e([58]);
      
      private const _URL_LIST:Array = new Array(this._0,this._1,this._2,this._3);
      
      private var myAnalyEquip:MyAnalyzingEquip;
      
      var gm:GameMenu;
      
      public function GMain()
      {
         this.meid = new MyAllEquipId();
         this.gc = new Config();
         this.pay = new PayMoneyVar();
         this.myAnalyEquip = new MyAnalyzingEquip();
         super();
         this._loader = new Aloader();
         this._loader.init();
         _this = this;
         this.gc.pWorld = new PhysicsWorld();
         this.gc.lc = new LocalConnection();
         this.mainSence = new Sprite();
         this.topSence = new Sprite();
         this.addChild(this.mainSence);
         this.addChild(this.topSence);
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      public static function getInstance() : GMain
      {
         return _this;
      }
      
      public function setHold(param1:*) : void
      {
         serviceHold = param1;
      }
      
      private function saveProcess(param1:SaveEvent) : void
      {
         try
         {
            switch(param1.type)
            {
               case SaveEvent.SAVE_GET:
                  trace("--SaveEvent.SAVE_GET--");
                  if(this.gc.loginAlert && this.gc.loginAlert.name == "LoginAlert" && this.gc.loginAlert.parent)
                  {
                     this.gc.loginAlert.parent.removeChild(this.gc.loginAlert);
                     this.gc.loginAlert = null;
                  }
                  if(param1.data != null)
                  {
                     this.gc.memory.storageValue(param1.data.index,param1.data.data);
                     this.gm.showAndHide();
                  }
                  else
                  {
                     this.gm.getSaveData();
                  }
                  break;
               case SaveEvent.SAVE_SET:
                  if(param1.ret as Boolean == true)
                  {
                     this.gc.ts.setTxt("存档成功");
                     if(this.gc.saveInter && this.gc.saveInter.parent)
                     {
                        this.gc.saveInter.parent.removeChild(this.gc.saveInter);
                        this.gc.saveInter = null;
                     }
                  }
                  else
                  {
                     if(this.gc.saveInter)
                     {
                        if(this.gc.saveInter.getChildByName("SavingGameMask"))
                        {
                           this.gc.saveInter.removeChild(this.gc.saveInter.getChildByName("SavingGameMask"));
                        }
                     }
                     this.gc.ts.setTxt("存档失败");
                  }
                  this.addChild(this.gc.ts);
                  break;
               case SaveEvent.SAVE_LIST:
                  if(this.gc.dealAlert && this.gc.dealAlert.name == "DealingAlert" && this.gc.dealAlert.parent)
                  {
                     this.gc.dealAlert.parent.removeChild(this.gc.dealAlert);
                     this.gc.dealAlert = null;
                  }
                  if(param1.ret != null)
                  {
                     this.gc.saveInter.setIndex(param1.ret as Array);
                  }
                  break;
               case "logreturn":
                  trace("登录完成发出的事件");
                  this.gc.logInfo = param1.ret;
                  if(param1.ret)
                  {
                     this.gc.isfirstLogin = false;
                     this.gc.setLocalUserId(String(param1.ret.uid));
                     this.gm.showSelectNum();
                     this.gm.getSevenData();
                     this.gm.isremoveLoginAlert();
                  }
            }
         }
         catch(e:*)
         {
         }
      }
      
      public function showProgress(param1:int, param2:int) : void
      {
         var _loc3_:LoadingBar = null;
         if(!this.getChildByName("showProgress"))
         {
            _loc3_ = new LoadingBar();
            _loc3_.name = "showProgress";
            _loc3_.setProcess(param1,param2);
            _loc3_.x = 470;
            _loc3_.y = 295;
            this.addChild(_loc3_);
         }
         else
         {
            LoadingBar(this.getChildByName("showProgress")).setProcess(param1,param2);
         }
      }
      
      public function showLoadByStageAndLevelProgress(param1:int) : void
      {
         var _loc2_:LoadingBar2 = null;
         if(!this.getChildByName("showLoadByStageAndLevelProgress"))
         {
            _loc2_ = new LoadingBar2();
            _loc2_.name = "showLoadByStageAndLevelProgress";
            _loc2_.setProcess(param1);
            _loc2_.x = 470;
            _loc2_.y = 295;
            this.addChild(_loc2_);
         }
         else
         {
            LoadingBar2(this.getChildByName("showLoadByStageAndLevelProgress")).setProcess(param1);
         }
      }
      
      public function processComplete() : void
      {
         var _loc1_:MovieClip = this.getChildByName("showProgress") as MovieClip;
         if(_loc1_)
         {
            this.removeChild(_loc1_);
            _loc1_ = null;
         }
         _loc1_ = this.getChildByName("showLoadByStageAndLevelProgress") as MovieClip;
         if(_loc1_)
         {
            this.removeChild(_loc1_);
            _loc1_ = null;
         }
      }
      
      public function switchSence(param1:String) : void
      {
         this.curState = param1;
         switch(param1)
         {
            case "startFighting":
               this.startGame(this.gc.curStage,this.gc.curLevel);
               break;
            case "GameMenu":
               this.showGameMenu();
               break;
            case "SelectRole":
               this.showSelectRolw();
               break;
            case "showStageMap":
               this.showStageMap();
               break;
            case "gameOver":
               this.showGameOver();
               break;
            case "OpenAnimation":
               this.showOpenAnimation(null);
               break;
            case "ChineseValentinesDay":
               this.chineseValentinesDay(null);
               break;
            case "AllHuoDongInterface":
               this.allHuoDongInterface();
         }
      }
      
      private function added(param1:*) : void
      {
         trace("GMain--added");
         this.tabChildren = false;
         this.gc.eventManger.addEventListener("LoadOver",this.loaderOver);
         this.gc.eventManger.addEventListener("StartSelectRole",this.selectRole);
         this.gc.eventManger.addEventListener("ShowTaskInterface",this.showTaskInterface);
         this.gc.eventManger.addEventListener("showShoping",this.showShoping);
         this.gc.eventManger.addEventListener("SelectOver",this.SelectRoleOver);
         this.gc.eventManger.addEventListener("selectStageOver",this.selectStageOver);
         this.gc.eventManger.addEventListener("showBuySkill",this.showBuySkill);
         this.gc.eventManger.addEventListener("showStrengthEquip",this.showStrengthEquip);
         this.gc.eventManger.addEventListener("heroDead",this.heroDead);
         this.gc.eventManger.addEventListener("GameOver",this.gameOver);
         this.gc.eventManger.addEventListener("ReStart",this.reStart);
         this.gc.eventManger.addEventListener("LevelVictor",this.levelVictor);
         this.gc.eventManger.addEventListener("ShowOpenAnimation",this.showOpenAnimation);
         this.gc.eventManger.addEventListener("ShowOpenAnimationOver",this.showOpenAnimationOver);
         this.gc.eventManger.addEventListener("showAboutUs",this.showAboutUs);
         this.gc.eventManger.addEventListener("GameHelp",this.gameHelp);
         stage.addEventListener("netSaveError",this.netSaveErrorHandler,false,0,true);
         stage.addEventListener(SaveEvent.SAVE_GET,this.saveProcess);
         stage.addEventListener(SaveEvent.SAVE_SET,this.saveProcess);
         stage.addEventListener(SaveEvent.SAVE_LIST,this.saveProcess);
         stage.addEventListener("logreturn",this.saveProcess);
         stage.addEventListener("MVC_CLOSE_PANEL",this.closePanelHandler,false,0,true);
         stage.addEventListener("userLoginOut",this.onUserLogOutHandler,false,0,true);
         stage.addEventListener(PayEvent.DEC_MONEY,this.onPayEventHandler,false,0,true);
         stage.addEventListener(PayEvent.GET_MONEY,this.onPayEventHandler,false,0,true);
         stage.addEventListener(Event.ACTIVATE,this.clickBack);
         this.gc.stage = this.stage;
         var _loc2_:Array = stage.loaderInfo.url.split(this._4)[2].split(this._6)[0].split(this._5);
         var _loc3_:Boolean = false;
         var _loc4_:* = 0;
         while(_loc4_ < this._URL_LIST.length)
         {
            if(_loc2_[_loc2_.length - 2] + UString.ddb416368e17ec1e([46]) + _loc2_[_loc2_.length - 1] == this._URL_LIST[_loc4_] || _loc2_.length == 1 && _loc2_[0] == "")
            {
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         if(!_loc3_)
         {
            if(this.gc.isHideDebug)
            {
               this.visible = false;
            }
         }
      }
      
      private function removed(param1:*) : void
      {
         this.gc.eventManger.removeEventListener("LoadOver",this.loaderOver);
         this.gc.eventManger.removeEventListener("StartSelectRole",this.selectRole);
         this.gc.eventManger.removeEventListener("SelectOver",this.SelectRoleOver);
         this.gc.eventManger.removeEventListener("ShowTaskInterface",this.showTaskInterface);
         this.gc.eventManger.removeEventListener("selectStageOver",this.selectStageOver);
         this.gc.eventManger.removeEventListener("showBuySkill",this.showBuySkill);
         this.gc.eventManger.removeEventListener("showStrengthEquip",this.showStrengthEquip);
         this.gc.eventManger.removeEventListener("heroDead",this.heroDead);
         this.gc.eventManger.removeEventListener("GameOver",this.gameOver);
         this.gc.eventManger.removeEventListener("ReStart",this.reStart);
         this.gc.eventManger.removeEventListener("LevelVictor",this.levelVictor);
         this.gc.eventManger.removeEventListener("ShowOpenAnimation",this.showOpenAnimation);
         this.gc.eventManger.removeEventListener("ShowOpenAnimationOver",this.showOpenAnimationOver);
         this.gc.eventManger.removeEventListener("showAboutUs",this.showAboutUs);
         this.gc.eventManger.removeEventListener("GameHelp",this.gameHelp);
         this.gc.eventManger.removeEventListener("showShoping",this.showShoping);
         stage.removeEventListener(Event.ACTIVATE,this.clickBack);
      }
      
      private function clickBack(param1:Event) : void
      {
         if(this.gc.isHideDebug && this.gc.isingameshop)
         {
            if(serviceHold)
            {
               serviceHold.getBalance();
            }
         }
      }
      
      private function showAboutUs(param1:CommonEvent) : void
      {
         var _loc2_:AboutUs = AUtils.getNewObj("export.AboutUs") as AboutUs;
         this.mainSence.addChild(_loc2_);
      }
      
      private function gameHelp(param1:CommonEvent) : void
      {
         var _loc2_:Help = AUtils.getNewObj("export.Help") as Help;
         this.mainSence.addChild(_loc2_);
      }
      
      private function showOpenAnimation(param1:*) : void
      {
         var _loc2_:GameCartoon = AUtils.getNewObj("export.cartoon.GameCartoon") as GameCartoon;
         _loc2_.mygotoandStop(this.gc.gameinwhere);
         this.mainSence.addChild(_loc2_);
      }
      
      private function chineseValentinesDay(param1:*) : void
      {
         var _loc2_:ChineseValentinesDay = AUtils.getNewObj("export.huodong.ChineseValentinesDay") as ChineseValentinesDay;
         this.mainSence.addChild(_loc2_);
      }
      
      private function allHuoDongInterface() : void
      {
         var _loc1_:AllHuoDongInterface = AUtils.getNewObj("export.huodong.AllHuoDongInterface") as AllHuoDongInterface;
         this.mainSence.addChild(_loc1_);
      }
      
      private function showLineChoose(param1:*) : void
      {
         var _loc2_:LineChoose = AUtils.getNewObj("export.huodong.ChineseValentinesDay") as LineChoose;
         this.mainSence.addChild(_loc2_);
      }
      
      private function showOpenAnimationOver(param1:*) : void
      {
         this.switchSence("showStageMap");
      }
      
      private function showBuySkill(param1:CommonEvent) : void
      {
         var _loc2_:BuySkill = AUtils.getNewObj("export.shop.BuySkill") as BuySkill;
         _loc2_.setCurrentState(param1.data.state);
         this.mainSence.addChild(_loc2_);
      }
      
      private function showStrengthEquip(param1:CommonEvent) : void
      {
         var _loc2_:StrengthEquipment = AUtils.getNewObj("export.strength.StrengthEquipment") as StrengthEquipment;
         _loc2_.setCurrentState(param1.data.state);
         this.mainSence.addChild(_loc2_);
      }
      
      private function showShoping(param1:CommonEvent) : void
      {
         var _loc2_:Micropayment = AUtils.getNewObj("export.microshop.Micropayment") as Micropayment;
         this.mainSence.addChild(_loc2_);
      }
      
      public function getTopSence() : Sprite
      {
         return this.topSence;
      }
      
      private function SelectRoleOver(param1:*) : void
      {
         Debug.trace("---SelectRoleOver---");
         if(this.gc.opening)
         {
            this.switchSence("showStageMap");
         }
         else
         {
            this.gc.gameinwhere = "开场";
            this.switchSence("OpenAnimation");
         }
      }
      
      private function showStageMap() : void
      {
         var _loc1_:SelectPLace = null;
         Debug.trace("---showStageMap----");
         SoundManager.play("begin");
         if(this.mainSence.getChildByName("SelectPlaceHasShow") == null)
         {
            _loc1_ = AUtils.getNewObj("export.SelectPLace") as SelectPLace;
            _loc1_.name = "SelectPlaceHasShow";
            this.mainSence.addChild(_loc1_);
         }
      }
      
      private function selectStageOver(param1:*) : void
      {
         this.switchSence("startFighting");
      }
      
      private function showGameMenu() : void
      {
         if(this.mainSence.getChildByName("SelectPlaceHasShow"))
         {
            this.mainSence.removeChild(this.mainSence.getChildByName("SelectPlaceHasShow"));
         }
         if(this.gm == null)
         {
            this.gm = AUtils.getNewObj("export.GameMenu") as GameMenu;
            this.gm.name = "GameMenuHasShow";
         }
         if(!this.mainSence.getChildByName("GameMenuHasShow"))
         {
            this.mainSence.addChild(this.gm);
         }
      }
      
      private function showTaskInterface(param1:*) : void
      {
         var _loc2_:TaskInterface = AUtils.getNewObj("export.taskInterface.TaskInterface") as TaskInterface;
         this.mainSence.addChild(_loc2_);
      }
      
      private function selectRole(param1:*) : *
      {
         this.switchSence("SelectRole");
      }
      
      private function showSelectRolw() : void
      {
         var _loc1_:SelectRole = AUtils.getNewObj("export.SelectRole") as SelectRole;
         this.mainSence.addChild(_loc1_);
      }
      
      private function gameOver(param1:*) : void
      {
         this.switchSence("gameOver");
      }
      
      private function showGameOver() : void
      {
         SoundManager.play("over");
         var _loc1_:GameFail = AUtils.getNewObj("export.lose.GameFail") as GameFail;
         this.mainSence.addChild(_loc1_);
      }
      
      private function reStart(param1:*) : void
      {
         this.switchSence("startFighting");
      }
      
      private function levelVictor(param1:*) : void
      {
         var _loc2_:GameWin = null;
         if(this.mainSence.getChildByName("GameWinHasShow") == null)
         {
            _loc2_ = AUtils.getNewObj("export.win.GameWin") as GameWin;
            _loc2_.name = "GameWinHasShow";
            this.mainSence.addChild(_loc2_);
         }
      }
      
      private function heroDead(param1:CommonEvent) : void
      {
         var e:CommonEvent = param1;
         var afterdead:* = AUtils.getNewObj("PlayerDeadMc");
         afterdead.x = e.data.x;
         afterdead.y = e.data.y;
         this.gc.gameSence.addChild(afterdead);
         if(this.gc.isSingleGame())
         {
            TweenMax.delayedCall(2.5,function():*
            {
               MainGame.getInstance().checkGameOver();
            });
         }
      }
      
      public function startGame(param1:uint, param2:uint) : void
      {
         new MainGame(this.mainSence).GameStart();
      }
      
      private function doLoadOK() : void
      {
         var _loc2_:* = undefined;
         this.gc.pWorld.destroy();
         var _loc1_:int = 0;
         while(_loc1_ < this.numChildren)
         {
            _loc2_ = this.getChildAt(_loc1_);
            this.gc.pWorld.addSubObj(_loc2_);
            _loc1_++;
         }
         this.switchSence("GameMenu");
      }
      
      private function loaderOver(param1:*) : *
      {
         this.gc.eventManger.removeEventListener("loaderOver",this.loaderOver);
         AUtils.checkLoadOK(this,this.doLoadOK);
      }
      
      public function getMainSence() : Sprite
      {
         return this.mainSence;
      }
      
      public function get loader() : Aloader
      {
         return this._loader;
      }
      
      private function netSaveErrorHandler(param1:Event) : void
      {
      }
      
      private function closePanelHandler(param1:*) : void
      {
         var _loc2_:Sprite = null;
         if(this.gc.loginAlert && this.gc.loginAlert.parent)
         {
            this.gc.loginAlert.parent.removeChild(this.gc.loginAlert);
            this.gc.loginAlert = null;
         }
         if(param1 is DataEvent)
         {
            trace("e.data =" + param1.data);
            if(param1.data == 8)
            {
               _loc2_ = this.gc.stage.getChildByName("maskSprite") as Sprite;
               if(_loc2_ && this.gc.stage.contains(_loc2_))
               {
                  this.gc.stage.removeChild(_loc2_);
                  _loc2_ = null;
               }
            }
         }
      }
      
      private function onUserLogOutHandler(param1:*) : void
      {
         try
         {
            this.gc.saveInter.clearTxt();
            if(this.curState != "startFighting")
            {
               this.gc.initData();
            }
            else if(this.curState == "GameMenu")
            {
               this.gc.initData();
               this.gc.ts.setTxt("退出成功");
               this.stage.addChild(this.gc.ts);
            }
            else if(!this.gc.isSingleGame())
            {
               this.gc.closeScoket();
               MainGame.getInstance().destroyMode();
            }
            else
            {
               MainGame.getInstance().destroyMode();
            }
            this.switchSence("GameMenu");
         }
         catch(e:*)
         {
         }
      }
      
      private function onPayEventHandler(param1:PayEvent) : void
      {
         trace("支付事件类型--------->" + param1.type + "  e.data is Boolean------>" + (param1.data is Boolean));
         switch(param1.type)
         {
            case "logsuccess":
               trace("登录成功------>uid:" + param1.data.uid + "  name:" + param1.data.name);
               break;
            case "incMoney":
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  trace("增加游戏币后的余额为：" + param1.data.balance);
                  this.gc.eventManger.dispatchEvent(new CommonEvent("GetMoneySuccess",[param1.data.balance]));
                  break;
               }
               trace("增加游戏币错误！");
               break;
            case "decMoney":
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  trace("减少游戏币后的余额为：" + param1.data.balance);
                  this.gc.ts.setTxt("购买成功");
                  this.gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[param1.data.balance]));
               }
               else
               {
                  trace("减少游戏币错误！");
                  this.gc.ts.setTxt("购买失败");
               }
               this.addChild(this.gc.ts);
               break;
            case "getMoney":
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  trace("获取游戏币余额为：" + param1.data.balance);
                  this.gc.eventManger.dispatchEvent(new CommonEvent("GetMoneySuccess",[param1.data.balance]));
                  break;
               }
               trace("获取游戏币余额错误！");
               break;
            case "payMoney":
               trace("充值游戏币失败");
               break;
            case "payError":
               if(param1.data == null)
               {
                  break;
               }
               trace("使用支付接口其他错误----->" + param1.data.info);
               switch(param1.data.info)
               {
                  case 0:
                     break;
                  case 1:
                     break;
                  case 2:
                     break;
                  case 3:
                     break;
                  case 4:
                     break;
                  case 5:
               }
               this.gc.ts.setTxt("购买失败");
               this.addChild(this.gc.ts);
               break;
         }
      }
   }
}
