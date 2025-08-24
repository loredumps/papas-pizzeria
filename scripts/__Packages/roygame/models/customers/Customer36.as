class roygame.models.customers.Customer36 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 36;
   var customername = "PAPA LOUIE!";
   var orders = [[],[[[2,1,0,0,0],[2,0,1,0,0],[2,0,0,1,0],[2,0,0,0,1],[2,1,0,0,0],[2,0,1,0,0],[2,0,0,1,0],4,4]]];
   function Customer36(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 36 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
