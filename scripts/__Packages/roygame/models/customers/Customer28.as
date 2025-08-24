class roygame.models.customers.Customer28 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 28;
   var customername = "Clover";
   var orders = [[],[[[8,1,1,1,1],[0],[0],[0],[0],[0],[0],4,8]]];
   function Customer28(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 28 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
