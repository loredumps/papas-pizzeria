class roygame.models.customers.Customer30 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 30;
   var customername = "Peggy";
   var orders = [[],[[[0],[0],[0],[0],[4,1,1,1,1],[6,1,1,1,0],[0],3,8]]];
   function Customer30(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 30 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
