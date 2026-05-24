package
{
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class colourful_circle extends MovieClip
   {
       
      
      public var maxNum:int;
      
      public var mcAry:Array;
      
      public function colourful_circle()
      {
         super();
         this.maxNum = 1;
         this.mcAry = new Array();
         trace("mouseUI added");
      }
      
      public function MouseMoveEvent(param1:MouseEvent) : void
      {
         var _loc2_:* = 0;
         while(_loc2_ < this.maxNum)
         {
            this.mcAry.push(new Circle());
            parent.addChild(this.mcAry[this.mcAry.length - 1]);
            this.mcAry[this.mcAry.length - 1].initView(Math.random() * 16777215,Math.random() * 4);
            this.mcAry[this.mcAry.length - 1].x = this.mouseX - Math.random() * 15 + Math.random() * 15;
            this.mcAry[this.mcAry.length - 1].y = this.mouseY - Math.random() * 15 + Math.random() * 15;
            this.mcAry[this.mcAry.length - 1].rotation = Math.random() * 360;
            _loc2_++;
         }
      }
   }
}
