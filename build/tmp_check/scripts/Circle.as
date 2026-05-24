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
   
   public dynamic class Circle extends MovieClip
   {
       
      
      public var _color:uint;
      
      public var _speed:Number;
      
      public var i:Number;
      
      public var _rad:Number;
      
      public var _circle:Shape;
      
      public function Circle()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function initView(param1:uint, param2:Number) : void
      {
         this._color = param1;
         this._speed = 2;
         this._rad = param2;
         this.drawCircle();
         this.addEventListener(Event.ENTER_FRAME,this.changeAlpha);
      }
      
      public function drawCircle() : void
      {
         this._circle = new Shape();
         this._circle.graphics.beginFill(this._color,1);
         this._circle.graphics.drawCircle(0,0,this._rad);
         this._circle.graphics.endFill();
         this.addChild(this._circle);
      }
      
      public function changeAlpha(param1:Event) : void
      {
         this._circle.x += 1.5;
         this._circle.alpha -= 0.05;
         if(this._circle.alpha < 0.05)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.changeAlpha);
            parent.removeChild(this);
         }
      }
      
      function frame1() : *
      {
         this._color = 0;
         this._speed = 0;
         this.i = 0;
         this._rad = 0;
      }
   }
}
