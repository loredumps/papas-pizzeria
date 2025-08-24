class roygame.models.TicketManager
{
   var totalTickets = 0;
   var tickets = [];
   function TicketManager(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.totalTickets = 0;
      _loc2_.tickets = [];
      _loc2_.gameObj.pauseManager.addPauseListener(this);
   }
   function AddTicket(ordernum, orderdata, customer)
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj;
      var _loc3_ = "ticket" + ordernum;
      _loc2_[_loc3_] = new roygame.models.Ticket(_loc4_,ordernum,orderdata,customer);
      _loc2_.totalTickets = _loc2_.totalTickets + 1;
      _loc2_.tickets.push(_loc3_);
   }
   function deleteTicket(whichticket)
   {
      var _loc3_ = this;
      var _loc6_ = _loc3_.gameObj;
      var _loc5_ = whichticket;
      var _loc4_ = "ticket" + _loc5_.orderNumber;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.tickets.length)
      {
         if(_loc3_.tickets[_loc2_] == _loc4_)
         {
         }
         _loc2_ = _loc2_ + 1;
      }
      if(_loc6_.hudObj.activeTicket == _loc5_.orderNumber)
      {
         _loc6_.hudObj.setActiveTicket(0);
      }
      _loc6_.pauseManager.removePauseListener(_loc5_);
      _loc5_.clip.removeMovieClip();
      delete _loc3_[_loc4_];
      _loc3_[_loc4_] = null;
   }
   function sortDepths()
   {
      var _loc3_ = this;
      var _loc10_ = _loc3_.gameObj;
      var _loc4_ = [];
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.tickets.length)
      {
         var _loc6_ = _loc3_.tickets[_loc2_];
         var _loc7_ = _loc3_[_loc6_].clip.getDepth();
         _loc4_.push({name:String(_loc6_),depth:_loc7_});
         _loc2_ = _loc2_ + 1;
      }
      _loc4_.sortOn("depth");
      _loc2_ = 0;
      while(_loc2_ < _loc4_.length)
      {
         _loc6_ = _loc4_[_loc2_].name;
         var _loc5_ = 1000 + (_loc2_ + 1);
         _loc3_[_loc6_].clip.swapDepths(_loc5_);
         _loc2_ = _loc2_ + 1;
      }
   }
   function pauseUpdate(msg)
   {
   }
}
