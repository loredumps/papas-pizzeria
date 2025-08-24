class roygame.models.PizzaManager
{
   var totalPizzas = 0;
   var pizzas = [];
   function PizzaManager(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.totalPizzas = 0;
      _loc2_.pizzas = [];
      _loc2_.gameObj.pauseManager.addPauseListener(this);
   }
   function addPizza(where)
   {
      var _loc2_ = this;
      var _loc5_ = _loc2_.gameObj;
      var _loc3_ = _loc2_.totalPizzas + 1;
      var _loc4_ = "pizza" + _loc3_;
      _loc2_[_loc4_] = new roygame.models.Pizza(_loc5_,where,_loc3_);
      _loc2_.totalPizzas = _loc2_.totalPizzas + 1;
      _loc2_.pizzas.push(_loc4_);
   }
   function deletePizza(whichpizza)
   {
      var _loc3_ = this;
      var _loc6_ = _loc3_.gameObj;
      var _loc5_ = whichpizza;
      var _loc4_ = "pizza" + _loc5_.id;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.pizzas.length)
      {
         if(_loc3_.pizzas[_loc2_] == _loc4_)
         {
         }
         _loc2_ = _loc2_ + 1;
      }
      _loc6_.pauseManager.removePauseListener(_loc5_);
      _loc5_.clip.removeMovieClip();
      delete _loc3_[_loc4_];
      _loc3_[_loc4_] = null;
   }
   function pauseUpdate(msg)
   {
   }
}
