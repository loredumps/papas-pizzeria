class roygame.models.customers.Customer27 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 27;
   var customername = "Clair";
   var orders = [[],[[[4,1,1,1,1],[0],[6,0,0,1,1],[4,0,1,0,0],[0],[0],[0],4,4]]];
   function Customer27(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 27 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
