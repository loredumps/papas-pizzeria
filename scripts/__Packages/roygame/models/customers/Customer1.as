class roygame.models.customers.Customer1 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 1;
   var customername = "Cooper";
   var orders = [[],[[[4,0,0,1,1],[0],[0],[0],[0],[0],[0],1,4]]];
   function Customer1(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 1 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
