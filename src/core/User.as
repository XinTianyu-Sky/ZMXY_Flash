package user
{
   import config.Config;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   
   public class User
   {
      
      public static var batterNum:int;
      
      public static var biggestbatterNum:int;
       
      
      var gc:Config;
      
      public var controlPlayer:int;
      
      private var lhValue1:uint;
      
      private var lhValue2:uint;
      
      private var myscore1:uint;
      
      private var myscore2:uint;
      
      private var curLevel1:uint;
      
      private var curLevel2:uint;
      
      private var curExp1:uint;
      
      private var curExp2:uint;
      
      private var skillLimit1:int;
      
      private var skillLimit2:int;
      
      private var luckdata1:int;
      
      private var luckdata2:int;
      
      public var roleid:uint = 0;
      
      public var tarray:Array;
      
      public var zblist:Array;
      
      public var djlist:Array;
      
      public var szlist:Array;
      
      public var outlist:Array;
      
      public var curarray:Array;
      
      public var isstudyskill:Array;
      
      public var skillbykey:Array;
      
      public var ispassiveskill:Array;
      
      public var saveObj:Object;
      
      private var issaveing:Boolean;
      
      private var savelist:Array;
      
      public var updatalist:Array;
      
      public var exAry:Array;
      
      private var lastsavelen:uint = 0;
      
      public var petsAry:Array;
      
      private var curEquipType:Array;
      
      public function User()
      {
         this.tarray = [];
         this.zblist = [];
         this.djlist = [];
         this.szlist = [];
         this.outlist = [];
         this.curarray = [];
         this.isstudyskill = [{
            "xflevel":0,
            "skillName":""
         },{
            "xflevel":0,
            "skillName":""
         }];
         this.skillbykey = [];
         this.ispassiveskill = [0,0,0,0,0];
         this.saveObj = {};
         this.savelist = new Array();
         this.updatalist = new Array();
         this.exAry = [0,0,0,0];
         this.petsAry = new Array();
         super();
         this.gc = Config.getInstance();
         this.setCurLevel(1);
         this.setCurExp(0);
         this.setSkillLimit(5);
         this.setTadayLuckValue();
      }
      
      public function init(param1:uint) : *
      {
         this.controlPlayer = int(int(param1));
         this.setExAry(this.gc.saveId,this.roleid);
      }
      
      public function getControlPlayer() : int
      {
         return this.controlPlayer;
      }
      
      public function getEquipNum() : Object
      {
         var _loc5_:* = null;
         var _loc1_:* = {
            "zbfj":0,
            "zbwq":0,
            "zbcb":0
         };
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:uint = this.curarray.length;
         while(_loc4_-- > 0)
         {
            _loc5_ = this.curarray[_loc4_];
            if(this.curarray[_loc4_].type == "zbfj")
            {
               _loc3_ = uint(_loc5_.showid);
            }
            if(this.curarray[_loc4_].type == "zbsz")
            {
               _loc2_ = uint(_loc5_.showid);
            }
            if(this.curarray[_loc4_].type == "zbwq")
            {
               _loc1_.zbwq = _loc5_.showid;
            }
            if(this.curarray[_loc4_].type == "zbcb")
            {
               _loc1_.zbcb = _loc5_.showid;
            }
         }
         _loc1_.zbfj = _loc2_ > 0 ? _loc2_ : _loc3_;
         return _loc1_;
      }
      
      public function setLhValue(param1:uint) : void
      {
         this.lhValue1 = uint(uint(AUtils.getRandomValue()));
         this.lhValue2 = uint(uint(param1 - this.lhValue1));
      }
      
      public function getLhValue() : uint
      {
         return this.lhValue1 + this.lhValue2;
      }
      
      public function setMyScore(param1:uint) : void
      {
         this.myscore1 = uint(uint(AUtils.getRandomValue()));
         this.myscore2 = uint(uint(param1 - this.myscore1));
      }
      
      public function getMyScore() : uint
      {
         return this.myscore1 + this.myscore2;
      }
      
      public function setCurLevel(param1:uint) : void
      {
         this.curLevel1 = uint(uint(AUtils.getRandomValue()));
         this.curLevel2 = uint(uint(param1 - this.curLevel1));
      }
      
      public function getCurLevel() : uint
      {
         return this.curLevel1 + this.curLevel2;
      }
      
      public function setCurExp(param1:uint) : void
      {
         this.curExp1 = uint(uint(AUtils.getRandomValue()));
         this.curExp2 = uint(uint(param1 - this.curExp1));
      }
      
      public function getCurExp() : uint
      {
         return this.curExp1 + this.curExp2;
      }
      
      public function setSkillLimit(param1:uint) : void
      {
         this.skillLimit1 = int(int(AUtils.getRandomValue()));
         this.skillLimit2 = int(int(param1 - this.skillLimit1));
      }
      
      public function getSkillLimt() : int
      {
         return this.skillLimit1 + this.skillLimit2;
      }
      
      public function setLuckData(param1:int) : void
      {
         this.luckdata1 = int(int(AUtils.getRandomValue()));
         this.luckdata2 = int(int(param1 - this.luckdata1));
      }
      
      public function getLuckData() : int
      {
         return this.luckdata1 + this.luckdata2;
      }
      
      public function getSomeEquipInPackBackByName(param1:String) : MyEquipObj
      {
         var _loc2_:uint = this.djlist.length;
         while(_loc2_-- > 0)
         {
            if(this.djlist[_loc2_].getFillName() == param1)
            {
               return this.djlist[_loc2_];
            }
         }
         var _loc3_:uint = this.zblist.length;
         while(_loc3_-- > 0)
         {
            if(this.zblist[_loc3_].getFillName() == param1)
            {
               return this.zblist[_loc3_];
            }
         }
         var _loc4_:uint = this.szlist.length;
         while(_loc4_-- > 0)
         {
            if(this.szlist[_loc4_].getFillName() == param1)
            {
               return this.szlist[_loc4_];
            }
         }
         return null;
      }
      
      public function removeSomeEquipFormBack(param1:MyEquipObj) : void
      {
      }
      
      public function getCurEquipByType(param1:String) : MyEquipObj
      {
         var _loc2_:uint = this.curarray.length;
         while(_loc2_-- > 0)
         {
            if(param1 == this.curarray[_loc2_].type)
            {
               return this.curarray[_loc2_];
            }
         }
         return null;
      }
      
      public function getCurFashionEquipFallThingProbability() : Number
      {
         var _loc1_:MyEquipObj = this.getCurEquipByType("zbsz");
         var _loc2_:* = 0;
         if(_loc1_ != null)
         {
            if(_loc1_.getFillName() == "wkwdg" || _loc1_.getFillName() == "tswdg" || _loc1_.getFillName() == "bjwdg")
            {
               _loc2_ = 0.1;
            }
            else if(_loc1_.getFillName() == "wkbsz" || _loc1_.getFillName() == "tsbsz" || _loc1_.getFillName() == "bjbsz")
            {
               _loc2_ = 0.18;
            }
            else if(_loc1_.getFillName() == "wkzyf" || _loc1_.getFillName() == "tszyf" || _loc1_.getFillName() == "bjzyf")
            {
               _loc2_ = 0.2;
            }
         }
         return _loc2_;
      }
      
      public function removeCurEquip(param1:MyEquipObj) : void
      {
         var _loc2_:uint = this.curarray.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.curarray.splice(_loc2_,1);
         }
      }
      
      public function getSomeOneEquipNumberByName(param1:String) : uint
      {
         var _loc4_:* = null;
         var _loc2_:uint = this.djlist.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.djlist[_loc3_];
            if(_loc4_.getFillName() == param1)
            {
               return _loc4_.getENum();
            }
            _loc3_++;
         }
         return 0;
      }
      
      public function setCurrentByType(param1:String, param2:MyEquipObj) : void
      {
         var _loc3_:uint = this.curarray.length;
         while(_loc3_-- > 0)
         {
            if(param1 == this.curarray[_loc3_].type)
            {
               this.curarray[_loc3_] = param2;
            }
         }
      }
      
      public function getBagEquipSaveString() : String
      {
         var _loc1_:* = "";
         var _loc2_:uint = this.zblist.length;
         while(_loc2_-- > 0)
         {
            if(this.zblist[_loc2_])
            {
               _loc1_ += MyEquipObj(this.zblist[_loc2_]).getEquipSaveObj();
               if(_loc2_ != 0)
               {
                  _loc1_ += "}";
               }
            }
         }
         return _loc1_;
      }
      
      public function getCurEquipSaveString() : String
      {
         var _loc1_:* = "";
         var _loc2_:uint = this.curarray.length;
         while(_loc2_-- > 0)
         {
            _loc1_ += MyEquipObj(this.curarray[_loc2_]).getEquipSaveObj();
            if(_loc2_ != 0)
            {
               _loc1_ += "}";
            }
         }
         return _loc1_;
      }
      
      public function getBagDaoJuEquipSaveString() : String
      {
         var _loc1_:* = "";
         var _loc2_:uint = this.djlist.length;
         while(_loc2_-- > 0)
         {
            if(this.djlist[_loc2_])
            {
               _loc1_ += MyEquipObj(this.djlist[_loc2_]).getEquipSaveObj();
               if(_loc2_ != 0)
               {
                  _loc1_ += "}";
               }
            }
         }
         return _loc1_;
      }
      
      public function getBagSZEquipSaveString() : String
      {
         var _loc1_:* = "";
         var _loc2_:uint = this.szlist.length;
         while(_loc2_-- > 0)
         {
            if(this.szlist[_loc2_])
            {
               _loc1_ += MyEquipObj(this.szlist[_loc2_]).getEquipSaveObj();
               if(_loc2_ != 0)
               {
                  _loc1_ += "}";
               }
            }
         }
         return _loc1_;
      }
      
      public function getSaveObj() : Object
      {
         this.saveObj.controlPlayer = this.controlPlayer;
         this.saveObj.lhValue = this.getLhValue();
         this.saveObj.myscore = this.getMyScore();
         this.saveObj.curExp = this.getCurExp();
         this.saveObj.curLevel = this.getCurLevel();
         this.saveObj.skillLimit = this.getSkillLimt();
         this.saveObj.roleid = this.roleid;
         this.saveObj.isstudyskill = this.isstudyskill;
         this.saveObj.skillbykey = this.skillbykey;
         this.saveObj.ispassiveskill = this.ispassiveskill;
         this.saveObj.allTask = this.gc.allTask.saveAllTask();
         this.saveObj.actTask = this.gc.allTask.saveActionTask();
         this.saveObj.saveDate = this.gc.curdate;
         this.saveObj.petSave = this.getPetSaveString();
         this.saveObj.luckdata = this.getLuckData();
         this.saveObj.bagSaveString = this.getBagEquipSaveString();
         this.saveObj.curSaveString = this.getCurEquipSaveString();
         this.saveObj.bagdjSaveString = this.getBagDaoJuEquipSaveString();
         this.saveObj.bagszSaveString = this.getBagSZEquipSaveString();
         return this.saveObj;
      }
      
      public function setSaveObj(param1:Object) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = 0;
         var _loc6_:* = null;
         var _loc7_:* = 0;
         var _loc8_:* = null;
         var _loc9_:* = 0;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         trace("-------setSaveObj-------");
         this.zblist = [];
         this.djlist = [];
         this.szlist = [];
         this.curarray = [];
         this.curEquipType = ["zbwq","zbfj","zbsp","zbfb","zbsz","zbcb"];
         this.controlPlayer = int(int(param1.controlPlayer));
         this.setLhValue(param1.lhValue);
         this.setMyScore(param1.myscore);
         this.setCurExp(param1.curExp);
         this.setCurLevel(param1.curLevel);
         if(this.getCurLevel() > 75)
         {
            this.setCurLevel(75);
            this.setCurExp(0);
         }
         this.setSkillLimit(param1.skillLimit);
         this.roleid = uint(uint(param1.roleid));
         this.isstudyskill = param1.isstudyskill;
         this.skillbykey = param1.skillbykey;
         this.setStrengthLevel();
         this.ispassiveskill = param1.ispassiveskill;
         trace("-------000000000-------");
         this.savePetSaveString(param1.petSave);
         this.setExAry(this.gc.saveId,this.roleid);
         trace("-------111111111-------");
         if(this.gc.curdate == param1.saveDate)
         {
            this.gc.allTask.setAllTask(param1.allTask);
            this.setLuckData(param1.luckdata);
         }
         else
         {
            this.setTadayLuckValue();
         }
         if(param1.actTask != undefined && param1.actTask != "")
         {
            this.gc.allTask.setActTask(param1.actTask);
         }
         trace("-------2222222-------");
         if(param1.bagSaveString != undefined)
         {
            _loc11_ = param1.bagSaveString;
            _loc4_ = _loc11_.split("}");
            _loc2_ = uint(_loc4_.length);
            while(_loc2_-- > 0)
            {
               if(_loc4_[_loc2_] != "")
               {
                  _loc3_ = new MyEquipObj();
                  _loc3_.setEquipSaveObj(_loc4_[_loc2_]);
                  this.zblist.push(_loc3_);
               }
            }
         }
         trace("-------33333333-------");
         if(param1.bagdjSaveString != undefined)
         {
            _loc12_ = param1.bagdjSaveString;
            if(_loc12_.charAt(_loc12_.length - 1) == "}")
            {
               _loc12_ = _loc12_.substr(0,_loc12_.length - 2);
            }
            _loc4_ = _loc12_.split("}");
            _loc5_ = uint(_loc4_.length);
            while(_loc5_-- > 0)
            {
               if(_loc4_[_loc5_] != "")
               {
                  _loc6_ = new MyEquipObj();
                  _loc6_.setEquipSaveObj(_loc12_.split("}")[_loc5_]);
                  this.djlist.push(_loc6_);
               }
            }
         }
         trace("-------44444444444-------");
         if(param1.bagszSaveString != undefined)
         {
            _loc13_ = param1.bagszSaveString;
            if(_loc13_.charAt(_loc13_.length - 1) == "}")
            {
               _loc13_ = _loc13_.substr(0,_loc13_.length - 2);
            }
            _loc4_ = _loc13_.split("}");
            _loc7_ = uint(_loc4_.length);
            while(_loc7_-- > 0)
            {
               if(_loc4_[_loc7_] != "")
               {
                  _loc8_ = new MyEquipObj();
                  _loc8_.setEquipSaveObj(_loc13_.split("}")[_loc7_]);
                  this.szlist.push(_loc8_);
               }
            }
         }
         trace("-------55555555-------");
         if(param1.curSaveString != undefined)
         {
            _loc14_ = param1.curSaveString;
            if(_loc14_.charAt(_loc14_.length - 1) == "}")
            {
               _loc14_ = _loc14_.substr(0,_loc14_.length - 2);
            }
            _loc4_ = _loc14_.split("}");
            _loc9_ = uint(_loc4_.length);
            _loc15_ = 0;
            while(_loc15_ < _loc9_)
            {
               if(_loc4_[_loc15_] != "")
               {
                  _loc10_ = new MyEquipObj();
                  _loc10_.setEquipSaveObj(_loc14_.split("}")[_loc15_]);
                  if(this.curEquipType.length > 0)
                  {
                     if(_loc10_.type)
                     {
                        _loc16_ = this.curEquipType.indexOf(_loc10_.type);
                        if(_loc16_ != -1)
                        {
                           this.curarray.push(_loc10_);
                           this.curEquipType.splice(_loc16_,1);
                        }
                        else
                        {
                           this.zblist.push(_loc10_);
                        }
                     }
                  }
               }
               _loc15_++;
            }
         }
         trace("-------666666666-------");
      }
      
      private function setStrengthLevel() : void
      {
         var _loc1_:uint = this.skillbykey.length;
         while(_loc1_-- > 0)
         {
            if(this.skillbykey.slev == undefined)
            {
               this.skillbykey.slev = AUtils.enCurHas(1);
            }
         }
      }
      
      private function setTadayLuckValue() : void
      {
         if(this.getCurLevel() <= 4)
         {
            this.setLuckData(1 + Math.round(Math.random() * 4));
         }
         else if(this.getCurLevel() >= 5 && this.getCurLevel() <= 10)
         {
            this.setLuckData(1 + Math.round(Math.random() * 9));
         }
         else
         {
            this.setLuckData(1 + Math.round(Math.random() * 19));
         }
      }
      
      private function getPetSaveString() : String
      {
         var _loc1_:uint = this.petsAry.length;
         var _loc2_:* = "";
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ += PetInfo(this.petsAry[_loc3_]).getSaveString();
            if(_loc3_ != _loc1_ - 1)
            {
               _loc2_ += "}";
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function savePetSaveString(param1:String) : void
      {
         var _loc4_:* = 0;
         var _loc5_:* = null;
         var _loc2_:Array = param1.split("}");
         var _loc3_:uint = _loc2_.length;
         while(_loc3_-- > 0)
         {
            if(_loc2_[_loc3_] != "")
            {
               _loc4_ = uint(this.petsAry.length);
               if(_loc4_ < 5)
               {
                  _loc5_ = new PetInfo();
                  _loc5_.setSaveString(_loc2_[_loc3_]);
                  this.petsAry.push(_loc5_);
               }
            }
         }
      }
      
      public function setExAry(param1:int = -1, param2:int = -1, param3:int = -1) : void
      {
         if(param1 != -1)
         {
            this.exAry[0] = param1;
         }
         if(param2 != -1)
         {
            this.exAry[1] = param2;
         }
         if(param3 != -1)
         {
            this.exAry[2] = param3;
         }
      }
      
      public function getRoleName() : String
      {
         var _loc1_:String = "";
         if(this.roleid == 1)
         {
            _loc1_ = "孙悟空";
         }
         else if(this.roleid == 2)
         {
            _loc1_ = "唐僧";
         }
         else if(this.roleid == 3)
         {
            _loc1_ = "八戒";
         }
         else if(this.roleid == 4)
         {
            _loc1_ = "沙僧";
         }
         return _loc1_;
      }
      
      public function returnSkillNameBySkillKey(param1:String) : Array
      {
         var _loc2_:uint = this.skillbykey.length;
         while(_loc2_-- > 0)
         {
            if(this.skillbykey[_loc2_].keys == param1)
            {
               return [this.skillbykey[_loc2_].skillName,this.skillbykey[_loc2_].needLh,AUtils.deCurHas(this.skillbykey[_loc2_].slev) / 100];
            }
         }
         return null;
      }
      
      public function returnSkillObjBySkillKey(param1:String) : Object
      {
         var _loc2_:uint = this.skillbykey.length;
         while(_loc2_-- > 0)
         {
            if(this.skillbykey[_loc2_].keys == param1)
            {
               return this.skillbykey[_loc2_];
            }
         }
         return null;
      }
      
      public function findSkillIsInTheSkillAry(param1:String) : Boolean
      {
         var _loc2_:uint = this.skillbykey.length;
         while(_loc2_-- > 0)
         {
            if(this.skillbykey[_loc2_].skillName == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function returnSkillIsInTheSkillAry(param1:String) : Object
      {
         var _loc2_:uint = this.skillbykey.length;
         while(_loc2_-- > 0)
         {
            if(this.skillbykey[_loc2_].skillName == param1)
            {
               return this.skillbykey[_loc2_];
            }
         }
         return null;
      }
      
      public function findCurrentPet(param1:Boolean = false) : PetInfo
      {
         var _loc2_:uint = this.petsAry.length;
         while(_loc2_-- > 0)
         {
            if(this.petsAry[_loc2_].isFight == 1)
            {
               if(this.petsAry[_loc2_].getlifetime() > 0)
               {
                  return this.petsAry[_loc2_];
               }
               if(param1)
               {
                  return this.petsAry[_loc2_];
               }
            }
         }
         return null;
      }
      
      public function findBiggestPetLevel() : int
      {
         var _loc1_:int = 0;
         var _loc2_:uint = this.petsAry.length;
         while(_loc2_-- > 0)
         {
            _loc1_ = PetInfo(this.petsAry[_loc2_]).getLevel() > _loc1_ ? int(PetInfo(this.petsAry[_loc2_]).getLevel()) : int(_loc1_);
         }
         return _loc1_;
      }
      
      public function catchNewPet(param1:String, param2:uint = 1) : Boolean
      {
         var _loc3_:uint = this.petsAry.length;
         if(_loc3_ >= 1 + int(this.getCurLevel() / 10) || _loc3_ >= 5)
         {
            return false;
         }
         var _loc4_:PetInfo = new PetInfo();
         _loc4_.setPetNameAndLevel(param1,param2);
         this.petsAry.push(_loc4_);
         return true;
      }
      
      public function howMuchSkillHasYouStudy() : uint
      {
         var _loc1_:* = null;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         while(_loc3_ < 2)
         {
            _loc1_ = String(this.isstudyskill[_loc3_].skillName).split("|");
            _loc2_ = uint(_loc2_ + (_loc1_.length - 1));
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function findWhichSkillBtnNoneSet() : String
      {
         var _loc4_:int = 0;
         var _loc1_:String = "";
         var _loc2_:* = [];
         if(this.controlPlayer == 0)
         {
            _loc2_ = ["Y","U","I","O","L"];
         }
         else
         {
            _loc2_ = ["8","4","5","6","3"];
         }
         var _loc3_:uint = this.skillbykey.length;
         while(_loc3_-- > 0)
         {
            if(this.skillbykey[_loc3_])
            {
               _loc4_ = _loc2_.indexOf(this.skillbykey[_loc3_].keys);
               if(_loc4_ != -1)
               {
                  _loc2_.splice(_loc4_,1);
               }
            }
         }
         if(_loc2_[0])
         {
            _loc1_ = _loc2_[0];
         }
         return _loc1_;
      }
      
      public function reSetAllPetState() : void
      {
         var _loc1_:uint = this.petsAry.length;
         while(_loc1_-- > 0)
         {
            PetInfo(this.petsAry[_loc1_]).reSetPetState();
         }
      }
   }
}
