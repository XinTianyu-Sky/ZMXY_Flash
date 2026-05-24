package my
{
   import base.BaseHero;
   import config.Config;
   import myanalysis.MyAllEquipId;
   
   public class MyEquipObj
   {
       
      
      private var gc:Config;
      
      private var meid:MyAllEquipId;
      
      private var backpackid:uint = 0;
      
      public var showid:uint = 1;
      
      public var ename:String = "";
      
      private var fillName1:String = "";
      
      private var fillName2:String = "";
      
      private var fillName3:Array;
      
      public var type:String = "";
      
      public var user:String = "";
      
      public var quality:String = "";
      
      public var color;
      
      private var ehp1:int = 0;
      
      private var ehp2:int = 0;
      
      private var ehp3:Number = 0.0;
      
      private var emp1:int = 0;
      
      private var emp2:int = 0;
      
      private var emp3:Number = 0.0;
      
      private var eatt1:int = 0;
      
      private var eatt2:int = 0;
      
      private var eatt3:Number = 0.0;
      
      private var edef1:int = 0;
      
      private var edef2:int = 0;
      
      private var edef3:Number = 0.0;
      
      private var emiss1:Number = 0.0;
      
      private var emiss2:Number = 0.0;
      
      private var emiss3:Number = 0.0;
      
      private var ecrit1:Number = 0.0;
      
      private var ecrit2:Number = 0.0;
      
      private var ecrit3:Number = 0.0;
      
      private var eahp1:int = 0;
      
      private var eahp2:int = 0;
      
      private var eahp3:Number = 0.0;
      
      private var eamp1:int = 0;
      
      private var eamp2:int = 0;
      
      private var eamp3:Number = 0.0;
      
      private var eatblood1:Number = 0.0;
      
      private var eatblood2:Number = 0.0;
      
      private var eatblood3:Number = 0.0;
      
      private var magicdef1:Number = 0.0;
      
      private var magicdef2:Number = 0.0;
      
      private var magicdef3:Number = 0.0;
      
      private var deephit1:Number = 0.0;
      
      private var deephit2:Number = 0.0;
      
      private var deephit3:Number = 0.0;
      
      public var aStrengthen:Object;
      
      public var etype:String;
      
      public var instruction:String = "";
      
      public var value1:int;
      
      public var value2:int;
      
      public var value3:Number;
      
      private var num1:int;
      
      private var num2:int;
      
      private var num3:Number;
      
      public var isstrskill:Boolean = false;
      
      private var jin:Boolean = false;
      
      private var mu:Boolean = false;
      
      private var shui:Boolean = false;
      
      private var huo:Boolean = false;
      
      private var tu:Boolean = false;
      
      private var elevel1:int;
      
      private var elevel2:int;
      
      private var elevel3:Number;
      
      private var eupdata1:Number;
      
      private var eupdata2:Number;
      
      private var eupdata3:Number;
      
      private var strengthValue1:int = 0;
      
      private var strengthValue2:int = 0;
      
      private var strengthValue3:Number = 0.0;
      
      private var shpVal1:int;
      
      private var shpVal2:int;
      
      private var shpVal3:Number;
      
      private var smpVal1:int;
      
      private var smpVal2:int;
      
      private var smpVal3:Number;
      
      private var satkVal1:int;
      
      private var satkVal2:int;
      
      private var satkVal3:Number;
      
      private var sdefVal1:int;
      
      private var sdefVal2:int;
      
      private var sdefVal3:Number;
      
      private var scritVal1:Number;
      
      private var scritVal2:Number;
      
      private var scritVal3:Number;
      
      private var smissVal1:Number;
      
      private var smissVal2:Number;
      
      private var smissVal3:Number;
      
      private var sehpVal1:int;
      
      private var sehpVal2:int;
      
      private var sehpVal3:Number;
      
      private var sempVal1:int;
      
      private var sempVal2:int;
      
      private var sempVal3:Number;
      
      private var sebolVal1:Number;
      
      private var sebolVal2:Number;
      
      private var sebolVal3:Number;
      
      private var smdefVal1:Number;
      
      private var smdefVal2:Number;
      
      private var smdefVal3:Number;
      
      private var sdhitVal1:Number;
      
      private var sdhitVal2:Number;
      
      private var sdhitVal3:Number;
      
      public function MyEquipObj(param1:uint = 0, param2:String = "", param3:String = "", param4:String = "", param5:String = "", param6:String = "", param7:* = null, param8:int = 0, param9:int = 0, param10:int = 0, param11:int = 0, param12:Number = 0.0, param13:Number = 0.0, param14:int = 0, param15:int = 0, param16:Number = 0.0, param17:Number = 0.0, param18:Number = 0.0, param19:Object = null, param20:String = "", param21:Object = null, param22:Object = null)
      {
         this.fillName3 = [];
         this.aStrengthen = {};
         super();
         this.gc = Config.getInstance();
         this.meid = MyAllEquipId.getInstance();
         this.showid = param1;
         this.ename = param2;
         this.setFillName(param3);
         this.type = param4;
         this.user = param5;
         this.quality = param6;
         this.color = param7;
         this.setehp(param8);
         this.setemp(param9);
         this.seteatt(param10);
         this.setedef(param11);
         this.setecrit(param12);
         this.setemiss(param13);
         this.seteahp(param14);
         this.seteamp(param15);
         this.seteatblood(param16);
         this.setmagicdef(param17);
         this.setdeephit(param18);
         this.setnum(1);
         this.setstrengthValue(0);
         this.instruction = param20;
         if(param19 != null)
         {
            this.aStrengthen = param19;
         }
         if(param21 != null)
         {
            this.setELevel(int(param21.elevel));
            this.setEupdata(Number(param21.eupdata));
         }
         else
         {
            this.setELevel(0);
            this.setEupdata(0);
         }
         if(param22 != null)
         {
            this.jin = Boolean(param22.jin);
            this.mu = Boolean(param22.mu);
            this.shui = Boolean(param22.shui);
            this.huo = Boolean(param22.huo);
            this.tu = Boolean(param22.tu);
         }
         this.trans(param4);
         this.transValue();
         this.strengthenEquip();
      }
      
      public function setFaBaoStreng() : void
      {
         this.isstrskill = true;
      }
      
      private function strengthenEquip() : void
      {
         if(this.aStrengthen.att != undefined)
         {
            this.setSatkValue(this.getStrengthValue() * this.aStrengthen.att);
         }
         else
         {
            this.setSatkValue(0);
         }
         if(this.aStrengthen.def != undefined)
         {
            this.setSdefValue(this.getStrengthValue() * this.aStrengthen.def);
         }
         else
         {
            this.setSdefValue(0);
         }
         if(this.aStrengthen.hp != undefined)
         {
            this.setShpValue(this.getStrengthValue() * this.aStrengthen.hp);
         }
         else
         {
            this.setShpValue(0);
         }
         if(this.aStrengthen.mp != undefined)
         {
            this.setSmpValue(this.getStrengthValue() * this.aStrengthen.mp);
         }
         else
         {
            this.setSmpValue(0);
         }
         if(this.aStrengthen.crit != undefined)
         {
            this.setScritValue(this.getStrengthValue() * this.aStrengthen.crit);
         }
         else
         {
            this.setScritValue(0);
         }
         if(this.aStrengthen.miss != undefined)
         {
            this.setSmissValue(this.getStrengthValue() * this.aStrengthen.miss);
         }
         else
         {
            this.setSmissValue(0);
         }
         if(this.aStrengthen.ehp != undefined)
         {
            this.setSehpValue(this.getStrengthValue() * this.aStrengthen.ehp);
         }
         else
         {
            this.setSehpValue(0);
         }
         if(this.aStrengthen.emp != undefined)
         {
            this.setSempValue(this.getStrengthValue() * this.aStrengthen.emp);
         }
         else
         {
            this.setSempValue(0);
         }
         if(this.aStrengthen.mdef != undefined)
         {
            this.setSmdefValue(this.getStrengthValue() * this.aStrengthen.mdef);
         }
         else
         {
            this.setSmdefValue(0);
         }
         if(this.aStrengthen.ebol != undefined)
         {
            this.setSebolValue(this.getStrengthValue() * this.aStrengthen.ebol);
         }
         else
         {
            this.setSebolValue(0);
         }
         if(this.aStrengthen.dhit != undefined)
         {
            this.setSdhitValue(this.getStrengthValue() * this.aStrengthen.dhit);
         }
         else
         {
            this.setSdhitValue(0);
         }
      }
      
      public function upStrengthValue(param1:int) : void
      {
         this.setstrengthValue(this.getStrengthValue() + param1);
         this.strengthenEquip();
      }
      
      public function setNum(param1:int) : void
      {
         this.setnum(this.getENum() + param1);
      }
      
      public function getbackpackid() : int
      {
         return this.backpackid;
      }
      
      public function setbackpackid(param1:int) : void
      {
         this.backpackid = param1;
      }
      
      private function trans(param1:String) : void
      {
         switch(param1)
         {
            case "zbfj":
               this.etype = "防具";
               break;
            case "zbwq":
               this.etype = "武器";
               break;
            case "zbsp":
               this.etype = "饰品";
               break;
            case "zbfb":
               this.etype = "法宝";
               break;
            case "zbsz":
               this.etype = "时装";
               break;
            case "wpqhs":
               this.etype = "强化石";
               break;
            case "zbwp":
               if(this.getFillName() == "wpxyf")
               {
                  this.etype = "幸运符";
               }
               else if(this.getFillName() == "wpbdf")
               {
                  this.etype = "神恩符";
               }
               else if(this.getFillName().indexOf("sms") != -1 || this.getFillName().indexOf("mfs") != -1 || this.getFillName().indexOf("fys") != -1 || this.getFillName().indexOf("gjs") != -1 || this.getFillName().indexOf("tlz") != -1 || this.getFillName().indexOf("llz") != -1 || this.getFillName().indexOf("hlz") != -1 || this.getFillName().indexOf("flz") != -1 || this.getFillName().indexOf("slz") != -1)
               {
                  this.etype = "宝石";
               }
               else if(this.getFillName() == "wpsc" || this.getFillName() == "wpxt" || this.getFillName() == "wptm" || this.getFillName() == "wpxh")
               {
                  this.etype = "材料";
               }
               else if(this.getFillName().indexOf("zzs") != -1)
               {
                  this.etype = "制作书";
               }
               else if(this.getFillName() == "mpyj" || this.getFillName() == "wphhd" || this.getFillName() == "wpcsd")
               {
                  this.etype = "道具";
               }
         }
      }
      
      private function transValue() : void
      {
         switch(this.quality)
         {
            case "粗 糙":
               this.setValue(10);
               break;
            case "普 通":
               this.setValue(20);
               break;
            case "优 秀":
               this.setValue(40);
               break;
            case "精 良":
               this.setValue(80);
               break;
            case "史 诗":
               this.setValue(160);
               break;
            case "传 说":
               this.setValue(320);
            case "邪 灵":
               this.setValue(640);
         }
      }
      
      public function getWX() : String
      {
         var _loc1_:* = "";
         if(this.jin)
         {
            _loc1_ += "金 ";
         }
         if(this.mu)
         {
            _loc1_ += "木 ";
         }
         if(this.shui)
         {
            _loc1_ += "水 ";
         }
         if(this.huo)
         {
            _loc1_ += "火 ";
         }
         if(this.tu)
         {
            _loc1_ += "土 ";
         }
         return _loc1_;
      }
      
      public function growth(param1:Object, param2:Boolean = true) : void
      {
         if(param2)
         {
            this.setELevel(this.getELevel() + 1);
         }
         if(this.jin)
         {
            this.seteatt(this.geteatt(true) + (param1.fatk + Math.floor(param1.fatk * this.getEUpdata())));
         }
         else
         {
            this.seteatt(this.geteatt(true) + Math.floor(param1.fatk * this.getEUpdata()));
         }
         if(!this.mu)
         {
         }
         if(this.shui)
         {
            this.setemp(this.getemp(true) + (param1.fmp + Math.floor(param1.fmp * this.getEUpdata())));
         }
         else
         {
            this.setemp(this.getemp(true) + Math.floor(param1.fmp * this.getEUpdata()));
         }
         if(this.huo)
         {
            this.setehp(this.getehp(true) + (param1.fhp + Math.floor(param1.fhp * this.getEUpdata())));
         }
         else
         {
            this.setehp(this.getehp(true) + Math.floor(param1.fhp * this.getEUpdata()));
         }
         if(this.tu)
         {
            this.setedef(this.getedef(true) + (param1.fdef + Math.floor(param1.fdef * this.getEUpdata())));
         }
         else
         {
            this.setedef(this.getedef(true) + Math.floor(param1.fdef * this.getEUpdata()));
         }
         var _loc3_:uint = this.gc.getPlayerArray().length;
         while(_loc3_-- > 0)
         {
            BaseHero(this.gc.getPlayerArray()[_loc3_]).updateMagicWeapon();
         }
      }
      
      public function getGrowthByName(param1:String) : Object
      {
         var _loc2_:Object = {
            "fhp":0,
            "fmp":0,
            "fatk":0,
            "fdef":0
         };
         switch(param1)
         {
            case "kyl":
               _loc2_ = {
                  "fhp":20,
                  "fmp":20,
                  "fatk":4,
                  "fdef":2
               };
               break;
            case "xhhl":
               _loc2_ = {
                  "fhp":30,
                  "fmp":30,
                  "fatk":5,
                  "fdef":2
               };
               break;
            case "qyj":
               _loc2_ = {
                  "fhp":30,
                  "fmp":50,
                  "fatk":5,
                  "fdef":2
               };
               break;
            case "hyzzs":
               _loc2_ = {
                  "fhp":50,
                  "fmp":30,
                  "fatk":5,
                  "fdef":4
               };
               break;
            case "zjld":
               _loc2_ = {
                  "fhp":30,
                  "fmp":30,
                  "fatk":9,
                  "fdef":2
               };
         }
         return _loc2_;
      }
      
      public function getEquipSaveObj() : String
      {
         return this.showid + "|" + this.ename + "|" + this.getFillName() + "|" + this.type + "|" + this.user + "|" + this.quality + "|" + this.color + "|" + this.getehp(true) + "|" + this.getemp(true) + "|" + this.geteatt(true) + "|" + this.getedef(true) + "|" + this.getemiss(true) + "|" + this.getecrit(true) + "|" + this.geteahp(true) + "|" + this.geteamp(true) + "|" + this.jin + "|" + this.mu + "|" + this.shui + "|" + this.huo + "|" + this.tu + "|" + this.getELevel() + "|" + this.getEUpdata() + "|" + this.getENum() + "|" + this.getStrengthValue() + "|" + this.getmagicdef(true) + "|" + this.geteatblood(true) + "|" + this.getdeephit(true);
      }
      
      public function setEquipSaveObj(param1:*) : void
      {
         var _loc2_:Array = param1.split("|");
         this.showid = int(_loc2_[0]);
         this.ename = _loc2_[1];
         this.setFillName(_loc2_[2]);
         this.type = _loc2_[3];
         this.user = _loc2_[4];
         this.quality = _loc2_[5];
         this.color = _loc2_[6];
         this.setehp(int(_loc2_[7]));
         this.setemp(int(_loc2_[8]));
         this.seteatt(int(_loc2_[9]));
         this.setedef(int(_loc2_[10]));
         this.setemiss(Number(_loc2_[11]));
         this.setecrit(Number(_loc2_[12]));
         this.seteahp(int(_loc2_[13]));
         this.seteamp(int(_loc2_[14]));
         if(_loc2_[15] == "false" || _loc2_[15] == false)
         {
            this.jin = false;
         }
         else
         {
            this.jin = true;
         }
         if(_loc2_[16] == "false" || _loc2_[16] == false)
         {
            this.mu = false;
         }
         else
         {
            this.mu = true;
         }
         if(_loc2_[17] == "false" || _loc2_[17] == false)
         {
            this.shui = false;
         }
         else
         {
            this.shui = true;
         }
         if(_loc2_[18] == "false" || _loc2_[18] == false)
         {
            this.huo = false;
         }
         else
         {
            this.huo = true;
         }
         if(_loc2_[19] == "false" || _loc2_[19] == false)
         {
            this.tu = false;
         }
         else
         {
            this.tu = true;
         }
         this.setELevel(int(_loc2_[20]));
         this.setEupdata(Number(_loc2_[21]));
         this.setnum(int(_loc2_[22]));
         this.setstrengthValue(int(_loc2_[23]));
         this.setmagicdef(Number(_loc2_[24]));
         this.seteatblood(Number(_loc2_[25]));
         this.setdeephit(Number(_loc2_[26]));
         var _loc3_:MyEquipObj = this.gc.allEquip.findByName(this.getFillName());
         this.instruction = _loc3_.instruction;
         this.trans(_loc3_.type);
         this.transValue();
         this.aStrengthen = _loc3_.aStrengthen;
         this.strengthenEquip();
      }
      
      public function setFillName(param1:String) : void
      {
         var _loc2_:uint = param1.length;
         var _loc3_:uint = Math.round(Math.random() * _loc2_);
         this.fillName1 = param1.substr(0,_loc3_);
         this.fillName2 = param1.substr(_loc3_,_loc2_ - _loc3_);
         this.fillName3 = this.enCodeString(param1);
      }
      
      public function getFillName() : String
      {
         if(this.fillName1 + this.fillName2 != this.getDeCodeString(this.fillName3))
         {
            throw new Error("数据被修改！");
         }
         return this.fillName1 + this.fillName2;
      }
      
      public function setEupdata(param1:Number) : void
      {
         var _loc2_:Number = (1 + Math.round(Math.random() * 4)) / 100;
         this.eupdata1 = AUtils.numberSub(param1,_loc2_,2);
         this.eupdata2 = AUtils.changeNumber(_loc2_,2);
         this.eupdata3 = this.enCodeNumber(param1);
      }
      
      public function getEUpdata() : Number
      {
         var _loc1_:Number = AUtils.numberAdd(this.eupdata1,this.eupdata2,2);
         if(_loc1_ != this.getDeCodeNumber(this.eupdata3))
         {
            throw new Error("数据被修改！");
         }
         return _loc1_;
      }
      
      public function setELevel(param1:int) : void
      {
         var _loc2_:uint = 20 + Math.round(Math.random() * 30);
         this.elevel1 = param1 - _loc2_;
         this.elevel2 = _loc2_;
         this.elevel3 = this.enCodeValue(param1);
      }
      
      public function getELevel() : int
      {
         if(this.elevel1 + this.elevel2 != this.getDeCodeValue(this.elevel3))
         {
            throw new Error("数据被修改！");
         }
         return this.elevel1 + this.elevel2;
      }
      
      public function setnum(param1:int) : void
      {
         var _loc2_:uint = 20 + Math.round(Math.random() * 30);
         this.num1 = param1 - _loc2_;
         this.num2 = _loc2_;
         this.num3 = this.enCodeValue(param1);
      }
      
      public function getENum() : uint
      {
         if(this.num1 + this.num2 != this.getDeCodeValue(this.num3))
         {
            throw new Error("数据被修改！");
         }
         if(this.findUsedByShowId() == "bs")
         {
            if(this.isCanFallInGame())
            {
               return this.num1 + this.num2;
            }
            if(this.num1 + this.num2 < 88)
            {
               return this.num1 + this.num2;
            }
            this.setnum(10);
            this.addInfo("道具数量");
            return 10;
         }
         return this.num1 + this.num2;
      }
      
      private function addInfo(param1:String = "") : void
      {
         trace("数据异常，请联系客服");
         this.gc.ts.setTxt(param1 + "数据异常，有疑问请联系客服");
         this.gc.stage.addChild(this.gc.ts);
      }
      
      public function setehp(param1:int) : void
      {
         var _loc2_:uint = 20 + Math.round(Math.random() * 30);
         this.ehp1 = param1 - _loc2_;
         this.ehp2 = _loc2_;
         this.ehp3 = this.enCodeValue(param1);
      }
      
      public function getehp(param1:Boolean = false) : int
      {
         if(this.ehp1 + this.ehp2 != this.getDeCodeValue(this.ehp3))
         {
            throw new Error("数据被修改！");
         }
         if(!param1)
         {
            if(this.ehp1 + this.ehp2 + this.getShpValue() < 4014)
            {
               return this.ehp1 + this.ehp2 + this.getShpValue();
            }
            this.addInfo("装备血量");
            return 1;
         }
         return this.ehp1 + this.ehp2;
      }
      
      public function setemp(param1:int) : void
      {
         var _loc2_:uint = 20 + Math.round(Math.random() * 30);
         this.emp1 = param1 - _loc2_;
         this.emp2 = _loc2_;
         this.emp3 = this.enCodeValue(param1);
      }
      
      public function getemp(param1:Boolean = false) : int
      {
         if(this.emp1 + this.emp2 != this.getDeCodeValue(this.emp3))
         {
            throw new Error("数据被修改！");
         }
         if(!param1)
         {
            if(this.emp1 + this.emp2 + this.getSmpValue() < 4012)
            {
               return this.emp1 + this.emp2 + this.getSmpValue();
            }
            this.addInfo("装备魔法");
            return 1;
         }
         return this.emp1 + this.emp2;
      }
      
      public function seteatt(param1:int) : void
      {
         var _loc2_:uint = 20 + Math.round(Math.random() * 30);
         this.eatt1 = param1 - _loc2_;
         this.eatt2 = _loc2_;
         this.eatt3 = this.enCodeValue(param1);
      }
      
      public function geteatt(param1:Boolean = false) : int
      {
         if(this.eatt1 + this.eatt2 != this.getDeCodeValue(this.eatt3))
         {
            throw new Error("数据被修改！");
         }
         if(!param1)
         {
            if(this.eatt1 + this.eatt2 + this.getSatkValue() < 2012)
            {
               return this.eatt1 + this.eatt2 + this.getSatkValue();
            }
            this.addInfo("装备攻击");
            return 1;
         }
         return this.eatt1 + this.eatt2;
      }
      
      public function setedef(param1:int) : void
      {
         var _loc2_:uint = 20 + Math.round(Math.random() * 30);
         this.edef1 = param1 - _loc2_;
         this.edef2 = _loc2_;
         this.edef3 = this.enCodeValue(param1);
      }
      
      public function getedef(param1:Boolean = false) : int
      {
         if(this.edef1 + this.edef2 != this.getDeCodeValue(this.edef3))
         {
            throw new Error("数据被修改！");
         }
         if(!param1)
         {
            if(this.edef1 + this.edef2 + this.getSdefValue() < 2012)
            {
               return this.edef1 + this.edef2 + this.getSdefValue();
            }
            this.addInfo("装备防御");
            return 1;
         }
         return this.edef1 + this.edef2;
      }
      
      public function setValue(param1:int) : void
      {
         var _loc2_:uint = 30 + Math.round(Math.random() * 20);
         this.value1 = param1 - _loc2_;
         this.value2 = _loc2_;
         this.value3 = this.enCodeValue(param1);
      }
      
      public function getValue() : int
      {
         if(this.value1 + this.value2 != this.getDeCodeValue(this.value3))
         {
            throw new Error("数据被修改！");
         }
         return this.value1 + this.value2;
      }
      
      public function setemiss(param1:Number) : void
      {
         var _loc2_:Number = (1 + Math.round(Math.random() * 4)) / 100;
         this.emiss1 = AUtils.numberSub(param1,_loc2_,2);
         this.emiss2 = AUtils.changeNumber(_loc2_,2);
         this.emiss3 = this.enCodeNumber(param1);
      }
      
      public function getemiss(param1:Boolean = false) : Number
      {
         var _loc2_:Number = AUtils.numberAdd(this.emiss1,this.emiss2,2);
         if(_loc2_ != this.getDeCodeNumber(this.emiss3))
         {
            throw new Error("数据被修改！");
         }
         if(!param1)
         {
            return AUtils.numberAdd(_loc2_,this.getSmissValue(),2);
         }
         return _loc2_;
      }
      
      public function setecrit(param1:Number) : void
      {
         var _loc2_:Number = (1 + Math.round(Math.random() * 4)) / 100;
         this.ecrit1 = AUtils.numberSub(param1,_loc2_,2);
         this.ecrit2 = AUtils.changeNumber(_loc2_,2);
         this.ecrit3 = this.enCodeNumber(param1);
      }
      
      public function getecrit(param1:Boolean = false) : Number
      {
         var _loc2_:Number = AUtils.numberAdd(this.ecrit1,this.ecrit2,2);
         if(_loc2_ != this.getDeCodeNumber(this.ecrit3))
         {
            throw new Error("数据被修改！");
         }
         if(!param1)
         {
            return AUtils.numberAdd(_loc2_,this.getScritValue(),2);
         }
         return _loc2_;
      }
      
      public function seteahp(param1:int) : void
      {
         var _loc2_:uint = 10 + Math.round(Math.random() * 10);
         this.eahp1 = param1 - _loc2_;
         this.eahp2 = _loc2_;
         this.eahp3 = this.enCodeValue(param1);
      }
      
      public function geteahp(param1:Boolean = false) : int
      {
         if(this.eahp1 + this.eahp2 != this.getDeCodeValue(this.eahp3))
         {
            throw new Error("数据被修改！");
         }
         if(!param1)
         {
            if(this.eahp1 + this.eahp2 + this.getSehpValue() < 88)
            {
               return this.eahp1 + this.eahp2 + this.getSehpValue();
            }
            this.addInfo("装备回血");
            return 1;
         }
         return this.eahp1 + this.eahp2;
      }
      
      public function seteamp(param1:int) : void
      {
         var _loc2_:uint = 10 + Math.round(Math.random() * 10);
         this.eamp1 = param1 - _loc2_;
         this.eamp2 = _loc2_;
         this.eamp3 = this.enCodeValue(param1);
      }
      
      public function geteamp(param1:Boolean = false) : int
      {
         if(this.eamp1 + this.eamp2 != this.getDeCodeValue(this.eamp3))
         {
            throw new Error("数据被修改！");
         }
         if(!param1)
         {
            if(this.eamp1 + this.eamp2 + this.getSempValue() < 88)
            {
               return this.eamp1 + this.eamp2 + this.getSempValue();
            }
            this.addInfo("装备回魔");
            return 1;
         }
         return this.eamp1 + this.eamp2;
      }
      
      public function seteatblood(param1:Number) : void
      {
         var _loc2_:Number = (1 + Math.round(Math.random() * 4)) / 100;
         this.eatblood1 = AUtils.numberSub(param1,_loc2_,2);
         this.eatblood2 = AUtils.changeNumber(_loc2_,2);
         this.eatblood3 = this.enCodeNumber(param1);
      }
      
      public function geteatblood(param1:Boolean = false) : Number
      {
         var _loc2_:Number = AUtils.numberAdd(this.eatblood1,this.eatblood2,2);
         if(_loc2_ != this.getDeCodeNumber(this.eatblood3))
         {
            throw new Error("数据被修改！");
         }
         if(!param1)
         {
            return AUtils.numberAdd(_loc2_,this.getSebloValue(),2);
         }
         return _loc2_;
      }
      
      public function setmagicdef(param1:Number) : void
      {
         var _loc2_:Number = (1 + Math.round(Math.random() * 4)) / 100;
         this.magicdef1 = AUtils.numberSub(param1,_loc2_,2);
         this.magicdef2 = AUtils.changeNumber(_loc2_,2);
         this.magicdef3 = this.enCodeNumber(param1);
      }
      
      public function getmagicdef(param1:Boolean = false) : Number
      {
         var _loc2_:Number = AUtils.numberAdd(this.magicdef1,this.magicdef2,2);
         if(_loc2_ != this.getDeCodeNumber(this.magicdef3))
         {
            throw new Error("数据被修改！");
         }
         if(!param1)
         {
            return AUtils.numberAdd(_loc2_,this.getSmdefValue(),2);
         }
         return _loc2_;
      }
      
      public function setdeephit(param1:Number) : void
      {
         var _loc2_:Number = (1 + Math.round(Math.random() * 4)) / 100;
         this.deephit1 = AUtils.numberSub(param1,_loc2_,2);
         this.deephit2 = AUtils.changeNumber(_loc2_,2);
         this.deephit3 = this.enCodeNumber(param1);
      }
      
      public function getdeephit(param1:Boolean = false) : Number
      {
         var _loc2_:Number = AUtils.numberAdd(this.deephit1,this.deephit2,2);
         if(_loc2_ != this.getDeCodeNumber(this.deephit3))
         {
            throw new Error("数据被修改！");
         }
         if(!param1)
         {
            return AUtils.numberAdd(_loc2_,this.getSdhitValue(),2);
         }
         return _loc2_;
      }
      
      public function setstrengthValue(param1:int) : void
      {
         var _loc2_:uint = 2 + Math.round(Math.random() * 3);
         this.strengthValue1 = param1 - _loc2_;
         this.strengthValue2 = _loc2_;
         this.strengthValue3 = this.enCodeValue(param1);
      }
      
      public function getStrengthValue() : int
      {
         if(this.strengthValue1 + this.strengthValue2 != this.getDeCodeValue(this.strengthValue3))
         {
            throw new Error("数据被修改！");
         }
         return this.strengthValue1 + this.strengthValue2;
      }
      
      public function setShpValue(param1:int) : void
      {
         var _loc2_:int = 200 + Math.round(Math.random() * 1000);
         this.shpVal1 = param1 - _loc2_;
         this.shpVal2 = _loc2_;
         this.shpVal3 = this.enCodeValue(param1);
      }
      
      public function getShpValue() : int
      {
         if(this.shpVal1 + this.shpVal2 != this.getDeCodeValue(this.shpVal3))
         {
            throw new Error("数据被修改！");
         }
         return this.shpVal1 + this.shpVal2;
      }
      
      public function setSmpValue(param1:int) : void
      {
         var _loc2_:int = 200 + Math.round(Math.random() * 1000);
         this.smpVal1 = param1 - _loc2_;
         this.smpVal2 = _loc2_;
         this.smpVal3 = this.enCodeValue(param1);
      }
      
      public function getSmpValue() : int
      {
         if(this.smpVal1 + this.smpVal2 != this.getDeCodeValue(this.smpVal3))
         {
            throw new Error("数据被修改！");
         }
         return this.smpVal1 + this.smpVal2;
      }
      
      public function setSatkValue(param1:int) : void
      {
         var _loc2_:int = 200 + Math.round(Math.random() * 1000);
         this.satkVal1 = param1 - _loc2_;
         this.satkVal2 = _loc2_;
         this.satkVal3 = this.enCodeValue(param1);
      }
      
      public function getSatkValue() : int
      {
         if(this.satkVal1 + this.satkVal2 != this.getDeCodeValue(this.satkVal3))
         {
            throw new Error("数据被修改！");
         }
         return this.satkVal1 + this.satkVal2;
      }
      
      public function setSdefValue(param1:int) : void
      {
         var _loc2_:int = 200 + Math.round(Math.random() * 1000);
         this.sdefVal1 = param1 - _loc2_;
         this.sdefVal2 = _loc2_;
         this.sdefVal3 = this.enCodeValue(param1);
      }
      
      public function getSdefValue() : int
      {
         if(this.sdefVal1 + this.sdefVal2 != this.getDeCodeValue(this.sdefVal3))
         {
            throw new Error("数据被修改！");
         }
         return this.sdefVal1 + this.sdefVal2;
      }
      
      public function setSehpValue(param1:int) : void
      {
         var _loc2_:int = 200 + Math.round(Math.random() * 1000);
         this.sehpVal1 = param1 - _loc2_;
         this.sehpVal2 = _loc2_;
         this.sehpVal3 = this.enCodeValue(param1);
      }
      
      public function getSehpValue() : int
      {
         if(this.sehpVal1 + this.sehpVal2 != this.getDeCodeValue(this.sehpVal3))
         {
            throw new Error("数据被修改！");
         }
         return this.sehpVal1 + this.sehpVal2;
      }
      
      public function setSempValue(param1:int) : void
      {
         var _loc2_:int = 200 + Math.round(Math.random() * 1000);
         this.sempVal1 = param1 - _loc2_;
         this.sempVal2 = _loc2_;
         this.sempVal3 = this.enCodeValue(param1);
      }
      
      public function getSempValue() : int
      {
         if(this.sempVal1 + this.sempVal2 != this.getDeCodeValue(this.sempVal3))
         {
            throw new Error("数据被修改！");
         }
         return this.sempVal1 + this.sempVal2;
      }
      
      public function setScritValue(param1:Number) : void
      {
         var _loc2_:Number = (1 + Math.round(Math.random() * 4)) / 100;
         this.scritVal1 = AUtils.numberSub(param1,_loc2_,2);
         this.scritVal2 = AUtils.changeNumber(_loc2_,2);
         this.scritVal3 = this.enCodeNumber(param1);
      }
      
      public function getScritValue() : Number
      {
         var _loc1_:Number = AUtils.numberAdd(this.scritVal1,this.scritVal2,2);
         if(_loc1_ != this.getDeCodeNumber(this.scritVal3))
         {
            throw new Error("数据被修改！");
         }
         return _loc1_;
      }
      
      public function setSmissValue(param1:Number) : void
      {
         var _loc2_:Number = (1 + Math.round(Math.random() * 4)) / 100;
         this.smissVal1 = AUtils.numberSub(param1,_loc2_,2);
         this.smissVal2 = AUtils.changeNumber(_loc2_,2);
         this.smissVal3 = this.enCodeNumber(param1);
      }
      
      public function getSmissValue() : Number
      {
         var _loc1_:Number = AUtils.numberAdd(this.smissVal1,this.smissVal2,2);
         if(_loc1_ != this.getDeCodeNumber(this.smissVal3))
         {
            throw new Error("数据被修改！");
         }
         return _loc1_;
      }
      
      public function setSebolValue(param1:Number) : void
      {
         var _loc2_:Number = (1 + Math.round(Math.random() * 4)) / 100;
         this.sebolVal1 = AUtils.numberSub(param1,_loc2_,2);
         this.sebolVal2 = AUtils.changeNumber(_loc2_,2);
         this.sebolVal3 = this.enCodeNumber(param1);
      }
      
      public function getSebloValue() : Number
      {
         var _loc1_:Number = AUtils.numberAdd(this.sebolVal1,this.sebolVal2,2);
         if(_loc1_ != this.getDeCodeNumber(this.sebolVal3))
         {
            throw new Error("数据被修改！");
         }
         return _loc1_;
      }
      
      public function setSmdefValue(param1:Number) : void
      {
         var _loc2_:Number = (1 + Math.round(Math.random() * 4)) / 100;
         this.smdefVal1 = AUtils.numberSub(param1,_loc2_,2);
         this.smdefVal2 = AUtils.changeNumber(_loc2_,2);
         this.smdefVal3 = this.enCodeNumber(param1);
      }
      
      public function getSmdefValue() : Number
      {
         var _loc1_:Number = AUtils.numberAdd(this.smdefVal1,this.smdefVal2,2);
         if(_loc1_ != this.getDeCodeNumber(this.smdefVal3))
         {
            throw new Error("数据被修改！");
         }
         return _loc1_;
      }
      
      public function setSdhitValue(param1:Number) : void
      {
         var _loc2_:Number = (1 + Math.round(Math.random() * 4)) / 100;
         this.sdhitVal1 = AUtils.numberSub(param1,_loc2_,2);
         this.sdhitVal2 = AUtils.changeNumber(_loc2_,2);
         this.sdhitVal3 = this.enCodeNumber(param1);
      }
      
      public function getSdhitValue() : Number
      {
         var _loc1_:Number = AUtils.numberAdd(this.sdhitVal1,this.sdhitVal2,2);
         if(_loc1_ != this.getDeCodeNumber(this.sdhitVal3))
         {
            throw new Error("数据被修改！");
         }
         return _loc1_;
      }
      
      private function getDeCodeValue(param1:Number) : int
      {
         return Math.round(param1 * 100 + 21);
      }
      
      private function getDeCodeNumber(param1:Number) : Number
      {
         return AUtils.numberAdd(11.5,param1,2);
      }
      
      private function enCodeNumber(param1:Number) : Number
      {
         return AUtils.numberSub(param1,11.5,2);
      }
      
      private function enCodeValue(param1:int) : Number
      {
         return (param1 - 21) / 100;
      }
      
      private function enCodeString(param1:String) : Array
      {
         var _loc2_:uint = param1.length;
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_.push(param1.charAt(_loc4_));
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function getDeCodeString(param1:Array) : String
      {
         var _loc2_:uint = param1.length;
         var _loc3_:String = "";
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ += param1[_loc4_];
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function findUsedByShowId() : String
      {
         var _loc1_:String = "";
         if(this.showid == 100)
         {
            _loc1_ = "zzs";
         }
         else if(this.showid == 101)
         {
            _loc1_ = "bs";
         }
         return _loc1_;
      }
      
      public function isSms() : Boolean
      {
         var _loc1_:int = this.getFillName().indexOf("sms");
         if(_loc1_ != -1)
         {
            return true;
         }
         return false;
      }
      
      public function isMfs() : Boolean
      {
         var _loc1_:int = this.getFillName().indexOf("mfs");
         if(_loc1_ != -1)
         {
            return true;
         }
         return false;
      }
      
      public function isGjs() : Boolean
      {
         var _loc1_:int = this.getFillName().indexOf("gjs");
         if(_loc1_ != -1)
         {
            return true;
         }
         return false;
      }
      
      public function isFys() : Boolean
      {
         var _loc1_:int = this.getFillName().indexOf("fys");
         if(_loc1_ != -1)
         {
            return true;
         }
         return false;
      }
      
      public function isTlz() : Boolean
      {
         var _loc1_:int = this.getFillName().indexOf("tlz");
         if(_loc1_ != -1)
         {
            return true;
         }
         return false;
      }
      
      public function isLlz() : Boolean
      {
         var _loc1_:int = this.getFillName().indexOf("llz");
         if(_loc1_ != -1)
         {
            return true;
         }
         return false;
      }
      
      public function isHlz() : Boolean
      {
         var _loc1_:int = this.getFillName().indexOf("hlz");
         if(_loc1_ != -1)
         {
            return true;
         }
         return false;
      }
      
      public function isFlz() : Boolean
      {
         var _loc1_:int = this.getFillName().indexOf("flz");
         if(_loc1_ != -1)
         {
            return true;
         }
         return false;
      }
      
      public function isSlz() : Boolean
      {
         var _loc1_:int = this.getFillName().indexOf("slz");
         if(_loc1_ != -1)
         {
            return true;
         }
         return false;
      }
      
      private function isCanFallInGame() : Boolean
      {
         if(this.getFillName() == "wpqhs1" || this.getFillName() == "sms1" || this.getFillName() == "mfs1" || this.getFillName() == "fys1" || this.getFillName() == "gjs1" || this.getFillName() == "tlzsp" || this.getFillName() == "llzsp" || this.getFillName() == "hlzsp" || this.getFillName() == "flzsp" || this.getFillName() == "slzsp")
         {
            return true;
         }
         return false;
      }
   }
}
