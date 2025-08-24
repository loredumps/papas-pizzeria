class roygame.models.PizzaCutter
{
   var x = -84;
   var y = -133;
   var startCutX = 0;
   var startCutY = 0;
   var endCutX = 0;
   var endCutY = 0;
   var cutLines = [];
   var currentline = 0;
   var lines = [];
   function PizzaCutter(pizzaobj)
   {
      var _loc2_ = this;
      _loc2_.pizza = pizzaobj;
      _loc2_.gameObj = _loc2_.pizza.gameObj;
      _loc2_.cutLines = [];
      _loc2_.lines = [];
      _loc2_.setupCutter();
   }
   function redrawPizzaCutter()
   {
      var _loc3_ = this;
      _loc3_.setupCutter();
      var _loc9_ = _loc3_.cutLines.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc9_)
      {
         var _loc7_ = _loc3_.cutLines[_loc2_][0];
         var _loc5_ = _loc3_.cutLines[_loc2_][1];
         var _loc6_ = _loc3_.cutLines[_loc2_][2];
         var _loc4_ = _loc3_.cutLines[_loc2_][3];
         var _loc8_ = _loc2_ + 1;
         _loc3_.drawPizzaCut(_loc7_,_loc5_,_loc6_,_loc4_,false,_loc8_);
         _loc2_ = _loc2_ + 1;
      }
   }
   function setupCutter()
   {
      var cutter = this;
      cutter.clip = cutter.pizza.clip.attachMovie("pizzacutarea","pizzacutarea",40000);
      cutter.clip._x = cutter.x;
      cutter.clip._y = cutter.y;
      cutter.clip.onPress = function()
      {
         cutter.pressCutter();
      };
      cutter.clip.onRelease = function()
      {
         cutter.releaseCutter();
      };
      cutter.clip.onReleaseOutside = function()
      {
         cutter.releaseCutter();
      };
   }
   function pressCutter()
   {
      var cutter = this;
      var _loc2_ = cutter.gameObj;
      var _loc3_ = _loc2_.pauseManager.isPaused;
      if(!_loc3_)
      {
         cutter.startCutX = cutter.clip._xmouse;
         cutter.startCutY = cutter.clip._ymouse;
         cutter.addDottedLine();
         _loc2_.soundEngine.playSound("dottedline.wav","loop");
         cutter.clip.onEnterFrame = function()
         {
            cutter.drawDottedLine();
         };
      }
   }
   function addDottedLine()
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.lines.length + 1;
      var _loc5_ = "line" + _loc4_;
      var _loc6_ = 100 + _loc4_;
      var _loc3_ = _loc2_.clip.attachMovie("pizzacut",_loc5_,_loc6_);
      _loc3_._x = _loc2_.startCutX;
      _loc3_._y = _loc2_.startCutY;
      _loc3_.shape._width = 1;
      _loc2_.currentline = _loc3_;
      _loc2_.lines.push(_loc3_);
   }
   function drawPizzaCut(x1, y1, x2, y2, animate, linenum)
   {
      var _loc4_ = this;
      var _loc14_ = _loc4_.gameObj;
      var _loc17_ = _loc4_.currentline;
      var _loc7_ = linenum;
      var _loc8_ = "cut" + _loc7_;
      var _loc13_ = 100 + _loc7_;
      var _loc16_ = 10000 + _loc7_;
      var _loc6_ = x2 - x1;
      var _loc5_ = y2 - y1;
      var _loc10_ = Math.sqrt(_loc6_ * _loc6_ + _loc5_ * _loc5_);
      var _loc15_ = Math.atan2(_loc5_,_loc6_);
      var _loc9_ = _loc15_ * 57.29577951308232;
      var _loc2_ = _loc4_.clip.attachMovie("pizza_cut_animation",_loc8_,_loc13_);
      _loc2_._x = x1;
      _loc2_._y = y1;
      _loc2_._rotation = _loc9_;
      _loc2_.shape._width = _loc10_;
      var _loc3_ = _loc4_.clip.attachMovie("pizza_cut_animation_top",_loc8_,_loc16_);
      _loc3_._x = x1;
      _loc3_._y = y1;
      _loc3_._rotation = _loc9_;
      _loc3_.shape._width = _loc10_;
      if(animate == false)
      {
         _loc2_.shape.gotoAndStop(6);
         _loc3_.shape.gotoAndStop(6);
      }
      else
      {
         _loc14_.soundEngine.playSound("cut.wav");
      }
   }
   function undrawDottedLine()
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.currentline;
      _loc2_.removeMovieClip();
   }
   function releaseCutter()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      var _loc4_ = _loc3_.pauseManager.isPaused;
      if(!_loc4_)
      {
         _loc2_.endCutX = _loc2_.clip._xmouse;
         _loc2_.endCutY = _loc2_.clip._ymouse;
         _loc3_.soundEngine.playSound(0);
         _loc2_.checkLineIntersection();
         delete _loc2_.clip.onEnterFrame;
      }
   }
   function checkLineIntersection()
   {
      var _loc2_ = this;
      var _loc20_ = _loc2_.gameObj;
      var _loc27_ = _loc2_.startCutX;
      var _loc25_ = _loc2_.endCutX;
      var _loc26_ = _loc2_.startCutY;
      var _loc24_ = _loc2_.endCutY;
      var _loc35_ = _loc25_ - _loc27_;
      var _loc31_ = _loc24_ - _loc26_;
      var _loc3_ = Math.sqrt(_loc35_ * _loc35_ + _loc31_ * _loc31_);
      var _loc21_ = _loc2_.pizza.clip.shell._width / 2;
      var _loc22_ = Math.abs(_loc2_.x) + _loc21_;
      var _loc17_ = Math.abs(_loc2_.y) + _loc21_;
      var _loc16_ = _loc27_ - _loc22_;
      var _loc13_ = _loc25_ - _loc22_;
      var _loc14_ = _loc26_ - _loc17_;
      var _loc12_ = _loc24_ - _loc17_;
      var _loc8_ = _loc12_ - _loc14_;
      var _loc11_ = _loc13_ - _loc16_;
      var _loc9_ = _loc16_ * _loc12_ - _loc13_ * _loc14_;
      var _loc15_ = _loc21_ * _loc21_ * (_loc3_ * _loc3_) - _loc9_ * _loc9_;
      if(_loc15_ > 0)
      {
         var _loc23_ = undefined;
         if(_loc8_ < 0)
         {
            _loc23_ = -1;
         }
         else
         {
            _loc23_ = 1;
         }
         var _loc7_ = (_loc9_ * _loc8_ + _loc23_ * _loc11_ * Math.sqrt(_loc15_)) / (_loc3_ * _loc3_);
         var _loc5_ = (_loc9_ * _loc8_ - _loc23_ * _loc11_ * Math.sqrt(_loc15_)) / (_loc3_ * _loc3_);
         var _loc6_ = (-1 * (_loc9_ * _loc11_) + Math.abs(_loc8_) * Math.sqrt(_loc15_)) / (_loc3_ * _loc3_);
         var _loc4_ = (-1 * (_loc9_ * _loc11_) - Math.abs(_loc8_) * Math.sqrt(_loc15_)) / (_loc3_ * _loc3_);
         var _loc29_ = _loc5_ - _loc7_;
         var _loc28_ = _loc4_ - _loc6_;
         var _loc32_ = Math.sqrt(_loc29_ * _loc29_ + _loc28_ * _loc28_);
         if(_loc8_ >= 0)
         {
            var _loc39_ = _loc7_;
            var _loc38_ = _loc6_;
            _loc7_ = _loc5_;
            _loc6_ = _loc4_;
            _loc5_ = _loc39_;
            _loc4_ = _loc38_;
         }
         var _loc19_ = undefined;
         var _loc18_ = undefined;
         if(_loc11_ >= 0)
         {
            if(_loc16_ <= _loc7_ && _loc7_ <= _loc5_ && _loc5_ <= _loc13_)
            {
               _loc19_ = true;
            }
            else
            {
               _loc19_ = false;
            }
         }
         else if(_loc13_ < _loc5_ && _loc5_ < _loc7_ && _loc7_ < _loc16_)
         {
            _loc19_ = true;
         }
         else
         {
            _loc19_ = false;
         }
         if(_loc8_ >= 0)
         {
            if(_loc14_ <= _loc6_ && _loc6_ <= _loc4_ && _loc4_ <= _loc12_)
            {
               _loc18_ = true;
            }
            else
            {
               _loc18_ = false;
            }
         }
         else if(_loc12_ < _loc4_ && _loc4_ < _loc6_ && _loc6_ < _loc14_)
         {
            _loc18_ = true;
         }
         else
         {
            _loc18_ = false;
         }
         if(_loc32_ < _loc3_ + 20 && _loc19_ && _loc18_)
         {
            var _loc33_ = _loc7_ + _loc22_;
            var _loc36_ = _loc5_ + _loc22_;
            var _loc30_ = _loc6_ + _loc17_;
            var _loc34_ = _loc4_ + _loc17_;
            _loc2_.undrawDottedLine();
            var _loc37_ = _loc2_.cutLines.length + 1;
            _loc2_.drawPizzaCut(_loc33_,_loc30_,_loc36_,_loc34_,true,_loc37_);
            var _loc10_ = [];
            _loc10_.push(_loc33_);
            _loc10_.push(_loc30_);
            _loc10_.push(_loc36_);
            _loc10_.push(_loc34_);
            _loc2_.cutLines.push(_loc10_);
            if(_loc20_.training)
            {
               if(_loc20_.trainingManager.currentStep == 21 || _loc20_.trainingManager.currentStep == 20)
               {
                  if(_loc2_.cutLines.length >= 2)
                  {
                     _loc20_.trainingManager.finishedStep(21);
                  }
               }
            }
            trace("Good Cut Line");
         }
         else
         {
            trace("Not Good Cut.  Data: pizzacutdist: " + _loc32_ + ", drawlinedist: " + _loc3_ + " | " + _loc16_ + ", " + _loc7_ + ", " + _loc13_ + ", " + _loc5_ + ", " + _loc14_ + ", " + _loc6_ + ", " + _loc12_ + ", " + _loc4_);
            _loc2_.undrawDottedLine();
         }
      }
      else
      {
         _loc2_.undrawDottedLine();
      }
   }
   function drawDottedLine()
   {
      var _loc2_ = this;
      var _loc5_ = _loc2_.currentline;
      var _loc9_ = _loc2_.startCutX;
      var _loc7_ = _loc2_.startCutY;
      var _loc6_ = _loc2_.clip._xmouse;
      var _loc12_ = _loc2_.clip._ymouse;
      var _loc4_ = _loc6_ - _loc9_;
      var _loc3_ = _loc12_ - _loc7_;
      var _loc10_ = Math.sqrt(_loc4_ * _loc4_ + _loc3_ * _loc3_);
      var _loc11_ = Math.atan2(_loc3_,_loc4_);
      var _loc8_ = _loc11_ * 57.29577951308232;
      _loc5_._rotation = _loc8_;
      _loc5_.shape._width = _loc10_;
   }
   function pauseUpdate(msg)
   {
   }
}
