class roygame.models.customers.Customer3 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 3;
   var customername = "Rita";
   var orders = [[],[[[0],[0],[6,0,1,1,0],[0],[0],[0],[0],4,4]]];
   function Customer3(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 3 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
