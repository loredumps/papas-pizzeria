class roygame.models.customers.Customer20 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 20;
   var customername = "James";
   var orders = [[],[[[0],[4,1,1,0,0],[0],[0],[0],[8,0,1,1,0],[0],2,4]]];
   function Customer20(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 20 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
