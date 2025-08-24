class roygame.models.customers.Customer17 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 17;
   var customername = "Mary";
   var orders = [[],[[[8,1,1,1,1],[0],[0],[0],[0],[0],[0],2,4]]];
   function Customer17(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 17 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
