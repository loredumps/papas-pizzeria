class roygame.models.customers.Customer32 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 32;
   var customername = "Little Edoardo";
   var orders = [[],[[[0],[0],[0],[0],[4,1,1,1,1],[4,1,1,1,1],[4,1,1,1,1],5,8]]];
   function Customer32(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 32 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
