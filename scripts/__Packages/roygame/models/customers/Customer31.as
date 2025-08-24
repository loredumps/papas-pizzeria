class roygame.models.customers.Customer31 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 31;
   var customername = "Carlo Romano";
   var orders = [[],[[[0],[4,1,1,0,0],[6,0,0,1,1],[4,0,1,0,0],[0],[0],[0],4,8]]];
   function Customer31(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 31 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
