class roygame.models.Topping
{
   var whichTopping = 1;
   var id = 1;
   var onPizza = false;
   var lastx = 0;
   var lasty = 0;
   var speedSteps = 2;
   function Topping(gameobj, which, id, dragging, pizza)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.whichTopping = which;
      _loc2_.id = id;
      _loc2_.whichPizza = pizza;
      _loc2_.x = _loc2_.whichPizza.clip._xmouse;
      _loc2_.y = _loc2_.whichPizza.clip._ymouse;
      _loc2_.rotation = random(360);
      _loc2_.attachTopping(dragging,true);
   }
   function attachTopping(dragging, draggable)
   {
      var topping = this;
      var _loc5_ = topping.gameObj;
      var _loc2_ = "topping" + topping.id;
      var _loc3_ = 500 + topping.id;
      var _loc4_ = topping.whichPizza;
      topping.clip = _loc4_.clip.attachMovie("topping",_loc2_,_loc3_);
      topping.clip._x = topping.x;
      topping.clip._y = topping.y;
      topping.clip._rotation = topping.rotation;
      topping.clip.gotoAndStop(topping.whichTopping);
      if(draggable)
      {
         topping.clip.onPress = function()
         {
            topping.dragTopping();
         };
         topping.clip.onRelease = function()
         {
            topping.stopDragTopping();
         };
         topping.clip.onReleaseOutside = function()
         {
            topping.stopDragTopping();
         };
         if(dragging)
         {
            topping.dragTopping();
         }
      }
   }
   function changeCookLook(which)
   {
      var _loc2_ = this;
      _loc2_.clip.look.gotoAndStop(which + 1);
   }
   function dragTopping()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      if(!_loc3_.pauseManager.isPaused)
      {
         _loc2_.lastx = _loc2_.clip._x;
         _loc2_.lasty = _loc2_.clip._y;
         _loc3_.soundEngine.playSound("grabtopping.wav");
         _loc2_.clip.startDrag(true);
      }
   }
   function stopDragTopping()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      var _loc5_ = _loc2_.whichTopping;
      var _loc4_ = _loc3_.toppingScreen.clip;
      if(!_loc3_.pauseManager.isPaused)
      {
         _loc2_.clip.stopDrag();
         if(_loc2_.checkDroppedOnPizza())
         {
            _loc2_.x = _loc2_.clip._x;
            _loc2_.y = _loc2_.clip._y;
            _loc3_.soundEngine.playSound("droptopping.wav");
         }
         else if(_loc2_.checkDroppedInCup())
         {
            _loc2_.removeTopping();
            _loc3_.soundEngine.playSound("grabtopping.wav");
         }
         else
         {
            _loc2_.moveToppingBack();
         }
      }
   }
   function moveToppingBack()
   {
      var topping = this;
      topping.targetx = topping.lastx;
      topping.targety = topping.lasty;
      topping.clip.onEnterFrame = function()
      {
         topping.moveTopping();
      };
   }
   function moveTopping()
   {
      var _loc2_ = this;
      var _loc5_ = _loc2_.gameObj;
      var _loc7_ = _loc2_.targetx - _loc2_.clip._x;
      var _loc6_ = _loc2_.targety - _loc2_.clip._y;
      var _loc4_ = _loc7_ / _loc2_.speedSteps;
      var _loc3_ = _loc6_ / _loc2_.speedSteps;
      if(Math.abs(_loc4_) < 1 && Math.abs(_loc3_) < 1)
      {
         _loc2_.clip._x = _loc2_.targetx;
         _loc2_.clip._y = _loc2_.targety;
         _loc2_.x = _loc2_.targetx;
         _loc2_.y = _loc2_.targety;
         if(_loc2_.checkDroppedInCup())
         {
            _loc2_.removeTopping();
            _loc5_.soundEngine.playSound("grabtopping.wav");
         }
         else
         {
            _loc5_.soundEngine.playSound("droptopping.wav");
         }
         delete _loc2_.clip.onEnterFrame;
      }
      else
      {
         _loc2_.clip._x += _loc4_;
         _loc2_.clip._y += _loc3_;
      }
   }
   function checkDroppedOnPizza()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.whichPizza;
      var _loc5_ = _loc2_.clip._x - _loc3_.clip.center._x;
      var _loc4_ = _loc2_.clip._y - _loc3_.clip.center._y;
      var _loc6_ = _loc2_.clip._width / 2 + _loc3_.clip.center._width / 2;
      var _loc7_ = Math.sqrt(_loc5_ * _loc5_ + _loc4_ * _loc4_);
      if(_loc7_ < _loc6_)
      {
         return true;
      }
      return false;
   }
   function checkDroppedInCup()
   {
      var _loc4_ = this;
      var _loc3_ = _loc4_.whichTopping;
      var _loc12_ = _loc4_.gameObj;
      var _loc5_ = _loc12_.toppingScreen.clip;
      var _loc6_ = _loc4_.whichPizza;
      var _loc2_ = "";
      if(_loc3_ == 1)
      {
         _loc2_ = "cup_pepperoni";
      }
      else if(_loc3_ == 2)
      {
         _loc2_ = "cup_sausage";
      }
      else if(_loc3_ == 3)
      {
         _loc2_ = "cup_mushroom";
      }
      else if(_loc3_ == 4)
      {
         _loc2_ = "cup_pepper";
      }
      else if(_loc3_ == 5)
      {
         _loc2_ = "cup_onion";
      }
      else if(_loc3_ == 6)
      {
         _loc2_ = "cup_olive";
      }
      else if(_loc3_ == 7)
      {
         _loc2_ = "cup_anchovy";
      }
      var _loc9_ = _loc4_.clip._x + _loc6_.clip._x;
      var _loc10_ = _loc4_.clip._y + _loc6_.clip._y;
      var _loc15_ = _loc5_[_loc2_].center._x + _loc5_[_loc2_]._x;
      var _loc13_ = _loc5_[_loc2_].center._y + _loc5_[_loc2_]._y;
      var _loc8_ = _loc9_ - _loc15_;
      var _loc7_ = _loc10_ - _loc13_;
      var _loc11_ = _loc4_.clip._width / 2 + _loc5_[_loc2_].center._width / 2;
      var _loc14_ = Math.sqrt(_loc8_ * _loc8_ + _loc7_ * _loc7_);
      if(_loc14_ < _loc11_)
      {
         return true;
      }
      return false;
   }
   function removeTopping()
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj;
      var _loc3_ = _loc2_.whichPizza;
      _loc3_.removeTopping(_loc2_.id);
   }
   function pauseUpdate(msg)
   {
   }
}
