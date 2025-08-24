class roygame.models.customers.Customer2 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 2;
   var customername = "Wally";
   var orders = [[],[[[0],[0],[0],[0],[0],[0],[8,1,1,1,1],2,8]]];
   function Customer2(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 2 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
