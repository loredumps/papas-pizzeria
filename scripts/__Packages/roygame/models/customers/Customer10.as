class roygame.models.customers.Customer10 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 10;
   var customername = "Taylor";
   var orders = [[],[[[0],[0],[0],[2,1,1,0,0],[6,1,1,0,0],[0],[0],3,4]]];
   function Customer10(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 10 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
