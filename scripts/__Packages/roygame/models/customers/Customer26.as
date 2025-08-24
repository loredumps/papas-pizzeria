class roygame.models.customers.Customer26 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 26;
   var customername = "Tohru";
   var orders = [[],[[[0],[0],[6,0,0,1,1],[2,1,0,0,0],[0],[0],[8,1,1,1,1],2,8]]];
   function Customer26(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 26 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
