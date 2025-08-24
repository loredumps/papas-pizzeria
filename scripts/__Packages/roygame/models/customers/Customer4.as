class roygame.models.customers.Customer4 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 4;
   var customername = "Marty";
   var orders = [[],[[[0],[0],[0],[0],[0],[6,1,1,0,0],[0],3,4]]];
   function Customer4(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 4 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
